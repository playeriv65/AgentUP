# AgentUP

中文讲解视频制作与多平台投稿工作流的基础项目，面向 Windows。第一份示例是用四种视角理解矩阵乘法。

## 工作流

文案与分镜 → TTS 配音 → Remotion 动画 → 本地预览与渲染 → 账号登录与检查 → 调用投稿工具发布。

这是一个可运行的初始版本。文案、分镜和动画目前由人工编辑；配音和渲染可通过命令执行，发布需要显式运行投稿命令。尚未完成四个平台的实际投稿验证。

## 快速开始

需要安装 uv、Node.js/npm、Google Chrome。PowerShell 在项目根目录执行：

```powershell
.\agentup.ps1 setup
.\agentup.ps1 preview
.\agentup.ps1 render
```

视频生成到 `outputs/`。示例配音已附带，首次预览无需请求 TTS 服务。修改 `scripts/voice.py` 的文案后执行：

```powershell
.\agentup.ps1 voice
```

当前使用 edge-tts 的 `zh-CN-YunxiNeural`，需要联网。配音时长改变后需要同步调整 `remotion/src/index.tsx` 的章节时间；目前未实现自动对齐。

## 登录与投稿

```powershell
.\agentup.ps1 login bilibili -Account main
.\agentup.ps1 check bilibili -Account main
.\agentup.ps1 login douyin -Account main
.\agentup.ps1 login tencent -Account main
.\agentup.ps1 login youtube -Account main
```

B站登录方式由用户在 biliup 的终端菜单自行选择。部分账号可能被 TV 认证接口拒绝（48007）；网页 Cookie 有效不代表可以通过当前 biliup 的认证检查。

投稿使用仓库自带 CLI，在 `publisher/` 目录操作，例如查看 B站参数：

```powershell
cd publisher
uv run sau bilibili upload-video --help
```

`douyin` 是抖音，`tencent` 是视频号。先检查视频、封面、标题、简介和目标账号，再显式执行 `upload-video` 命令；渲染不会自动投稿。

## 目录

- `agentup.ps1`：安装、配音、预览、渲染、登录和检查入口。
- `scripts/voice.py`：示例讲稿与 TTS。
- `remotion/`：矩阵乘法动画，包含内积、外积、行空间和列空间重新组合。
- `publisher/`：基于 social-auto-upload 的 CLI 和上传模块。
- `outputs/`：本地成品和预览，不提交 Git。

## 本地配置与来源

安装时将 `publisher/conf.example.py` 复制为本地 `conf.py`。Chrome 路径可通过 `AGENTUP_CHROME_PATH` 覆盖，YouTube 代理可通过 `AGENTUP_YT_PROXY` 配置。账号 Cookie、二维码、运行时、环境和配置均被 Git 忽略，公开仓库不附带账号。

投稿模块来自 [dreammis/social-auto-upload](https://github.com/dreammis/social-auto-upload)，基础提交 `0012d2c355f88f683cc38dde2a2db209e14091bc`，保留其 MIT 许可证（`publisher/LICENSE`）。本地改动包括补齐 Playwright 依赖、使用已安装的 Chrome，以及将 biliup 运行时放到项目本地目录。biliup 按上游逻辑首次使用时下载。Remotion 及 TTS 服务遵循各自的许可和使用条件。
