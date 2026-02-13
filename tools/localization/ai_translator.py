#!/usr/bin/env python3
"""
CMSS13 AI 翻译工具
==================
使用 AI API 自动翻译提取的文本，支持专有名词词典。

支持的 API:
- OpenAI (GPT-4, GPT-3.5)
- Anthropic (Claude)
- 本地 Ollama

用法:
    python ai_translator.py --input translations.json --output translations_cn.json
    python ai_translator.py --input translations.json --api openai --model gpt-4
"""

import os
import re
import json
import time
import argparse
from pathlib import Path
from typing import Dict, List, Optional, Tuple
from dataclasses import dataclass

# 专有名词词典 - 基于 CM13 Wiki
# 这些词汇在翻译时应保持一致或不翻译
GLOSSARY = {
    # 阵营 Factions
    "USCM": "USCM",  # 保持原样
    "United States Colonial Marines": "美国殖民地海军陆战队",
    "Colonial Marines": "殖民地海军陆战队",
    "Marines": "陆战队员",
    "Marine": "陆战队员",
    "Weyland-Yutani": "维兰德-汤谷",
    "WY": "维兰德",
    "Xenomorph": "异形",
    "Xenomorphs": "异形",
    "Xeno": "异形",
    "Xenos": "异形",
    "CLF": "CLF",  # Colonial Liberation Front
    "Colonial Liberation Front": "殖民地解放阵线",
    "UPP": "UPP",  # Union of Progressive Peoples
    "Union of Progressive Peoples": "进步人民联盟",
    "PMC": "PMC",  # Private Military Contractor
    "Yautja": "铁血战士",
    "Predator": "铁血战士",
    "Predators": "铁血战士",

    # 异形种类 Xenomorph Castes
    "Queen": "女王",
    "Praetorian": "禁卫军",
    "Ravager": "掠夺者",
    "Crusher": "碾压者",
    "Boiler": "沸腾者",
    "Carrier": "携带者",
    "Hivelord": "巢穴领主",
    "Drone": "工蜂",
    "Runner": "奔跑者",
    "Lurker": "潜伏者",
    "Spitter": "喷吐者",
    "Sentinel": "哨兵",
    "Defender": "防御者",
    "Warrior": "战士",
    "Hunter": "猎手",
    "Facehugger": "抱脸虫",
    "Chestburster": "破胸体",
    "Larva": "幼虫",
    "Egg": "虫卵",
    "Hive": "巢穴",
    "Weeds": "菌毯",

    # 军衔 Ranks
    "Private": "列兵",
    "PFC": "一等兵",
    "Private First Class": "一等兵",
    "Lance Corporal": "下士",
    "Corporal": "下士",
    "Sergeant": "中士",
    "Staff Sergeant": "上士",
    "Gunnery Sergeant": "枪炮军士",
    "Master Sergeant": "军士长",
    "Lieutenant": "中尉",
    "Captain": "上尉",
    "Major": "少校",
    "Colonel": "上校",
    "Commander": "指挥官",
    "Commanding Officer": "指挥官",
    "CO": "指挥官",
    "Executive Officer": "副指挥官",
    "XO": "副指挥官",

    # 职业 Roles
    "Squad Leader": "班长",
    "Fireteam Leader": "火力组长",
    "Rifleman": "步枪兵",
    "Smartgunner": "智能枪手",
    "Specialist": "专家",
    "Combat Technician": "战斗技术员",
    "Hospital Corpsman": "医疗兵",
    "Medic": "医疗兵",
    "Engineer": "工程师",
    "Pilot": "飞行员",
    "Dropship Pilot": "运输机飞行员",
    "Crew Chief": "机组长",
    "Military Police": "宪兵",
    "MP": "宪兵",
    "Chief MP": "宪兵长",
    "Requisitions Officer": "补给官",
    "RO": "补给官",
    "Synthetic": "合成人",
    "Synth": "合成人",
    "Working Joe": "工作乔",
    "Corporate Liaison": "公司联络官",
    "CL": "公司联络官",
    "Survivor": "幸存者",
    "Survivors": "幸存者",

    # 小队 Squads
    "Alpha": "阿尔法",
    "Bravo": "布拉沃",
    "Charlie": "查理",
    "Delta": "德尔塔",
    "Echo": "回声",
    "Foxtrot": "狐步",

    # 地点 Locations
    "USS Almayer": "阿尔迈耶号",
    "Almayer": "阿尔迈耶号",
    "Sulaco": "苏拉科号",
    "LV-624": "LV-624",
    "Big Red": "大红",
    "Ice Colony": "冰雪殖民地",
    "Prison Station": "监狱空间站",
    "Solaris Ridge": "索拉里斯山脊",
    "New Varadero": "新瓦拉德罗",
    "Trijent Dam": "特里金特大坝",
    "Kutjevo": "库特耶沃",
    "Sorokyne Strata": "索罗金地层",
    "Fiorina Science Annex": "菲奥里纳科学附属设施",
    "Shivas Snowball": "湿婆雪球",
    "Whiskey Outpost": "威士忌前哨",
    "CIC": "作战指挥中心",
    "Medbay": "医疗舱",
    "Hangar": "机库",
    "Requisitions": "补给处",
    "Brig": "禁闭室",
    "Engineering": "工程部",
    "Research": "研究部",

    # 武器 Weapons
    "M41A": "M41A",
    "Pulse Rifle": "脉冲步枪",
    "M41A Pulse Rifle": "M41A脉冲步枪",
    "M39": "M39",
    "Submachine Gun": "冲锋枪",
    "SMG": "冲锋枪",
    "M37A2": "M37A2",
    "Shotgun": "霰弹枪",
    "M4A3": "M4A3",
    "Pistol": "手枪",
    "M44": "M44",
    "Revolver": "左轮手枪",
    "M56": "M56",
    "Smartgun": "智能枪",
    "M240": "M240",
    "Incinerator": "焚烧器",
    "Flamethrower": "火焰喷射器",
    "M5 RPG": "M5火箭筒",
    "Rocket Launcher": "火箭发射器",
    "Grenade": "手榴弹",
    "Frag Grenade": "破片手榴弹",
    "Smoke Grenade": "烟雾弹",
    "Flashbang": "闪光弹",
    "Machete": "砍刀",
    "Combat Knife": "战斗刀",
    "Bayonet": "刺刀",

    # 装备 Equipment
    "Armor": "护甲",
    "M3 Armor": "M3护甲",
    "B12 Armor": "B12护甲",
    "Helmet": "头盔",
    "Backpack": "背包",
    "Satchel": "挎包",
    "Webbing": "战术背心",
    "Belt": "腰带",
    "Boots": "靴子",
    "Gloves": "手套",
    "Magazine": "弹匣",
    "Ammo": "弹药",
    "Ammunition": "弹药",
    "Medkit": "医疗包",
    "First Aid Kit": "急救包",
    "Binoculars": "望远镜",
    "Motion Detector": "动态探测器",
    "Flare": "照明弹",
    "Flashlight": "手电筒",

    # 医疗 Medical
    "Tricordrazine": "三合剂",
    "Bicaridine": "碧卡利定",
    "Kelotane": "凯洛坦",
    "Inaprovaline": "伊纳普罗瓦林",
    "Tramadol": "曲马多",
    "Oxycodone": "羟考酮",
    "Peridaxon": "培利达松",
    "QuickClot": "快凝血剂",
    "Splint": "夹板",
    "Bandage": "绷带",
    "Surgical Line": "手术缝合线",
    "Burn Kit": "烧伤包",
    "Trauma Kit": "创伤包",
    "Defibrillator": "除颤器",
    "Defib": "除颤器",
    "Stasis Bag": "静滞袋",
    "Cryotube": "冷冻舱",
    "Surgery": "手术",
    "Infection": "感染",
    "Fracture": "骨折",
    "Bleeding": "出血",
    "Pain": "疼痛",

    # 状态 Status
    "Dead": "死亡",
    "Critical": "危急",
    "Unconscious": "昏迷",
    "Stunned": "眩晕",
    "Knocked Down": "击倒",
    "Infected": "被感染",
    "Nested": "被筑巢",
    "Hugged": "被抱脸",

    # 其他 Misc
    "Dropship": "运输机",
    "APC": "装甲运兵车",
    "Tank": "坦克",
    "Orbital Bombardment": "轨道轰炸",
    "OB": "轨道轰炸",
    "Supply Drop": "补给投放",
    "Mortar": "迫击炮",
    "Sentry": "哨戒炮",
    "Sentry Gun": "哨戒炮",
    "Barricade": "路障",
    "Cade": "路障",
    "Sandbag": "沙袋",
    "Plasteel": "塑钢",
    "Metal": "金属",
    "Weld": "焊接",
    "Welder": "焊枪",
    "Wrench": "扳手",
    "Screwdriver": "螺丝刀",
    "Crowbar": "撬棍",
    "Wirecutters": "剪线钳",
    "Multitool": "万用工具",
    "Power Cell": "电池",
    "ID Card": "身份卡",
    "Access": "权限",
    "Radio": "无线电",
    "Headset": "耳机",
    "PDA": "PDA",
    "Paper": "纸",
    "Pen": "笔",
    "Overwatch": "监控",
    "Groundside": "地面",
    "Shipside": "舰上",
}

