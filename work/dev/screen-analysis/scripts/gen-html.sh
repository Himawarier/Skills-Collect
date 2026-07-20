#!/usr/bin/env bash
# screen-analysis 辅助脚本
# 用于生成交互式HTML预览文件
# 使用方法: ./gen-html.sh <界面名称> <宽度> <高度> <控件JSON文件> <交互JSON文件> [-o <输出文件>]

set -euo pipefail

if [ $# -lt 5 ]; then
  echo "用法: $0 <界面名称> <宽度> <高度> <控件JSON> <交互JSON> [-o <输出文件>]"
  echo ""
  echo "参数:"
  echo "  界面名称     界面描述名称（如 \"主界面\"）"
  echo "  宽度         屏幕像素宽度（如 800）"
  echo "  高度         屏幕像素高度（如 480）"
  echo "  控件JSON     控件数据的JSON文件路径"
  echo "  交互JSON     交互逻辑映射的JSON文件路径"
  echo "  -o <文件>    输出HTML文件路径（默认: ./screen_preview_<界面名>.html）"
  exit 1
fi

NAME="$1"
WIDTH="$2"
HEIGHT="$3"
CTRL_JSON="$4"
INTERACT_JSON="$5"
OUTPUT="${6:-./screen_preview_${NAME}.html}"

# 验证依赖
for cmd in jq python3; do
  if ! command -v "$cmd" &>/dev/null; then
    echo "错误: 需要 $cmd，请先安装"
    exit 1
  fi
done

# 读取JSON数据
if [ ! -f "$CTRL_JSON" ]; then
  echo "错误: 控件JSON文件不存在: $CTRL_JSON"
  exit 1
fi
if [ ! -f "$INTERACT_JSON" ]; then
  echo "错误: 交互JSON文件不存在: $INTERACT_JSON"
  exit 1
fi

# 使用python3生成HTML（更安全地处理JSON）
python3 -c "
import json, sys

# 读取数据
with open('$CTRL_JSON') as f:
    controls = json.load(f)
with open('$INTERACT_JSON') as f:
    interactions = json.load(f)

name = '$NAME'
w = $WIDTH
h = $HEIGHT

# 注入到模板中并输出
# (这里输出HTML骨架，实际由AI主流程构建完整HTML)
print(json.dumps({
    'name': name,
    'width': w,
    'height': h,
    'control_count': len(controls),
    'interaction_count': len(interactions),
    'controls': controls,
    'interactions': interactions
}))
"

echo ""
echo "参数已就绪，继续由AI生成完整HTML..."
