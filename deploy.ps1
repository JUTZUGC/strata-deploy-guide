# Strata 一键部署脚本（第三方指南）——按官方文档封装
# 官方文档：https://github.com/Niko1221/Strata#install
# 更新日期：2026-10-27
# 类型：binary
$ErrorActionPreference = 'Stop'
Set-Location -Path $PSScriptRoot

if (-not (Get-Command curl.exe -ErrorAction SilentlyContinue)) { throw '需要先安装 curl（Windows 10+ 自带 curl.exe）' }

New-Item -ItemType Directory -Force -Path .download | Out-Null
Set-Location -Path .download

curl.exe -L --fail -o Strata-Setup.exe https://github.com/Niko1221/Strata/releases/download/v0.2.6/Strata-0.2.6-windows-x64-setup.exe
$h = (Get-FileHash -Algorithm SHA256 Strata-Setup.exe).Hash.ToLower() ; if ($h -ne '90945b97828f3b248e0d31cb1bb7656bce08e9f874eb8034ad0322e3349dce4f') { throw "SHA256 校验失败，文件可能不完整，请重试" }
Start-Process -FilePath .\Strata-Setup.exe -Wait ; Write-Host '安装完成：首次启动会按显卡下载引擎和模型，请预留足够磁盘'

Write-Host ''

Write-Host '安装完成：打开 Strata 选一个模型；终端用户运行 strata launch，再用 strata connect 接入 Claude Code / Codex'
Write-Host '若结果异常或需要改配置，请参考官方文档：https://github.com/Niko1221/Strata#install'