# 翻译提示词模板
TRANSLATION_PROMPT = """你是一个专业的游戏本地化翻译专家，正在翻译 Colonial Marines (CM13) 游戏。

## 翻译规则:
1. 保持游戏风格：军事、科幻、紧张氛围
2. 保留所有变量占位符不翻译: [var], \\the [src], \\his, %t 等
3. 保留 HTML 标签: <b>, </b>, <i> 等
4. 专有名词参考词典翻译，保持一致性
5. 简洁有力，符合军事用语风格
6. 如果是动作描述（如 "slashes", "attacks"），翻译为中文动词

## 专有名词词典:
{glossary}

## 需要翻译的文本:
{texts}

## 输出格式:
返回 JSON 数组，每个元素包含 "id" 和 "translation" 字段。
只返回 JSON，不要其他内容。

示例输出:
[
  {{"id": "abc123", "translation": "你用[src]攻击了[target]。"}},
  {{"id": "def456", "translation": "陆战队员准备就绪。"}}
]
"""


class AITranslator:
    """AI 翻译器基类"""

    def __init__(self, glossary: Dict[str, str] = None):
        self.glossary = glossary or GLOSSARY

    def translate_batch(self, texts: List[dict], batch_size: int = 20) -> List[dict]:
        """批量翻译文本"""
        raise NotImplementedError

    def _format_glossary(self) -> str:
        """格式化词典为字符串"""
        lines = []
        for en, zh in sorted(self.glossary.items()):
            lines.append(f"- {en} → {zh}")
        return '\n'.join(lines)

    def _format_texts(self, texts: List[dict]) -> str:
        """格式化待翻译文本"""
        items = []
        for t in texts:
            items.append({
                "id": t["id"],
                "original": t["original"],
                "type": t["text_type"],
                "variables": t.get("variables", [])
            })
        return json.dumps(items, ensure_ascii=False, indent=2)

    def _parse_response(self, response: str) -> List[dict]:
        """解析 AI 响应"""
        # 尝试提取 JSON
        try:
            # 尝试直接解析
            return json.loads(response)
        except json.JSONDecodeError:
            pass

        # 尝试从 markdown 代码块中提取
        json_match = re.search(r'```(?:json)?\s*([\s\S]*?)\s*```', response)
        if json_match:
            try:
                return json.loads(json_match.group(1))
            except json.JSONDecodeError:
                pass

        # 尝试找到 JSON 数组
        array_match = re.search(r'\[[\s\S]*\]', response)
        if array_match:
            try:
                return json.loads(array_match.group(0))
            except json.JSONDecodeError:
                pass

        print(f"警告: 无法解析 AI 响应")
        return []


