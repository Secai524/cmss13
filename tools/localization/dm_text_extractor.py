#!/usr/bin/env python3
"""
CMSS13 DM Text Extractor / 汉化文本提取工具 (完整版)
=====================================================
提取 DM 代码中所有需要翻译的文本，保留变量占位符。

用法:
    python dm_text_extractor.py extract [--output translations.json] [--path code/]
    python dm_text_extractor.py inject [--input translations_cn.json]
"""

import os
import re
import json
import argparse
import hashlib
from pathlib import Path
from typing import Dict, List, Tuple, Optional, Set
from dataclasses import dataclass, asdict
from enum import Enum

class TextType(Enum):
    """文本类型枚举"""
    NAME = "name"
    DESC = "desc"
    MESSAGE = "message"
    CHAT = "chat"
    VISIBLE_MSG = "visible_message"
    ATTACK_VERB = "attack_verb"
    UI_TEXT = "ui_text"
    SAY = "say"
    EMOTE = "emote"
    BROADCAST = "broadcast"
    ALERT = "alert"
    POPUP = "popup"
    EXAMINE = "examine"
    ACTION = "action"
    TOOLTIP = "tooltip"
    LABEL = "label"
    OTHER = "other"

@dataclass
class ExtractedText:
    """提取的文本数据结构"""
    id: str                    # 唯一标识符 (基于文件路径+行号+内容的hash)
    file_path: str             # 源文件路径
    line_number: int           # 行号
    text_type: str             # 文本类型
    original: str              # 原始文本
    context: str               # 上下文 (前后几行代码)
    variables: List[str]       # 包含的变量占位符
    translation: str = ""      # 翻译后的文本 (初始为空)

