#!/usr/bin/env bash
set -euo pipefail

if [[ -z "${GITHUB_TOKEN:-}" ]]; then
  echo "请先导出 GitHub Token：export GITHUB_TOKEN=你的PAT"
  exit 1
fi

OWNER="RaveyShare"
REPO="almond-front"
REMOTE="https://github.com/${OWNER}/${REPO}.git"

echo "创建远程仓库 ${OWNER}/${REPO} ..."
curl -sS -H "Authorization: token ${GITHUB_TOKEN}" \
  -H "Accept: application/vnd.github+json" \
  https://api.github.com/user/repos \
  -d "{\"name\":\"${REPO}\",\"private\":false}" \
  | jq -r '.html_url' || true

cd apps/almond-front
git config user.name "Ravey"
git config user.email "15132698828@163.com"
git remote remove origin >/dev/null 2>&1 || true
git remote add origin "${REMOTE}"
git push -u origin main
echo "前端已推送到 ${REMOTE}"
