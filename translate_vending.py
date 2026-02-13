#!/usr/bin/env python3
"""
批量翻译CM-SS13 vending目录下DM文件中的玩家可见文本。
要求：
1. 严禁修改代码结构。
2. 保持 [var] 格式的变量不被翻译。
3. 专有名词参考CM13 wiki。
"""

import re
import os
import sys
from pathlib import Path
from typing import List, Tuple, Optional, Dict
import logging

# 配置日志
logging.basicConfig(level=logging.INFO, format='%(asctime)s - %(levelname)s - %(message)s')
logger = logging.getLogger(__name__)

# 专有名词术语表 (英文 -> 中文)
# 用户可以根据CM13 wiki补充更多术语
TERM_GLOSSARY: Dict[str, str] = {
    "USCM": "USCM",
    "ColMarTech": "ColMarTech",
    "Weyland-Yutani": "维兰德-汤谷公司",
    "Souto": "索托汽水",
    "Kepler Crisps": "开普勒脆片",
    "Marine": "海军陆战队员",
    "Colonial Marines": "殖民地海军陆战队",
    "CLF": "殖民解放阵线",
    "UPP": "联合人民阵线",
    "PMC": "私人军事承包商",
    "CMB": "殖民地矿业局",
    "WY": "维兰德-汤谷",
    " synthetic": "合成人",
    " vendor": "贩售机",
    " vending": "贩售",
    " machine": "机器",
    # 添加更多术语...
}

# 需要翻译的字符串模式
# 1. name = "\improper ..." 或 name = "..."
NAME_PATTERN = re.compile(r'name\s*=\s*("(?:\\"|[^"])*")')
# 2. desc = "..."
DESC_PATTERN = re.compile(r'desc\s*=\s*("(?:\\"|[^"])*")')
# 3. product_slogans = "..." (可能包含多个句子，用分号分隔)
PRODUCT_SLOGANS_PATTERN = re.compile(r'product_slogans\s*=\s*("(?:\\"|[^"])*")')
# 4. product_ads = "..."
PRODUCT_ADS_PATTERN = re.compile(r'product_ads\s*=\s*("(?:\\"|[^"])*")')
# 5. vend_reply = "..."
VEND_REPLY_PATTERN = re.compile(r'vend_reply\s*=\s*("(?:\\"|[^"])*")')
# 6. speak("...")
SPEAK_PATTERN = re.compile(r'speak\s*\(\s*("(?:\\"|[^"])*")\s*\)')
# 7. to_chat(user, "...") 中的第二个参数（简化处理）
TO_CHAT_PATTERN = re.compile(r'to_chat\s*\(\s*[^,]+,\s*("(?:\\"|[^"])*")\s*\)')
# 8. visible_message("...")
VISIBLE_MESSAGE_PATTERN = re.compile(r'visible_message\s*\(\s*("(?:\\"|[^"])*")\s*\)')
# 9. list("...", ...) 中的第一个字符串参数（仅当第一个参数是字符串时）
LIST_PATTERN = re.compile(r'list\s*\(\s*("(?:\\"|[^"])*")\s*,')
# 10. GLOBAL_LIST_INIT(vending_wire_descriptions, ...) 中的字符串值
GLOBAL_LIST_PATTERN = re.compile(r'GLOBAL_LIST_INIT\s*\(\s*vending_wire_descriptions\s*,\s*[^)]+\)')

# 合并所有模式，用于快速扫描
ALL_PATTERNS = [
    ("name", NAME_PATTERN),
    ("desc", DESC_PATTERN),
    ("product_slogans", PRODUCT_SLOGANS_PATTERN),
    ("product_ads", PRODUCT_ADS_PATTERN),
    ("vend_reply", VEND_REPLY_PATTERN),
    ("speak", SPEAK_PATTERN),
    ("to_chat", TO_CHAT_PATTERN),
    ("visible_message", VISIBLE_MESSAGE_PATTERN),
    ("list", LIST_PATTERN),
]