class OpenAITranslator(AITranslator):
    """OpenAI API 翻译器"""

    def __init__(self, api_key: str = None, model: str = "gpt-4", glossary: Dict[str, str] = None):
        super().__init__(glossary)
        self.api_key = api_key or os.environ.get("OPENAI_API_KEY")
        self.model = model

        if not self.api_key:
            raise ValueError("需要设置 OPENAI_API_KEY 环境变量或传入 api_key")

    def translate_batch(self, texts: List[dict], batch_size: int = 20) -> List[dict]:
        """批量翻译"""
        try:
            import openai
        except ImportError:
            raise ImportError("请安装 openai: pip install openai")

        client = openai.OpenAI(api_key=self.api_key)
        results = []

        for i in range(0, len(texts), batch_size):
            batch = texts[i:i + batch_size]
            prompt = TRANSLATION_PROMPT.format(
                glossary=self._format_glossary(),
                texts=self._format_texts(batch)
            )

            try:
                response = client.chat.completions.create(
                    model=self.model,
                    messages=[
                        {"role": "system", "content": "你是专业的游戏本地化翻译专家。"},
                        {"role": "user", "content": prompt}
                    ],
                    temperature=0.3
                )

                translated = self._parse_response(response.choices[0].message.content)
                results.extend(translated)

                print(f"  已翻译 {min(i + batch_size, len(texts))}/{len(texts)}")

            except Exception as e:
                print(f"  翻译批次 {i // batch_size + 1} 失败: {e}")

            # 避免 rate limit
            time.sleep(1)

        return results