class DMTextExtractor:
    """DM 代码文本提取器 - 完整版"""

    # 需要提取的属性模式 (扩展版)
    PROPERTY_PATTERNS = [
        # 基础属性
        (r'^\s*name\s*=\s*"([^"]*)"', TextType.NAME),
        (r"^\s*name\s*=\s*'([^']*)'", TextType.NAME),
        (r'^\s*desc\s*=\s*"([^"]*(?:\\.[^"]*)*)"', TextType.DESC),

        # 消息属性
        (r'^\s*message\s*=\s*"([^"]*)"', TextType.MESSAGE),
        (r'^\s*message_param\s*=\s*"([^"]*)"', TextType.MESSAGE),
        (r'^\s*alt_message\s*=\s*"([^"]*)"', TextType.MESSAGE),
        (r'^\s*emote_message\s*=\s*"([^"]*)"', TextType.EMOTE),
        (r'^\s*say_message\s*=\s*"([^"]*)"', TextType.SAY),
        (r'^\s*self_message\s*=\s*"([^"]*)"', TextType.MESSAGE),
        (r'^\s*target_message\s*=\s*"([^"]*)"', TextType.MESSAGE),
        (r'^\s*observer_message\s*=\s*"([^"]*)"', TextType.MESSAGE),

        # 表情相关
        (r'^\s*key\s*=\s*"([^"]+)"', TextType.EMOTE),
        (r'^\s*key_third_person\s*=\s*"([^"]+)"', TextType.EMOTE),

        # 动作/按钮文本
        (r'^\s*action_name\s*=\s*"([^"]*)"', TextType.ACTION),
        (r'^\s*button_name\s*=\s*"([^"]*)"', TextType.ACTION),
        (r'^\s*ability_name\s*=\s*"([^"]*)"', TextType.ACTION),

        # 提示文本
        (r'^\s*tooltip\s*=\s*"([^"]*)"', TextType.TOOLTIP),
        (r'^\s*hint\s*=\s*"([^"]*)"', TextType.TOOLTIP),
        (r'^\s*help_text\s*=\s*"([^"]*)"', TextType.TOOLTIP),

        # 标签
        (r'^\s*label\s*=\s*"([^"]*)"', TextType.LABEL),
        (r'^\s*title\s*=\s*"([^"]*)"', TextType.LABEL),
        (r'^\s*header\s*=\s*"([^"]*)"', TextType.LABEL),

        # 显示名称
        (r'^\s*display_name\s*=\s*"([^"]*)"', TextType.NAME),
        (r'^\s*real_name\s*=\s*"([^"]*)"', TextType.NAME),
        (r'^\s*full_name\s*=\s*"([^"]*)"', TextType.NAME),
    ]

    # 函数调用中的文本模式 (扩展版)
    FUNCTION_PATTERNS = [
        # to_chat 消息
        (r'to_chat\s*\([^,]+,\s*SPAN_\w+\s*\(\s*"([^"]*(?:\\.[^"]*)*)"', TextType.CHAT),
        (r'to_chat\s*\([^,]+,\s*"([^"]*(?:\\.[^"]*)*)"', TextType.CHAT),

        # visible_message
        (r'visible_message\s*\(\s*SPAN_\w+\s*\(\s*"([^"]*(?:\\.[^"]*)*)"', TextType.VISIBLE_MSG),
        (r'visible_message\s*\(\s*"([^"]*(?:\\.[^"]*)*)"', TextType.VISIBLE_MSG),

        # show_message
        (r'show_message\s*\(\s*SPAN_\w+\s*\(\s*"([^"]*(?:\\.[^"]*)*)"', TextType.VISIBLE_MSG),
        (r'show_message\s*\(\s*"([^"]*(?:\\.[^"]*)*)"', TextType.VISIBLE_MSG),

        # affected_message
        (r'affected_message\s*\([^,]+,\s*SPAN_\w+\s*\(\s*"([^"]*(?:\\.[^"]*)*)"', TextType.VISIBLE_MSG),

        # UI 输入/提示
        (r'tgui_input_list\s*\([^,]+,\s*"([^"]*)"', TextType.UI_TEXT),
        (r'tgui_input_text\s*\([^,]+,\s*"([^"]*)"', TextType.UI_TEXT),
        (r'tgui_input_number\s*\([^,]+,\s*"([^"]*)"', TextType.UI_TEXT),
        (r'tgui_alert\s*\([^,]+,\s*"([^"]*)"', TextType.ALERT),
        (r'alert\s*\([^,]*,?\s*"([^"]*)"', TextType.ALERT),

        # input 对话框
        (r'input\s*\([^,]+,\s*"([^"]*)"', TextType.UI_TEXT),

        # 广播/公告
        (r'broadcast\s*\(\s*"([^"]*(?:\\.[^"]*)*)"', TextType.BROADCAST),
        (r'announce\s*\(\s*"([^"]*(?:\\.[^"]*)*)"', TextType.BROADCAST),
        (r'marine_announcement\s*\(\s*"([^"]*(?:\\.[^"]*)*)"', TextType.BROADCAST),
        (r'xeno_announcement\s*\(\s*"([^"]*(?:\\.[^"]*)*)"', TextType.BROADCAST),
        (r'ai_announcement\s*\(\s*"([^"]*(?:\\.[^"]*)*)"', TextType.BROADCAST),
        (r'command_announcement\s*\([^,]*,\s*"([^"]*(?:\\.[^"]*)*)"', TextType.BROADCAST),

        # say/whisper/emote
        (r'\.say\s*\(\s*"([^"]*(?:\\.[^"]*)*)"', TextType.SAY),
        (r'\.whisper\s*\(\s*"([^"]*(?:\\.[^"]*)*)"', TextType.SAY),
        (r'\.emote\s*\(\s*"([^"]*)"', TextType.EMOTE),

        # examine 文本
        (r'examine_text\s*\+=?\s*"([^"]*(?:\\.[^"]*)*)"', TextType.EXAMINE),
        (r'\.examine\s*\([^)]*\)\s*\n\s*\.\s*\+=?\s*"([^"]*(?:\\.[^"]*)*)"', TextType.EXAMINE),

        # balloon_alert
        (r'balloon_alert\s*\([^,]+,\s*"([^"]*)"', TextType.ALERT),

        # playsound 中的消息 (有些会显示)
        (r'audible_message\s*\(\s*"([^"]*(?:\\.[^"]*)*)"', TextType.VISIBLE_MSG),
    ]

    # 列表类型的文本 (如 attack_verb)
    LIST_PATTERNS = [
        (r'attack_verb\s*=\s*list\s*\(([^)]+)\)', TextType.ATTACK_VERB),
        (r'verb_say\s*=\s*list\s*\(([^)]+)\)', TextType.SAY),
        (r'verb_ask\s*=\s*list\s*\(([^)]+)\)', TextType.SAY),
        (r'verb_exclaim\s*=\s*list\s*\(([^)]+)\)', TextType.SAY),
        (r'verb_yell\s*=\s*list\s*\(([^)]+)\)', TextType.SAY),
        (r'emote_see\s*=\s*list\s*\(([^)]+)\)', TextType.EMOTE),
    ]

    # 变量占位符模式 - 这些在翻译时需要保留
    VARIABLE_PATTERNS = [
        r'\[[\w.]+\]',           # [var], [src.name], [user]
        r'\\the\s+\[[\w.]+\]',   # \the [src]
        r'\\The\s+\[[\w.]+\]',   # \The [src]
        r'\\a\s+\[[\w.]+\]',     # \a [src]
        r'\\an\s+\[[\w.]+\]',    # \an [src]
        r'\\his',                # \his
        r'\\her',                # \her
        r'\\him',                # \him
        r'\\himself',            # \himself
        r'\\herself',            # \herself
        r'\\hers',               # \hers
        r'\\proper',             # \proper
        r'\\improper',           # \improper
        r'\\th',                 # \th (ordinal)
        r'\\s',                  # \s (plural)
        r'%t',                   # %t (emote target)
        r'<[^>]+>',              # HTML tags like <b>, </b>
        r'\{[^}]+\}',            # {variables}
    ]

    # 需要跳过的文本模式 (不需要翻译)
    SKIP_PATTERNS = [
        r'^[\s\d\W]*$',          # 纯数字/符号/空白
        r'^[A-Z_]+$',            # 全大写常量
        r'^[A-Z][A-Z_\d]+$',     # 常量格式
        r'^\s*$',                # 空字符串
        r'^[\w/\\]+\.(?:dm|dmi|ogg|wav|png|gif|mp3|json|txt)$',  # 文件路径
        r'^#[\da-fA-F]{3,8}$',   # 颜色代码
        r'^\d+(?:\.\d+)?$',      # 纯数字
        r'^[a-z_]+$',            # 纯小写标识符 (可能是变量名)
        r'^[a-z_][a-z_\d]*$',    # 标识符格式
        r'^https?://',           # URL
        r'^[\w-]+@[\w-]+',       # 邮箱格式
        r'^\[[\w.]+\]$',         # 纯变量引用
        r'^\\',                  # 以反斜杠开头的转义序列
        r'^<[^>]+>$',            # 纯 HTML 标签
        r'^icon\s*=',            # icon 赋值
        r'^sound\s*=',           # sound 赋值
        r'^\d+x\d+$',            # 尺寸格式 如 32x32
        r'^[A-Z]{2,5}\d*$',      # 缩写如 USCM, PMC
        r'^[\w_]+\.(png|dmi|ogg|wav)$',  # 资源文件名
    ]

    # 需要跳过的文件/目录
    SKIP_DIRS = [
        '__pycache__',
        '.git',
        'node_modules',
        'tgui',  # tgui 有自己的翻译系统
    ]

    def __init__(self, base_path: str):
        self.base_path = Path(base_path)
        self.extracted_texts: List[ExtractedText] = []
        self.seen_texts: Set[str] = set()  # 用于去重

    def generate_id(self, file_path: str, line_number: int, text: str) -> str:
        """生成唯一标识符"""
        content = f"{file_path}:{line_number}:{text}"
        return hashlib.md5(content.encode()).hexdigest()[:12]

    def extract_variables(self, text: str) -> List[str]:
        """提取文本中的变量占位符"""
        variables = []
        for pattern in self.VARIABLE_PATTERNS:
            matches = re.findall(pattern, text)
            variables.extend(matches)
        return list(set(variables))  # 去重

    def should_skip(self, text: str) -> bool:
        """判断文本是否应该跳过"""
        # 空或太短
        if not text or len(text.strip()) < 2:
            return True

        for pattern in self.SKIP_PATTERNS:
            if re.match(pattern, text.strip()):
                return True

        # 跳过纯变量/HTML的文本
        cleaned = text
        for pattern in self.VARIABLE_PATTERNS:
            cleaned = re.sub(pattern, '', cleaned)
        cleaned = cleaned.strip()
        if len(cleaned) < 2:
            return True

        return False

    def get_context(self, lines: List[str], line_idx: int, context_size: int = 2) -> str:
        """获取代码上下文"""
        start = max(0, line_idx - context_size)
        end = min(len(lines), line_idx + context_size + 1)
        context_lines = lines[start:end]
        return '\n'.join(f"{start + i + 1}: {line.rstrip()}" for i, line in enumerate(context_lines))

    def extract_list_items(self, list_content: str) -> List[str]:
        """从 list(...) 中提取字符串项"""
        items = []
        # 匹配引号内的字符串
        matches = re.findall(r'"([^"]*)"', list_content)
        items.extend(matches)
        matches = re.findall(r"'([^']*)'", list_content)
        items.extend(matches)
        return items

    def add_text(self, text: str, file_path: str, line_number: int,
                 text_type: TextType, lines: List[str], line_idx: int):
        """添加提取的文本（带去重）"""
        if self.should_skip(text):
            return

        # 基于原始文本去重
        if text in self.seen_texts:
            return
        self.seen_texts.add(text)

        text_id = self.generate_id(file_path, line_number, text)
        self.extracted_texts.append(ExtractedText(
            id=text_id,
            file_path=file_path,
            line_number=line_number,
            text_type=text_type.value,
            original=text,
            context=self.get_context(lines, line_idx),
            variables=self.extract_variables(text)
        ))

    def extract_from_file(self, file_path: Path) -> int:
        """从单个文件提取文本，返回提取数量"""
        count_before = len(self.extracted_texts)
        relative_path = str(file_path.relative_to(self.base_path))

        try:
            with open(file_path, 'r', encoding='utf-8', errors='ignore') as f:
                content = f.read()
                lines = content.split('\n')
        except Exception as e:
            print(f"警告: 无法读取文件 {file_path}: {e}")
            return 0

        for line_idx, line in enumerate(lines):
            line_number = line_idx + 1

            # 跳过注释行
            stripped = line.strip()
            if stripped.startswith('//'):
                continue

            # 检查属性模式
            for pattern, text_type in self.PROPERTY_PATTERNS:
                matches = re.findall(pattern, line)
                for match in matches:
                    self.add_text(match, relative_path, line_number, text_type, lines, line_idx)

            # 检查函数调用模式
            for pattern, text_type in self.FUNCTION_PATTERNS:
                matches = re.findall(pattern, line)
                for match in matches:
                    self.add_text(match, relative_path, line_number, text_type, lines, line_idx)

            # 检查列表模式
            for pattern, text_type in self.LIST_PATTERNS:
                matches = re.findall(pattern, line)
                for match in matches:
                    items = self.extract_list_items(match)
                    for item in items:
                        self.add_text(item, relative_path, line_number, text_type, lines, line_idx)

        return len(self.extracted_texts) - count_before

    def extract_all(self, subdirs: List[str] = None) -> List[ExtractedText]:
        """提取所有 DM 文件中的文本"""
        if subdirs is None:
            subdirs = ['code']

        for subdir in subdirs:
            search_path = self.base_path / subdir
            if not search_path.exists():
                print(f"警告: 目录不存在 {search_path}")
                continue

            dm_files = [f for f in search_path.rglob('*.dm')
                       if not any(skip in str(f) for skip in self.SKIP_DIRS)]
            print(f"在 {subdir} 中找到 {len(dm_files)} 个 DM 文件")

            for file_path in dm_files:
                self.extract_from_file(file_path)

        print(f"\n总计提取 {len(self.extracted_texts)} 条唯一文本")
        return self.extracted_texts

    def export_json(self, output_path: str):
        """导出为 JSON 格式"""
        # 统计各类型数量
        type_counts = {}
        for t in self.extracted_texts:
            type_counts[t.text_type] = type_counts.get(t.text_type, 0) + 1

        data = {
            "meta": {
                "version": "2.0",
                "total_count": len(self.extracted_texts),
                "type_counts": type_counts,
                "instructions": {
                    "zh": "翻译 'translation' 字段，保留 'variables' 中列出的变量不翻译",
                    "en": "Translate the 'translation' field, keep variables listed in 'variables' unchanged"
                }
            },
            "texts": [asdict(t) for t in self.extracted_texts]
        }

        with open(output_path, 'w', encoding='utf-8') as f:
            json.dump(data, f, ensure_ascii=False, indent=2)

        print(f"已导出 {len(self.extracted_texts)} 条文本到 {output_path}")
        print("\n按类型统计:")
        for text_type, count in sorted(type_counts.items(), key=lambda x: -x[1]):
            print(f"  {text_type}: {count}")

    def export_by_type(self, output_dir: str):
        """按类型分别导出"""
        os.makedirs(output_dir, exist_ok=True)

        by_type: Dict[str, List[ExtractedText]] = {}
        for text in self.extracted_texts:
            if text.text_type not in by_type:
                by_type[text.text_type] = []
            by_type[text.text_type].append(text)

        print(f"\n按类型导出到 {output_dir}:")
        for text_type, texts in sorted(by_type.items(), key=lambda x: -len(x[1])):
            output_path = os.path.join(output_dir, f"{text_type}.json")
            data = {
                "meta": {
                    "type": text_type,
                    "count": len(texts)
                },
                "texts": [asdict(t) for t in texts]
            }
            with open(output_path, 'w', encoding='utf-8') as f:
                json.dump(data, f, ensure_ascii=False, indent=2)
            print(f"  {text_type}: {len(texts)} 条")


