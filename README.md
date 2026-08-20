# Hermes Studio Web - Mobile Adaptation

> **Disclaimer / 声明**: This project is a mobile web adaptation for [Hermes Studio](https://github.com/EKKOLearnAI/hermes-studio), not an official project. Thanks to the EKKO team for developing this excellent open-source project.
> 
> 本项目是基于 [Hermes Studio](https://github.com/EKKOLearnAI/hermes-studio) 桌面版的移动端 Web 适配页面，非官方项目。感谢 EKKO 团队开发的优秀开源项目。

A mobile-optimized web adaptation for Hermes Studio desktop app. Provides a phone-friendly chat interface through an independent `mobile/` directory without modifying the desktop version.

Hermes Studio 桌面版的移动端 Web 适配页面。通过独立的 `mobile/` 目录提供手机优化的聊天界面，无需修改桌面版代码。

## Features / 功能特性

- 📱 **Mobile-optimized layout / 移动端优化布局** - Chat interface adapted for phone screens / 适配手机屏幕的聊天界面
- 🎨 **Dark/Light theme / 深色/浅色主题** - Auto-follow system or manual toggle / 跟随系统或手动切换
- 💬 **Full chat functionality / 完整聊天功能** - Message sending, streaming replies, tool calls / 消息发送、流式回复、工具调用
- 📂 **Model switching / 模型切换** - Switch LLM models and reasoning depth / 支持切换 LLM 模型和思考深度
- 📊 **Context display / 上下文显示** - Real-time token usage / 实时显示 token 用量
- 🔧 **Input expansion / 输入框展开** - One-tap expand for long text editing / 长文本输入时一键展开编辑
- 📋 **Sidebar / 侧边栏** - Session management, settings, history / 会话管理、设置、历史记录

## Project Structure / 项目结构

```
Hermes-Studio-Web/
├── mobile/                 # Mobile pages (independent, update-safe) / 移动端页面（独立目录，更新安全）
│   ├── index.html          # Main page with all mobile CSS/JS / 主页面（含所有移动端适配 CSS/JS）
│   ├── app.css             # Base styles / 基础样式
│   ├── chat-page.css       # Chat page styles / 聊天页面样式
│   ├── socket.io.min.js    # WebSocket client / WebSocket 客户端
│   └── icons/              # Icon files / 图标文件
├── screenshots/            # Screenshots / 软件截图
│   ├── login.png           # Login screen / 登录界面
│   ├── screenshot1.png     # Main interface / 主界面
│   └── chat.png            # Chat interface / 聊天界面
├── install.bat             # One-click installer / 一键安装脚本
└── README.md               # This file / 本文件
```

## Installation / 安装方法

### Prerequisites / 前置要求

- Hermes Studio desktop app installed and running (default port `8748`) / Hermes Studio 桌面版已安装并运行（默认端口 `8748`）
- Phone and computer on the same LAN (or use frp tunnel) / 手机和电脑在同一局域网（或使用 frp 穿透）

### Step 1: Deploy mobile directory / 步骤 1：放置 mobile 目录

Copy the `mobile/` directory to Hermes Studio's Web UI directory:

将 `mobile/` 目录复制到 Hermes Studio 的 Web UI 目录：

```bash
# Windows example / Windows 示例
xcopy /E /I mobile "C:\Users\<username>\AppData\Local\Programs\Hermes Studio\resources\webui\dist\client\mobile"

# Or create a directory junction (recommended, update-safe) / 或者创建目录链接（推荐，更新安全）
mklink /J "C:\Users\<username>\AppData\Local\Programs\Hermes Studio\resources\webui\dist\client\mobile" "C:\path\to\Hermes-Studio-Web\mobile"
```

### Step 2: Access mobile page / 步骤 2：访问移动端页面

- **LAN / 局域网**: `http://<computer-ip>:8748/mobile/`
  - Example / 示例: `http://192.168.1.x:8748/mobile/` (replace x with your IP last segment / 把 x 换成你的电脑 IP 最后一段)
- **External (frp tunnel) / 外网（frp 穿透）**: `http://<server-ip>:8748/mobile/`
  - Example / 示例: `http://<your-server-ip-or-domain>:8748/mobile/`

### Step 3: Open on phone browser / 步骤 3：手机浏览器打开

Open the URL above in your phone's Safari/Chrome browser.

用手机 Safari/Chrome 打开上述地址即可。

## Screenshots / 界面截图

| Login / 登录界面 | Main / 主界面 | Chat / 聊天界面 |
|---------|--------|---------|
| ![Login](screenshots/login.png) | ![Main](screenshots/screenshot1.png) | ![Chat](screenshots/chat.png) |

## Technical Details / 技术说明

### Implementation / 实现原理

1. **Reuse desktop resources / 复用桌面版资源** - Load desktop Vite bundle (JS/CSS), no logic duplication / 加载桌面版的 Vite bundle（JS/CSS），不重复实现逻辑
2. **CSS override layer / CSS 覆盖层** - Inject mobile adaptation styles in `mobile/index.html` / 在 `mobile/index.html` 中注入移动端适配样式
3. **DOM restructuring / DOM 重组** - Use JavaScript to adjust input/toolbar layout / 用 JavaScript 调整输入框、工具栏的布局结构
4. **Junction link / Junction 链接** - Use Windows directory junction to avoid desktop updates / 用 Windows 目录链接避免桌面版更新覆盖

### Key Features / 关键特性

| Feature / 特性 | Implementation / 实现方式 |
|------|---------|
| Input expansion / 输入框展开 | Negative margin-top + height expansion, bottom fixed upward growth / 负 margin-top + 高度扩展，底部固定向上生长 |
| Model switch alignment / 模型切换对齐 | Dynamically read reasoning button width, force consistency / 动态读取思考等级按钮宽度，强制一致 |
| Theme switching / 主题切换 | CSS variables `--bg-card` / `--text-primary` auto-adapt / CSS 变量 `--bg-card` / `--text-primary` 自动适配 |
| Send button / 发送按钮 | Extracted from desktop SVG icons (linear arrow/square) / 提取桌面版 SVG 图标（线性箭头/方块） |
| Sidebar / 侧边栏 | Full-screen drawer, enlarged fonts/icons for touch / 全屏抽屉化，字体/图标放大适配触摸 |

## Maintenance / 更新维护

After desktop updates, if `webui/dist/client/mobile/` is cleared:

桌面版更新后，如果 `webui/dist/client/mobile/` 被清除：

1. Recreate junction link / 重新创建 junction 链接：
   ```bash
   mklink /J "C:\Users\<username>\AppData\Local\Programs\Hermes Studio\resources\webui\dist\client\mobile" "C:\path\to\Hermes-Studio-Web\mobile"
   ```

2. Or recopy `mobile/` directory to `webui/dist/client/` / 或者重新复制 `mobile/` 目录到 `webui/dist/client/`

## License & Compliance / 许可证与合规声明

**Important / 重要**: This project is a mobile adaptation of Hermes Studio, which uses the **Business Source License 1.1 (BSL 1.1)**.

本项目是基于 Hermes Studio 的移动端适配，Hermes Studio 使用 **Business Source License 1.1 (BSL 1.1)** 许可证。

### Allowed Use Cases / 允许的使用场景 ✅
- Personal use / 个人使用
- Education / 教育用途
- Research / 研究目的

### Commercial Use Requires License / 需要商业授权的场景 ❌
- Selling or licensing to others / 销售或授权给他人使用
- SaaS hosting / SaaS 托管服务
- Embedding in commercial products / 嵌入到商业产品中

> Commercial use requires a separate license from EKKOLearnAI.
> BSL 1.1 converts to Apache License 2.0 on **2029-05-10**.
> 
> 商业使用需要联系 EKKOLearnAI 获取单独的商业许可证。
> BSL 1.1 许可证将在 **2029-05-10** 自动转换为 Apache License 2.0。

### Original Project License / 原项目许可证

- **Hermes Studio**: https://github.com/EKKOLearnAI/hermes-studio/blob/main/LICENSE
- **License type / 许可证类型**: Business Source License 1.1 (BSL 1.1)
- **Conversion date / 转换日期**: 2029-05-10 to Apache 2.0 / 2029-05-10 转为 Apache 2.0

This project's code is MIT License, but Hermes Studio resources must comply with BSL 1.1.

本项目代码本身采用 MIT License，但使用 Hermes Studio 相关资源时需遵守其 BSL 1.1 许可证条款。

## Acknowledgments / 致谢

- **[Hermes Studio](https://github.com/EKKOLearnAI/hermes-studio)** - AI assistant desktop app by EKKO, this project is a mobile adaptation of its Web UI / 由 EKKO 开发的 AI 助手桌面应用，本项目基于其 Web UI 进行移动端适配
  - GitHub: https://github.com/EKKOLearnAI/hermes-studio
  - Website / 官网: https://hermes-studio.ai/
- **[Naive UI](https://www.naiveui.com/)** - Vue component library used in desktop version / 桌面版使用的 Vue 组件库
  - GitHub: https://github.com/tusen-ai/naive-ui
- **[Socket.IO](https://socket.io/)** - Real-time communication library / 实时通信库
  - GitHub: https://github.com/socketio/socket.io

## Related Projects / 相关项目

- [Hermes Studio](https://github.com/EKKOLearnAI/hermes-studio) - Official desktop project / 桌面版主项目（官方）
  - GitHub: https://github.com/EKKOLearnAI/hermes-studio
  - Website / 官网: https://hermes-studio.ai/
