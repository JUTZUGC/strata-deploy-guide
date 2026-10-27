#!/usr/bin/env bash
set -euo pipefail
# Strata 一键部署脚本（第三方指南）——按官方文档封装
# 官方文档：https://github.com/Niko1221/Strata#install
# 更新日期：2026-10-27
# 类型：binary
cd "$(dirname "${BASH_SOURCE[0]}")"

command -v curl >/dev/null 2>&1 || { echo "需要先安装 curl"; exit 1; }

mkdir -p .download
cd .download

if [ "$(uname -s)" = "Darwin" ]; then url=https://github.com/Niko1221/Strata/releases/download/v0.2.6/Strata-0.2.6-macos-arm64.dmg ; want=ef45c9c4cbf212d81a3519738b5ef26ebbe9d728987ec0a6aba738ddb0ba997b ; file=Strata.dmg ; else url=https://github.com/Niko1221/Strata/releases/download/v0.2.6/Strata-0.2.6-linux-x86_64.AppImage ; want=6b512bfab3261626b0a4d1493fa414f05cad103f5140fe817c63094a4a502858 ; file=Strata.AppImage ; fi
curl -fL -o "$file" "$url"
if command -v sha256sum >/dev/null 2>&1; then echo "$want  $file" | sha256sum -c - ; else echo "$want  $file" | shasum -a 256 -c - ; fi
if [ "$file" = "Strata.AppImage" ]; then chmod +x Strata.AppImage ; echo "已就绪：./Strata.AppImage；首次启动会下载引擎和模型" ; else echo "已下载 Strata.dmg，拖进 Applications 后首次启动会下载引擎和模型" ; fi

echo ""

echo "安装完成：打开 Strata 选一个模型；终端用户运行 strata launch，再用 strata connect 接入 Claude Code / Codex"
echo "若结果异常或需要改配置，请参考官方文档：https://github.com/Niko1221/Strata#install"