class AnthropicTranslator(AITranslator):
    """Anthropic Claude API 翻译器"""

    def __init__(self, api_key: str = None, model: str = "claude-sonnet-4-20250514", glossary: Dict[str, str] = None):
        super().__init__(glossary)
        self.api_key = api_key or os.environ.get("ANTHROPIC_API_KEY")
        self.model = model

        if not self.api_key:
            raise ValueError("需要设置 ANTHROPIC_API_KEY 环境变量或传入 api_key")

    def translate_batch(self, texts: List[dict], batch_size: int = 20) -> List[dict]:
        """批量翻译"""
        try:
            import anthropic
        except ImportError:
            raise ImportError("请安装 anthropic: pip install anthropic")

        client = anthropic.Anthropic(api_key=self.api_key)
        results = []

        for i in range(0, len(texts), batch_size):
            batch = texts[i:i + batch_size]
            prompt = TRANSLATION_PROMPT.format(
                glossary=self._format_glossary(),
                texts=self._format_texts(batch)
            )

            try:
                response = client.messages.create(
                    model=self.model,
                    max_tokens=4096,
                    messages=[
                        {"role": "user", "content": prompt}
                    ]
                )

                translated = self._parse_response(response.content[0].text)
                results.extend(translated)

                print(f"  已翻译 {min(i + batch_size, len(texts))}/{len(texts)}")

            except Exception as e:
                print(f"  翻译批次 {i // batch_size + 1} 失败: {e}")

            time.sleep(1)

        return results


class OllamaTranslator(AITranslator):
    """本地 Ollama 翻译器"""

    def __init__(self, model: str = "qwen2.5:14b", host: str = "http://localhost:11434",
                 glossary: Dict[str, str] = None):
        super().__init__(glossary)
        self.model = model
        self.host = host

    def translate_batch(self, texts: List[dict], batch_size: int = 10) -> List[dict]:
        """批量翻译"""
        try:
            import requests
        except ImportError:
            raise ImportError("请安装 requests: pip install requests")

        results = []

        for i in range(0, len(texts), batch_size):
            batch = texts[i:i + batch_size]
            prompt = TRANSLATION_PROMPT.format(
                glossary=self._format_glossary(),
                texts=self._format_texts(batch)
            )

            try:
                response = requests.post(
                    f"{self.host}/api/generate",
                    json={
                        "model": self.model,
                        "prompt": prompt,
                        "stream": False,
                        "options": {
                            "temperature": 0.3
                        }
                    },
                    timeout=120
                )
                response.raise_for_status()

                translated = self._parse_response(response.json()["response"])
                results.extend(translated)

                print(f"  已翻译 {min(i + batch_size, len(texts))}/{len(texts)}")

            except Exception as e:
                print(f"  翻译批次 {i // batch_size + 1} 失败: {e}")

        return results


class DeepSeekTranslator(AITranslator):
    """DeepSeek API 翻译器"""

    def __init__(self, api_key: str = None, model: str = "deepseek-chat",
                 glossary: Dict[str, str] = None):
        super().__init__(glossary)
        self.api_key = api_key or os.environ.get("DEEPSEEK_API_KEY")
        self.model = model
        self.base_url = "https://api.deepseek.com/v1"

        if not self.api_key:
            raise ValueError("需要设置 DEEPSEEK_API_KEY 环境变量或传入 api_key")

    def translate_batch(self, texts: List[dict], batch_size: int = 20) -> List[dict]:
        """批量翻译"""
        try:
            import requests
        except ImportError:
            raise ImportError("请安装 requests: pip install requests")

        results = []

        for i in range(0, len(texts), batch_size):
            batch = texts[i:i + batch_size]
            prompt = TRANSLATION_PROMPT.format(
                glossary=self._format_glossary(),
                texts=self._format_texts(batch)
            )

            # 重试机制
            max_retries = 3
            for retry in range(max_retries):
                try:
                    response = requests.post(
                        f"{self.base_url}/chat/completions",
                        headers={
                            "Authorization": f"Bearer {self.api_key}",
                            "Content-Type": "application/json"
                        },
                        json={
                            "model": self.model,
                            "messages": [
                                {"role": "system", "content": "你是专业的游戏本地化翻译专家。"},
                                {"role": "user", "content": prompt}
                            ],
                            "temperature": 0.3,
                            "max_tokens": 4096
                        },
                        timeout=120
                    )
                    response.raise_for_status()

                    result = response.json()
                    translated = self._parse_response(result["choices"][0]["message"]["content"])
                    results.extend(translated)

                    print(f"  已翻译 {min(i + batch_size, len(texts))}/{len(texts)}")
                    break  # 成功，跳出重试循环

                except Exception as e:
                    if retry < max_retries - 1:
                        print(f"  翻译失败，第 {retry + 1} 次重试: {e}")
                        time.sleep(3)  # 等待3秒后重试
                    else:
                        print(f"  翻译批次 {i // batch_size + 1} 最终失败: {e}")

            time.sleep(0.5)  # 避免 rate limit

        return results


