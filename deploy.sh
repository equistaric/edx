#!/bin/bash
# 一键部署爱德思学习系统：重新生成 index.html / teacher.html → 镜像到 iCloud 之外 → 推送。
# 用法：双击本文件，或终端 ./deploy.sh "提交说明"
# 题库有更新（重切了题）时，先跑 _state/build_bank.py 再跑本脚本。
set -e
SRC="$(cd "$(dirname "$0")" && pwd)"
STATE="$(dirname "$SRC")/_state"
python3 "$STATE/build_site.py" "$SRC"
DST="$HOME/Sites/edxlearn"
mkdir -p "$HOME/Sites"
if [ ! -d "$DST/.git" ]; then
  echo "首次部署：请先在 GitHub 建一个仓库（例如 equistaric/edx），然后运行："
  echo "  git clone https://github.com/equistaric/edx.git \"$DST\""
  exit 1
fi
rsync -a --delete --exclude .DS_Store --exclude '._*' --exclude .git --exclude _private "$SRC/" "$DST/"
cd "$DST"
git add -A
if git diff --cached --quiet; then echo "没有改动，无需部署。"; exit 0; fi
git -c user.email=teacher@equistar -c user.name=Equistar commit -q -m "${1:-更新 $(date '+%Y-%m-%d %H:%M')}"
git push -q origin main
echo "已推送。约 1–3 分钟后生效。"