class DMTextInjector:
    """DM 代码翻译注入器"""

    def __init__(self, base_path: str):
        self.base_path = Path(base_path)
        self.translations: Dict[str, str] = {}  # original -> translation

    def load_translations(self, json_path: str):
        """加载翻译文件"""
        with open(json_path, 'r', encoding='utf-8') as f:
            data = json.load(f)

        for text in data.get('texts', []):
            if text.get('translation'):
                self.translations[text['original']] = text['translation']

        print(f"已加载 {len(self.translations)} 条翻译")

    def inject_file(self, file_path: Path) -> Tuple[bool, int]:
        """向单个文件注入翻译，返回 (是否修改, 替换数量)"""
        try:
            with open(file_path, 'r', encoding='utf-8', errors='ignore') as f:
                content = f.read()
        except Exception as e:
            print(f"警告: 无法读取文件 {file_path}: {e}")
            return False, 0

        original_content = content
        replacement_count = 0

        # 按长度降序排列，避免短文本替换长文本的一部分
        sorted_translations = sorted(
            self.translations.items(),
            key=lambda x: len(x[0]),
            reverse=True
        )

        for original, translation in sorted_translations:
            if not translation:
                continue

            # 只替换引号内的完整文本
            # 匹配 "original" 并替换为 "translation"
            pattern = re.compile(
                r'(["\']\s*)' + re.escape(original) + r'(\s*["\'])',
                re.MULTILINE
            )

            new_content, count = pattern.subn(
                lambda m: m.group(1) + translation + m.group(2),
                content
            )

            if count > 0:
                content = new_content
                replacement_count += count

        if content != original_content:
            with open(file_path, 'w', encoding='utf-8') as f:
                f.write(content)
            return True, replacement_count

        return False, 0

    def inject_all(self, subdirs: List[str] = None) -> Dict[str, int]:
        """向所有文件注入翻译"""
        if subdirs is None:
            subdirs = ['code']

        stats = {
            'files_modified': 0,
            'total_replacements': 0
        }

        for subdir in subdirs:
            search_path = self.base_path / subdir
            if not search_path.exists():
                continue

            dm_files = list(search_path.rglob('*.dm'))

            for file_path in dm_files:
                modified, count = self.inject_file(file_path)
                if modified:
                    stats['files_modified'] += 1
                    stats['total_replacements'] += count
                    print(f"  已修改: {file_path.relative_to(self.base_path)} ({count} 处)")

        return stats


