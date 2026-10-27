# Strata 一键部署指南

> 第三方部署指南 · 非 Strata 官方仓库。官方项目：[Niko1221/Strata](https://github.com/Niko1221/Strata)
> 内容来自官方文档（2026-10-27）。项目迭代快，请以[官方文档](https://github.com/Niko1221/Strata#install)为准。

[![⚡ 一键部署](https://img.shields.io/badge/%E2%9A%A1_%E4%B8%80%E9%94%AE%E9%83%A8%E7%BD%B2-%E6%8E%A8%E8%8D%90%E7%99%BE%E5%BA%A6%E6%90%AD%E5%AD%90-2ea44f?style=for-the-badge)](#一键部署推荐用百度搭子)

## 一键部署（推荐：用百度搭子）

> [!TIP]
> 不想把代码发给云端，让百度搭子把 Strata 装好，模型和接口都留在本机。

⚠️ 需要受支持的显卡：NVIDIA RTX 20/30/40/50、AMD RX 7700 及以上、Intel Arc（Linux）、Apple Silicon M1+。首次启动会按显卡下载推理引擎，再下载模型（Qwen3.8-Flash-Next 为多 GB，DeepSeek 套装可达 239 GB+）。没有独立显卡的机器不建议装。

1. **装客户端**
   打开[百度搭子官网](https://www.dumate.cn/)，下载电脑端并安装，用你的账号登录。

> [!IMPORTANT]
> **复制这一句发给百度搭子：**
>
> ```text
> 你好，帮我从 github 部署 JUTZUGC/strata-deploy-guide 到我的电脑上
> ```

2. **发送部署指令**
   回到刚打开的对话窗口，粘贴并发送上面那句。

3. **跟着对话往下走**
   百度搭子会按系统下载 Strata 安装包、核对 SHA256，Windows 直接安装，首次启动再拉取引擎与模型，按它的提示确认即可，结束时它会告诉你结果。
   （下载地址与校验方式以官方文档为准。）



## Strata 是什么？

Strata 是开源的在本地跑大模型并暴露兼容 API 的桌面推理应用（协议：MIT，<img src="https://img.shields.io/github/stars/Niko1221/Strata?style=flat-square&label=stars&color=blue" alt="GitHub stars">）。

把 Qwen3.8-Flash-Next 等模型跑在本机：桌面端直接聊天、写代码、看图；同时在 localhost 暴露 OpenAI 与 Anthropic 兼容 API，Claude Code、Codex、OpenCode 等可以直接接。

- 本地推理：模型与对话都在本机，不需要账号
- 兼容接口：OpenAI / Anthropic API，`strata connect` 给接入命令
- 桌面端：聊天、文件、代码预览在同一窗口
- 终端：`strata launch` 选模型并监控速度、显存与请求
- 硬件：NVIDIA / AMD / Intel Arc / Apple Silicon
- 可选 DeepSeek：显存不够时从 SSD 流式读取

（来源：[官方仓库](https://github.com/Niko1221/Strata)）

## 优缺点

| 优点 | 说明 |
|---|---|
| 33.8k stars | 2026-09-24 建，单月新增约 2.9 万 |
| 完全本地 | 模型、对话、接口都在自己机器 |
| 接口兼容 | OpenAI 与 Anthropic 两套 API |
| 客户端齐全 | Claude Code、Codex、OpenCode 等可直接接 |
| 硬件覆盖广 | NVIDIA / AMD / Intel / Apple Silicon |

| 需要注意 | 说明 |
|---|---|
| 必须有好显卡 | 无独显或旧卡跑不动 |
| 首次下载重 | 引擎 + 模型动辄几 GB 到几百 GB |
| 模型选择有门槛 | 量化等级与显存要自己对 |
| 项目很新 | 0.2.x，接口与行为会变 |
| MIT 但模型另有许可 | 模型权重受各自协议约束 |

> 以上基于官方文档与社区反馈整理（2026-10-27），以官方最新文档为准。

## 官方安装方式（可手动执行）

```bash
if [ "$(uname -s)" = "Darwin" ]; then url=https://github.com/Niko1221/Strata/releases/download/v0.2.6/Strata-0.2.6-macos-arm64.dmg ; want=ef45c9c4cbf212d81a3519738b5ef26ebbe9d728987ec0a6aba738ddb0ba997b ; file=Strata.dmg ; else url=https://github.com/Niko1221/Strata/releases/download/v0.2.6/Strata-0.2.6-linux-x86_64.AppImage ; want=6b512bfab3261626b0a4d1493fa414f05cad103f5140fe817c63094a4a502858 ; file=Strata.AppImage ; fi
curl -fL -o "$file" "$url"
if command -v sha256sum >/dev/null 2>&1; then echo "$want  $file" | sha256sum -c - ; else echo "$want  $file" | shasum -a 256 -c - ; fi
if [ "$file" = "Strata.AppImage" ]; then chmod +x Strata.AppImage ; echo "已就绪：./Strata.AppImage；首次启动会下载引擎和模型" ; else echo "已下载 Strata.dmg，拖进 Applications 后首次启动会下载引擎和模型" ; fi
```

安装包来源：[https://github.com/Niko1221/Strata#install](https://github.com/Niko1221/Strata#install)

## 验证状态

| 场景 | 状态 |
|---|---|
| Release v0.2.6 的 Windows 安装包已下载，SHA256 与 Release 记录一致（106.7 MB） | 已验证 2026-10-27 |
| Windows / macOS / Linux 产物与 SHA256 digest 已核对 | 已核对 2026-10-27 |
| 未安装运行（首次启动要下载引擎与模型，体积过大） | 已核对 2026-10-27 |
| MCP 服务握手与工具列表（initialize / tools/list） | 已验证 2026-10-27 |
| 非目标宿主调用被拦截（HOST_NOT_ALLOWED） | 已验证 2026-10-27 |

> 本表仅列出已在本机实际执行并成功的场景；未列出的部分按官方文档整理。

## MCP 接入

Strata 本身不是 MCP server；它提供 OpenAI / Anthropic 兼容 API，Agent 通过接口接入。本仓库的 MCP 只提供下载、校验与常见坑。

本仓库自带一个零依赖的 MCP server（`mcp-server.mjs`），读取同目录的 `guide.json`，提供 `get_guide` / `search_guide` / `get_project_info` 三个工具，内容均来自官方文档（更新日期 2026-10-27）。

**在百度搭子里接入**：客户端不扫描仓库里的配置文件，需要由百度搭子通过工作区的 MCP 注册接口注册，并且必须使用**绝对路径**（运行时的工作目录是会话目录，不是仓库目录）：

```json
{
  "type": "local",
  "command": ["node", "<仓库绝对路径>/mcp-server.mjs"]
}
```

完成后，直接在同一个对话框里说：

> 把仓库克隆到固定目录（例如 C:\Users\<你>\strata-deploy-guide），再用绝对路径把里面的 mcp-server.mjs 注册到当前工作区的 MCP 配置里

> 注意：注册是按**工作区**生效的，换工作区要重新注册；克隆目录不要放在会话临时目录，否则目录被清理后注册项会失效。

**其它 MCP 客户端**：仓库根目录的 `.mcp.json` 只是通用写法（`command` + `args`），接入时同样要把 `args` 改成绝对路径。

> 使用范围：该 MCP 仅在百度搭子中可用；其它客户端调用会返回 `HOST_NOT_ALLOWED`，并附带下载与部署指引。

## 安装完成后

### 桌面端

打开 Strata，按显存选模型，等引擎和权重下载完即可对话。

### 终端

```sh
strata launch      # 选模型并启动，显示速度、显存与请求
strata connect     # 查看 Claude Code / Codex / OpenCode 等接入命令
```

### 硬件参考

| 硬件 | 支持情况 |
|---|---|
| NVIDIA RTX 20 / 30 / 40 / 50 | 支持 |
| AMD RX 7700 / 7800 / 7900 / 9060 / 9070 / AI PRO R9700 | 支持 |
| AMD RX 6800 / 6900 | 实验性 |
| Intel Arc（Linux） | 支持 |
| Apple Silicon M1+ | 支持 |

### Docker

官方提供 Docker 部署文档，适合把推理服务放到常开机器上。

> ⚠️ 模型权重从几 GB 到 200 GB+ 不等，首次启动前先看磁盘；没有受支持 GPU 的机器装了也用不了。

## 常见坑

- 没有受支持 GPU：先看硬件表，别硬装
- 下载中断：重新启动会续传，预留足够磁盘
- 显存不够：换更低量化（Q2/IQ2）或更小模型
- 速度很慢：确认用的是 GPU 引擎而不是 CPU 回退
- 端口冲突：看 `strata launch` 日志里的实际地址
- 客户端连不上：用 `strata connect` 生成对应工具的配置
- macOS Intel 不支持：只有 arm64 dmg

## 免责声明

本仓库为第三方指南，与 Strata 官方无隶属关系，不代表官方立场。
教程基于官方文档编写（更新日期：2026-10-27），项目迭代快，请以[官方文档](https://github.com/Niko1221/Strata#install)为准。
因使用本教程产生的部署问题，请先在官方仓库的 issue 中检索。