def is_chinese(text: str) -> bool:
    """
    检查字符串是否包含中文字符。
    """
    # 简单检查：是否包含CJK统一表意文字
    for char in text:
        if '\u4e00' <= char <= '\u9fff':
            return True
    return False

def contains_english(text: str) -> bool:
    """
    检查字符串是否包含英文字母（用于判断是否需要翻译）。
    """
    return any('a' <= c <= 'z' or 'A' <= c <= 'Z' for c in text)

def extract_string_literal(literal: str) -> str:
    """
    从DM字符串字面量中提取内容（去除引号）。
    处理转义引号（但DM中较少见）。
    """
    if literal.startswith('"') and literal.endswith('"'):
        content = literal[1:-1]
        # 简化处理：将\"替换为"
        content = content.replace('\\"', '"')
        return content
    return literal

def rebuild_string_literal(content: str) -> str:
    """
    将内容重新构建为DM字符串字面量（添加引号）。
    转义内部的双引号。
    """
    content = content.replace('"', '\\"')
    return f'"{content}"'

def preserve_variables(text: str) -> List[Tuple[str, str]]:
    """
    提取并保留 [var] 格式的变量和 \macro 格式的宏。
    返回 (placeholder, original) 列表和替换后的文本。
    """
    # 匹配 [var] 格式，其中 var 可以包含字母、数字、下划线
    var_pattern = re.compile(r'(\[[a-zA-Z0-9_]+\])')
    # 匹配 \macro 格式，其中 macro 是字母序列
    macro_pattern = re.compile(r'(\\\[a-zA-Z]+)')
    placeholders = []

    # 先匹配变量
    matches = var_pattern.findall(text)
    for i, match in enumerate(matches):
        placeholder = f'__VAR_{i}__'
        placeholders.append((placeholder, match))
        text = text.replace(match, placeholder, 1)

    # 再匹配宏（注意：由于文本已被修改，但宏可能包含反斜杠，不会与占位符冲突）
    matches = macro_pattern.findall(text)
    for i, match in enumerate(matches):
        placeholder = f'__MACRO_{i}__'
        placeholders.append((placeholder, match))
        text = text.replace(match, placeholder, 1)

    return placeholders, text

def restore_variables(text: str, placeholders: List[Tuple[str, str]]) -> str:
    """
    将占位符恢复为原始变量。
    """
    for placeholder, original in placeholders:
        text = text.replace(placeholder, original)
    return text

def apply_glossary(text: str, glossary: Dict[str, str]) -> str:
    """
    应用术语表，将英文术语替换为中文。
    """
    # 按长度降序排序，优先匹配长术语
    sorted_terms = sorted(glossary.items(), key=lambda x: len(x[0]), reverse=True)
    for en, zh in sorted_terms:
        # 简单替换，忽略大小写？但专有名词通常有固定大小写
        text = text.replace(en, zh)
    return text

class Translator:
    """翻译器基类"""
    def translate(self, text: str, glossary: Dict[str, str]) -> str:
        raise NotImplementedError

class GlossaryTranslator(Translator):
    """仅使用术语表替换的翻译器"""
    def translate(self, text: str, glossary: Dict[str, str]) -> str:
        return apply_glossary(text, glossary)

class GoogleTranslator(Translator):
    """使用Google Translate API（需要网络）"""
    def __init__(self):
        self._translator = None
        try:
            from googletrans import Translator as GT
            self._translator = GT()
        except ImportError:
            logger.warning("未安装googletrans，请运行: pip install googletrans==4.0.0-rc1")
            raise

    def translate(self, text: str, glossary: Dict[str, str]) -> str:
        if not self._translator:
            return apply_glossary(text, glossary)
        # 先应用术语表
        text = apply_glossary(text, glossary)
        # 如果已经是中文（或没有英文字母），则跳过
        if not any('a' <= c <= 'z' or 'A' <= c <= 'Z' for c in text):
            return text
        try:
            # Google Translate 支持自动检测语言，目标语言为中文
            result = self._translator.translate(text, dest='zh-cn', src='en')
            return result.text
        except Exception as e:
            logger.warning(f"翻译失败: {e}, 回退到术语表")
            return text

