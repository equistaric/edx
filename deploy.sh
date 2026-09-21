#!/bin/bash
# 2026-09-16 起爱德思学习系统已并入 CIE 学习系统（equistaric/plan）。本脚本只把跳转页 + 题图（img/ ans/）推到 equistaric/edx，
# 不再生成页面。页面改动请到 CIE/学习系统/ 跑 deploy.sh（它会同时读这里的 data.json）。
set -e
SRC="$(cd "$(dirname "$0")" && pwd)"
DST="$HOME/Sites/edxlearn"
mkdir -p "$HOME/Sites"
[ -d "$DST/.git" ] || git clone -q https://github.com/equistaric/edx.git "$DST"
rsync -a --delete --exclude .DS_Store --exclude '._*' --exclude .git --exclude _private "$SRC/" "$DST/"
cd "$DST"
git add -A
if git diff --cached --quiet; then echo "没有改动，无需部署。"; exit 0; fi
git -c user.email=teacher@equistar -c user.name=Equistar commit -q -m "${1:-更新 $(date '+%Y-%m-%d %H:%M')}"
if [ -n "$GH_TOKEN" ]; then
  git -c credential.helper='!f(){ echo "username=x-access-token"; echo "password=$GH_TOKEN"; }; f' push -q origin main
else
  git push -q origin main
fi
echo "已推送 equistaric/edx（跳转页 + 题图）。"
