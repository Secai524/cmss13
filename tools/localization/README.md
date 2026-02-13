# CMSS13 汉化工具 / Localization Tools

这是一套用于 CMSS13 游戏汉化的自动化工具。

## 功能特点

- **自动提取**: 从 DM 代码中提取需要翻译的文本
- **保留变量**: 自动识别并保留 `[var]`、`\the [src]` 等变量占位符
- **AI 翻译**: 支持 OpenAI、Anthropic、Ollama 等 AI API 自动翻译
- **专有名词**: 内置 CM13 专有名词词典，保证翻译一致性
- **安全注入**: 翻译后自动注入回代码，不破坏代码结构

## 文件说明

```
tools/localization/
├── dm_text_extractor.py   # 文本提取和注入工具
├── ai_translator.py       # AI 翻译工具
├── glossary.json          # 专有名词词典 (可选，用于扩展)
└── README.md              # 本文档
```

## 快速开始

### 1. 环境准备

```bash
# 确保 Python 3.8+
python --version

# 安装依赖 (根据使用的 API 选择)
pip install openai      # 使用 OpenAI
pip install anthropic   # 使用 Anthropic Claude
pip install requests    # 使用本地 Ollama
```

### 2. 提取文本

```bash
cd d:\ss13\cmss13

# 提取所有需要翻译的文本
python tools/localization/dm_text_extractor.py extract --output translations.json

# 或按类型分别导出
python tools/localization/dm_text_extractor.py extract --output-dir translations/
```

输出示例 (`translations.json`):
```json
{
  "meta": {
    "version": "1.0",
    "total_count": 15000
  },
  "texts": [
    {
      "id": "a1b2c3d4e5f6",
      "file_path": "code/game/objects/items/weapons/blades.dm",
      "line_number": 3,
      "text_type": "desc",
      "original": "A dusty sword commonly seen in historical museums.",
      "context": "2: name = \"combat sword\"\n3: desc = \"A dusty sword...\"\n4: icon_state = \"mercsword\"",
      "variables": [],
      "translation": ""
    }
  ]
}
```

### 3. AI 翻译

```bash
# 使用 OpenAI GPT-4
export OPENAI_API_KEY="your-api-key"
python tools/localization/ai_translator.py --input translations.json --api openai

# 使用 Anthropic Claude
export ANTHROPIC_API_KEY="your-api-key"
python tools/localization/ai_translator.py --input translations.json --api anthropic

# 使用本地 Ollama (需要先启动 Ollama)
python tools/localization/ai_translator.py --input translations.json --api ollama --model qwen2.5:14b
```

翻译后会生成 `translations_cn.json`。

### 4. 人工校对 (推荐)

在注入前，建议人工检查翻译质量：

```json
{
  "id": "a1b2c3d4e5f6",
  "original": "A dusty sword commonly seen in historical museums.",
  "translation": "一把常见于历史博物馆的落满灰尘的剑。"  // ← 检查这里
}
```

### 5. 注入翻译

```bash
# 将翻译注入回代码
python tools/localization/dm_text_extractor.py inject --input translations_cn.json
```

## 详细用法

### 文本提取器选项

```bash
python dm_text_extractor.py extract [选项]

选项:
  --path PATH           项目根目录 (默认: 当前目录)
  --output FILE         输出 JSON 文件
  --output-dir DIR      按类型分别输出到目录
  --subdirs DIR [DIR]   要扫描的子目录 (默认: code)
```

### AI 翻译器选项

```bash
python ai_translator.py [选项]

选项:
  --input FILE          输入的 JSON 文件 (必需)
  --output FILE         输出文件 (默认: input_cn.json)
  --api {openai,anthropic,ollama}  使用的 API
  --model MODEL         模型名称
  --batch-size N        每批翻译数量 (默认: 20)
  --skip-translated     跳过已翻译的文本
  --glossary FILE       额外的词典文件
```

### 注入器选项

```bash
python dm_text_extractor.py inject [选项]

选项:
  --path PATH           项目根目录
  --input FILE          翻译后的 JSON 文件 (必需)
  --subdirs DIR [DIR]   要处理的子目录
```

## 提取的文本类型

| 类型 | 说明 | 示例 |
|------|------|------|
| `name` | 物品/对象名称 | `name = "combat sword"` |
| `desc` | 描述文本 | `desc = "A dusty sword..."` |
| `message` | 表情消息 | `message = "blinks."` |
| `chat` | 聊天消息 | `to_chat(user, SPAN_NOTICE("..."))` |
| `visible_message` | 可见消息 | `visible_message(SPAN_DANGER("..."))` |
| `ui_text` | UI 文本 | `tgui_input_list(user, "Select...", "Title")` |

## 变量占位符

以下变量在翻译时会被保留，不要翻译：

| 占位符 | 说明 |
|--------|------|
| `[var]` | 变量引用 |
| `[src]`, `[user]`, `[target]` | 常见变量 |
| `\the [src]` | 带定冠词的变量 |
| `\a [src]`, `\an [src]` | 带不定冠词的变量 |
| `\his`, `\her`, `\him` | 代词 |
| `%t` | 表情目标 |
| `<b>`, `</b>` 等 | HTML 标签 |

## 专有名词词典

内置词典包含 CM13 游戏的专有名词翻译，确保一致性：

- **阵营**: USCM, Weyland-Yutani, CLF, UPP 等
- **异形种类**: Queen, Praetorian, Drone, Runner 等
- **军衔**: Private, Sergeant, Lieutenant, Captain 等
- **职业**: Squad Leader, Medic, Engineer, Pilot 等
- **武器**: M41A Pulse Rifle, Smartgun, Shotgun 等
- **地点**: USS Almayer, LV-624, Big Red 等

可以通过 `--glossary` 参数添加额外词典：

```json
{
  "Custom Term": "自定义翻译",
  "Another Term": "另一个翻译"
}
```

## 工作流程建议

```
1. 提取文本
   └── python dm_text_extractor.py extract --output translations.json

2. AI 翻译
   └── python ai_translator.py --input translations.json --api openai

3. 人工校对
   └── 编辑 translations_cn.json，检查翻译质量

4. 注入翻译
   └── python dm_text_extractor.py inject --input translations_cn.json

5. 测试游戏
   └── 编译并运行游戏，检查翻译效果

6. 迭代改进
   └── 根据测试结果调整翻译
```

## 注意事项

1. **备份代码**: 在注入翻译前，建议先备份或提交当前代码
2. **增量翻译**: 使用 `--skip-translated` 可以只翻译新增文本
3. **代码结构**: 工具只替换字符串内容，不会修改代码结构
4. **编码问题**: 确保所有文件使用 UTF-8 编码

## 常见问题

### Q: 提取的文本太多怎么办？
A: 可以按类型分别处理，优先翻译 `name` 和 `desc` 类型。

### Q: AI 翻译质量不好怎么办？
A: 建议使用 GPT-4 或 Claude，并进行人工校对。

### Q: 如何处理新增的文本？
A: 重新运行提取，使用 `--skip-translated` 只翻译新文本。

### Q: 注入后代码编译失败？
A: 检查翻译中是否有未转义的引号或特殊字符。

## 贡献

欢迎提交 Issue 和 PR 来改进这套工具！

## 许可

与 CMSS13 项目相同，遵循 AGPL-3.0 许可。