def merge_translations(original_data: dict, translations: List[dict]) -> dict:
    """合并翻译结果到原始数据"""
    # 创建 id -> translation 映射
    trans_map = {t["id"]: t["translation"] for t in translations if t.get("translation")}

    # 更新原始数据
    for text in original_data.get("texts", []):
        if text["id"] in trans_map:
            text["translation"] = trans_map[text["id"]]

    # 更新统计
    translated_count = sum(1 for t in original_data.get("texts", []) if t.get("translation"))
    original_data["meta"]["translated_count"] = translated_count

    return original_data


def main():
    parser = argparse.ArgumentParser(description='CMSS13 AI 翻译工具')
    parser.add_argument('--input', '-i', required=True, help='输入的 JSON 文件')
    parser.add_argument('--output', '-o', help='输出的 JSON 文件 (默认: input_cn.json)')
    parser.add_argument('--api', choices=['openai', 'anthropic', 'ollama', 'deepseek'], default='deepseek',
                       help='使用的 API (默认: deepseek)')
    parser.add_argument('--model', help='模型名称')
    parser.add_argument('--batch-size', type=int, default=20, help='每批翻译的文本数量')
    parser.add_argument('--skip-translated', action='store_true', help='跳过已翻译的文本')
    parser.add_argument('--glossary', help='额外的词典文件 (JSON)')

    args = parser.parse_args()

    # 加载输入文件
    with open(args.input, 'r', encoding='utf-8') as f:
        data = json.load(f)

    texts = data.get("texts", [])
    print(f"加载了 {len(texts)} 条文本")

    # 过滤已翻译的
    if args.skip_translated:
        texts = [t for t in texts if not t.get("translation")]
        print(f"需要翻译 {len(texts)} 条")

    if not texts:
        print("没有需要翻译的文本")
        return

    # 加载额外词典
    glossary = GLOSSARY.copy()
    if args.glossary:
        with open(args.glossary, 'r', encoding='utf-8') as f:
            extra = json.load(f)
            glossary.update(extra)

    # 创建翻译器
    if args.api == 'openai':
        model = args.model or 'gpt-4'
        translator = OpenAITranslator(model=model, glossary=glossary)
    elif args.api == 'anthropic':
        model = args.model or 'claude-sonnet-4-20250514'
        translator = AnthropicTranslator(model=model, glossary=glossary)
    elif args.api == 'deepseek':
        model = args.model or 'deepseek-chat'
        translator = DeepSeekTranslator(api_key=os.environ.get("DEEPSEEK_API_KEY"), model=model, glossary=glossary)
    else:
        model = args.model or 'qwen2.5:14b'
        translator = OllamaTranslator(model=model, glossary=glossary)

    print(f"\n使用 {args.api} API, 模型: {model}")
    print("开始翻译...\n")

    # 执行翻译
    translations = translator.translate_batch(texts, args.batch_size)

    # 合并结果
    result = merge_translations(data, translations)

    # 保存
    output_path = args.output or args.input.replace('.json', '_cn.json')
    with open(output_path, 'w', encoding='utf-8') as f:
        json.dump(result, f, ensure_ascii=False, indent=2)

    translated_count = result["meta"].get("translated_count", 0)
    print(f"\n完成! 已翻译 {translated_count}/{len(data['texts'])} 条")
    print(f"保存到: {output_path}")


if __name__ == '__main__':
    main()