def main():
    parser = argparse.ArgumentParser(
        description='CMSS13 DM 文本提取/注入工具 (完整版)',
        formatter_class=argparse.RawDescriptionHelpFormatter,
        epilog="""
示例:
  提取文本:
    python dm_text_extractor.py extract --output translations.json
    python dm_text_extractor.py extract --output-dir translations/

  注入翻译:
    python dm_text_extractor.py inject --input translations_cn.json
        """
    )

    subparsers = parser.add_subparsers(dest='command', help='命令')

    # extract 子命令
    extract_parser = subparsers.add_parser('extract', help='提取需要翻译的文本')
    extract_parser.add_argument('--path', default='.', help='项目根目录路径')
    extract_parser.add_argument('--output', '-o', help='输出 JSON 文件路径')
    extract_parser.add_argument('--output-dir', '-d', help='按类型分别输出到目录')
    extract_parser.add_argument('--subdirs', nargs='+', default=['code'],
                               help='要扫描的子目录 (默认: code)')

    # inject 子命令
    inject_parser = subparsers.add_parser('inject', help='注入翻译后的文本')
    inject_parser.add_argument('--path', default='.', help='项目根目录路径')
    inject_parser.add_argument('--input', '-i', required=True, help='翻译后的 JSON 文件路径')
    inject_parser.add_argument('--subdirs', nargs='+', default=['code'],
                              help='要处理的子目录 (默认: code)')

    args = parser.parse_args()

    if args.command == 'extract':
        extractor = DMTextExtractor(args.path)
        texts = extractor.extract_all(args.subdirs)

        if args.output:
            extractor.export_json(args.output)

        if args.output_dir:
            extractor.export_by_type(args.output_dir)

        if not args.output and not args.output_dir:
            # 默认输出
            extractor.export_json('translations.json')

    elif args.command == 'inject':
        injector = DMTextInjector(args.path)
        injector.load_translations(args.input)

        print("\n开始注入翻译...")
        stats = injector.inject_all(args.subdirs)

        print(f"\n完成! 修改了 {stats['files_modified']} 个文件, "
              f"共 {stats['total_replacements']} 处替换")

    else:
        parser.print_help()


if __name__ == '__main__':
    main()
