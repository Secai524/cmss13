#!/usr/bin/env python3
"""全量翻译脚本 - 使用 DeepSeek API (修复版)"""

import os
import sys
import json
import time
from datetime import datetime

SCRIPT_DIR = os.path.dirname(os.path.abspath(__file__))
sys.path.insert(0, SCRIPT_DIR)
from ai_translator import DeepSeekTranslator, merge_translations, GLOSSARY

API_KEY = 'sk-cac51235c53d4e8f962abb7d5fc971ac'
INPUT_FILE = os.path.join(SCRIPT_DIR, 'full_extract.json')
OUTPUT_FILE = os.path.join(SCRIPT_DIR, 'full_extract_cn.json')
BATCH_SIZE = 25  # 每批翻译数量
CHECKPOINT_INTERVAL = 100  # 每100条保存一次检查点

def main():
    start_time = datetime.now()
    print(f"开始时间: {start_time.strftime('%Y-%m-%d %H:%M:%S')}")
    print("=" * 60)

    # 加载数据
    with open(INPUT_FILE, 'r', encoding='utf-8') as f:
        data = json.load(f)

    texts = data.get('texts', [])
    total = len(texts)
    print(f"总计需要翻译: {total} 条文本\n")

    # 检查是否有检查点
    checkpoint_file = OUTPUT_FILE + '.checkpoint'
    all_translations = []  # 所有翻译结果
    translated_ids = set()

    try:
        with open(checkpoint_file, 'r', encoding='utf-8') as f:
            checkpoint = json.load(f)
            translated_ids = set(checkpoint.get('translated_ids', []))
            all_translations = checkpoint.get('translations', [])
            print(f"发现检查点，已翻译 {len(translated_ids)} 条")
            print(f"已保存翻译结果: {len(all_translations)} 条")
            print("继续翻译...\n")
    except FileNotFoundError:
        print("未发现检查点，从头开始翻译...\n")

    # 过滤未翻译的
    texts_to_translate = [t for t in texts if t['id'] not in translated_ids]
    print(f"本次需要翻译: {len(texts_to_translate)} 条\n")

    if not texts_to_translate:
        print("所有文本已翻译完成！")
        # 直接生成最终文件
        result = merge_translations(data, all_translations)
        with open(OUTPUT_FILE, 'w', encoding='utf-8') as f:
            json.dump(result, f, ensure_ascii=False, indent=2)
        print(f"已保存到: {OUTPUT_FILE}")
        return

    # 创建翻译器
    translator = DeepSeekTranslator(
        api_key=API_KEY,
        model='deepseek-chat',
        glossary=GLOSSARY
    )

    print("使用 DeepSeek API, 模型: deepseek-chat")
    print(f"批次大小: {BATCH_SIZE}")
    print("=" * 60)
    print()

    # 记录本次翻译的起始数量，用于正确计算 ETA
    start_translated_count = len(translated_ids)
    this_session_count = 0

    for i in range(0, len(texts_to_translate), BATCH_SIZE):
        batch = texts_to_translate[i:i + BATCH_SIZE]
        batch_num = i // BATCH_SIZE + 1
        total_batches = (len(texts_to_translate) + BATCH_SIZE - 1) // BATCH_SIZE

        print(f"[批次 {batch_num}/{total_batches}] 翻译 {len(batch)} 条...")

        try:
            translations = translator.translate_batch(batch, batch_size=len(batch))

            # 保存翻译结果
            all_translations.extend(translations)
            this_session_count += len(translations)

            # 更新已翻译ID
            for t in translations:
                translated_ids.add(t['id'])

            # 计算进度 - 修复 ETA 计算
            total_translated = len(translated_ids)
            progress = total_translated / total * 100
            elapsed = (datetime.now() - start_time).total_seconds()

            # ETA 基于本次会话的翻译速度
            if this_session_count > 0:
                speed = this_session_count / elapsed  # 每秒翻译数
                remaining = total - total_translated
                eta = remaining / speed if speed > 0 else 0
            else:
                eta = 0

            print(f"  进度: {total_translated}/{total} ({progress:.1f}%)")
            print(f"  已用时: {elapsed/60:.1f} 分钟, 预计剩余: {eta/60:.1f} 分钟")
            print()

        except Exception as e:
            print(f"  批次翻译失败: {e}")
            print("  等待 5 秒后继续...")
            time.sleep(5)
            continue

        # 定期保存检查点
        if this_session_count % CHECKPOINT_INTERVAL < BATCH_SIZE:
            print("  >>> 保存检查点...")
            checkpoint = {
                'translated_ids': list(translated_ids),
                'translations': all_translations,
                'timestamp': datetime.now().isoformat()
            }
            with open(checkpoint_file, 'w', encoding='utf-8') as f:
                json.dump(checkpoint, f, ensure_ascii=False)
            print(f"  >>> 已保存 {len(all_translations)} 条翻译结果")

        # 避免 rate limit
        time.sleep(0.3)

    # 最终保存检查点
    print("\n保存最终检查点...")
    checkpoint = {
        'translated_ids': list(translated_ids),
        'translations': all_translations,
        'timestamp': datetime.now().isoformat()
    }
    with open(checkpoint_file, 'w', encoding='utf-8') as f:
        json.dump(checkpoint, f, ensure_ascii=False)

    # 合并所有翻译结果
    print("\n" + "=" * 60)
    print("合并翻译结果...")

    result = merge_translations(data, all_translations)

    # 保存最终结果
    with open(OUTPUT_FILE, 'w', encoding='utf-8') as f:
        json.dump(result, f, ensure_ascii=False, indent=2)

    end_time = datetime.now()
    duration = (end_time - start_time).total_seconds()

    translated_count = result['meta'].get('translated_count', 0)

    print(f"\n完成!")
    print(f"  已翻译: {translated_count}/{total} 条")
    print(f"  总用时: {duration/60:.1f} 分钟")
    print(f"  保存到: {OUTPUT_FILE}")
    print(f"结束时间: {end_time.strftime('%Y-%m-%d %H:%M:%S')}")

if __name__ == '__main__':
    main()
