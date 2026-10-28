#!/usr/bin/env bash
set -euo pipefail
# Strata 一键部署脚本（第三方指南）——按官方文档封装
# 官方文档：https://github.com/Niko1221/Strata#install
# 更新日期：2026-10-28
# 类型：binary
cd "$(dirname "${BASH_SOURCE[0]}")"

command -v curl >/dev/null 2>&1 || { echo "需要先安装 curl"; exit 1; }

mkdir -p .download
cd .download

if [ "$(uname -s)" = "Darwin" ]; then url=https://github.com/Niko1221/Strata/releases/download/v0.2.7/Strata-0.2.7-macos-arm64.dmg ; want=aa7c2177c86685fe0793e9cd5677c174f8c5237df0a33b8d7eaf3003259bbbfb ; file=Strata.dmg ; else url=https://github.com/Niko1221/Strata/releases/download/v0.2.7/Strata-0.2.7-linux-x86_64.AppImage ; want=701a0325729bbe75eb24c77aee1e45b8fc2e46a74ef1d25475cfef2a3ef1b281 ; file=Strata.AppImage ; fi
curl -fL -o "$file" "$url"
if command -v sha256sum >/dev/null 2>&1; then echo "$want  $file" | sha256sum -c - ; else echo "$want  $file" | shasum -a 256 -c - ; fi
if [ "$file" = "Strata.AppImage" ]; then chmod +x Strata.AppImage ; echo "已就绪：./Strata.AppImage；首次启动会下载引擎和模型" ; else echo "已下载 Strata.dmg，拖进 Applications 后首次启动会下载引擎和模型" ; fi

echo ""

echo "安装完成：打开 Strata 选一个模型；终端用户运行 strata launch，再用 strata connect 接入 Claude Code / Codex"
echo "若结果异常或需要改配置，请参考官方文档：https://github.com/Niko1221/Strata#install"