class DeepSeekTranslator(Translator):
    """使用DeepSeek API进行翻译"""
    def __init__(self, api_key: str, base_url: str = "https://api.deepseek.com"):
        self.api_key = api_key
        self.base_url = base_url
        try:
            import openai
            self.client = openai.OpenAI(
                api_key=api_key,
                base_url=base_url
            )
        except ImportError:
            logger.warning("未安装openai，请运行: pip install openai")
            raise

    def translate(self, text: str, glossary: Dict[str, str]) -> str:
        # 先应用术语表
        text = apply_glossary(text, glossary)
        # 如果已经是中文（或没有英文字母），则跳过
        if not any('a' <= c <= 'z' or 'A' <= c <= 'Z' for c in text):
            return text

        try:
            # 使用DeepSeek API进行翻译
            response = self.client.chat.completions.create(
                model="deepseek-chat",  # 或 "deepseek-coder"
                messages=[
                    {"role": "system", "content": "你是一个专业的游戏本地化翻译员。请将以下英文游戏文本翻译成简体中文，保持[var]格式的变量不变，保留专业术语。"},
                    {"role": "user", "content": f"翻译以下文本为简体中文：{text}"}
                ],
                temperature=0.3,
                max_tokens=1000
            )
            translated = response.choices[0].message.content.strip()
            # 清理可能的额外内容
            if "翻译" in translated and "：" in translated:
                # 提取翻译后的文本
                translated = translated.split("：", 1)[-1].strip()
            return translated
        except Exception as e:
            logger.warning(f"DeepSeek翻译失败: {e}, 回退到术语表")
            return text

# 默认翻译器
DEFAULT_TRANSLATOR = 'glossary'

def translate_text(text: str, glossary: Dict[str, str], translator: Translator) -> str:
    """
    翻译文本。
    """
    return translator.translate(text, glossary)

def process_file(file_path: Path, glossary: Dict[str, str], translator: Translator, dry_run: bool = True) -> int:
    """
    处理单个文件，返回翻译的字符串数量。
    """
    logger.info(f"处理文件: {file_path}")
    try:
        with open(file_path, 'r', encoding='utf-8') as f:
            content = f.read()
    except UnicodeDecodeError:
        logger.warning(f"文件编码可能不是UTF-8: {file_path}")
        with open(file_path, 'r', encoding='latin-1') as f:
            content = f.read()

    # 存储替换映射
    replacements = []

    # 遍历所有模式
    for pattern_name, pattern in ALL_PATTERNS:
        for match in pattern.finditer(content):
            literal = match.group(1)
            original_text = extract_string_literal(literal)
            # 检查是否已经是中文
            if is_chinese(original_text):
                continue
            # 检查是否包含英文
            if not contains_english(original_text):
                continue
            # 保留变量
            placeholders, text_without_vars = preserve_variables(original_text)
            # 翻译
            translated_text = translate_text(text_without_vars, glossary, translator)
            # 恢复变量
            translated_text = restore_variables(translated_text, placeholders)
            # 构建新的字符串字面量
            new_literal = rebuild_string_literal(translated_text)
            # 记录替换
            start, end = match.span(1)
            replacements.append((start, end, new_literal))
            logger.debug(f"匹配到 {pattern_name}: {original_text} -> {translated_text}")

    # 按位置从后向前替换，避免影响索引
    replacements.sort(key=lambda x: x[0], reverse=True)
    new_content = content
    for start, end, new_literal in replacements:
        new_content = new_content[:start] + new_literal + new_content[end:]

    # 如果内容有变化且不是干运行，则写回文件
    if new_content != content and not dry_run:
        # 备份原文件
        backup_path = file_path.with_suffix(file_path.suffix + '.bak')
        with open(backup_path, 'w', encoding='utf-8') as f:
            f.write(content)
        # 写入新内容
        with open(file_path, 'w', encoding='utf-8') as f:
            f.write(new_content)
        logger.info(f"已更新文件: {file_path}，备份在 {backup_path}")
    elif new_content != content and dry_run:
        logger.info(f"干运行：将更新文件 {file_path}，共 {len(replacements)} 处")

    return len(replacements)

def main():
    import argparse
    parser = argparse.ArgumentParser(description='批量翻译CM-SS13 vending目录下的DM文件')
    parser.add_argument('--dir', default='./code/game/machinery/vending',
                        help='vending目录路径')
    parser.add_argument('--glossary', default='./glossary.csv',
                        help='术语表CSV文件路径')
    parser.add_argument('--translator', choices=['google', 'glossary', 'deepseek'], default='glossary',
                        help='翻译器：google（需要网络）、glossary（仅术语表）或 deepseek（DeepSeek API）')
    parser.add_argument('--deepseek-api-key', help='DeepSeek API密钥（当使用deepseek翻译器时）')
    parser.add_argument('--deepseek-base-url', default='https://api.deepseek.com',
                        help='DeepSeek API基础URL（默认：https://api.deepseek.com）')
    parser.add_argument('--dry-run', action='store_true',
                        help='干运行，不实际修改文件')
    parser.add_argument('--verbose', action='store_true',
                        help='输出详细信息')
    args = parser.parse_args()

    if args.verbose:
        logger.setLevel(logging.DEBUG)

    # 加载术语表
    glossary = TERM_GLOSSARY.copy()
    glossary_path = Path(args.glossary)
    if glossary_path.exists():
        try:
            import csv
            with open(glossary_path, 'r', encoding='utf-8') as f:
                reader = csv.reader(f)
                for row in reader:
                    if len(row) >= 2:
                        glossary[row[0]] = row[1]
            logger.info(f"从 {glossary_path} 加载了 {len(glossary)} 条术语")
        except Exception as e:
            logger.warning(f"加载术语表失败: {e}")

    # 初始化翻译器
    translator = None
    if args.translator == 'google':
        try:
            translator = GoogleTranslator()
            logger.info("使用Google Translate翻译器")
        except Exception as e:
            logger.warning(f"无法初始化Google翻译器: {e}, 回退到术语表翻译器")
            translator = GlossaryTranslator()
    elif args.translator == 'deepseek':
        if not args.deepseek_api_key:
            logger.error("使用deepseek翻译器需要提供--deepseek-api-key参数")
            sys.exit(1)
        try:
            translator = DeepSeekTranslator(args.deepseek_api_key, args.deepseek_base_url)
            logger.info("使用DeepSeek API翻译器")
        except Exception as e:
            logger.warning(f"无法初始化DeepSeek翻译器: {e}, 回退到术语表翻译器")
            translator = GlossaryTranslator()
    else:
        translator = GlossaryTranslator()
        logger.info("使用术语表翻译器")

    # 遍历目录
    vending_dir = Path(args.dir)
    if not vending_dir.exists():
        logger.error(f"目录不存在: {vending_dir}")
        sys.exit(1)

    # 收集所有.dm文件（排除.translated和备份文件）
    dm_files = []
    for ext in ['*.dm', '*.dm.translated']:
        dm_files.extend(vending_dir.rglob(ext))

    # 过滤掉备份文件
    dm_files = [f for f in dm_files if not f.name.endswith('.bak') and not f.name.endswith('.translated')]

    logger.info(f"找到 {len(dm_files)} 个DM文件")

    total_translated = 0
    for dm_file in dm_files:
        translated = process_file(dm_file, glossary, translator, args.dry_run)
        total_translated += translated
        if translated > 0:
            logger.info(f"  {dm_file}: {translated} 处需要翻译")

    logger.info(f"总计: {total_translated} 处需要翻译")
    if args.dry_run:
        logger.info("干运行完成，未修改文件。")
    else:
        logger.info("翻译完成。")

if __name__ == '__main__':
    main()