# macenv-ini

一个用于 macOS 环境初始化的自动化脚本，帮助你在全新的 macOS 机器上快速搭建完整的开发环境。

## 功能特性

`install.sh` 脚本会自动完成以下配置：

### 1. Homebrew 包管理器
- 自动安装 Homebrew（如果尚未安装）
- 配置环境变量

### 2. Zsh 环境增强
- **oh-my-zsh** - 强大的 Zsh 框架
- **zsh-autosuggestions** - 类似 Fish 的命令自动建议
- **zsh-syntax-highlighting** - 命令语法高亮
- **Pure Prompt** - 简洁快速的 Zsh 主题

### 3. Node.js 开发环境
- **nvm** (Node Version Manager) - Node.js 版本管理器
- **Node.js LTS** - 安装最新的长期支持版本
- **npm 镜像** - 配置淘宝镜像加速下载

### 4. Python 开发环境
- **Python 3** - 通过 Homebrew 安装
- **pyenv** - Python 版本管理器
- **pipx** - Python 应用隔离安装工具

### 5. 常用开发工具
- **fzf** - 交互式模糊查找工具
- **ripgrep** - 极速代码搜索工具
- **fd** - 用户友好的 find 替代品
- **bat** - 带语法高亮的 cat
- **eza** - 现代化的 ls 替代品（支持图标）
- **jq / yq** - JSON / YAML 处理工具
- **htop** - 交互式进程查看器
- **ncdu** - 磁盘使用分析工具
- **tldr** - 简化的命令手册
- **git-delta** - 更美观的 Git diff 显示

### 6. iTerm2 主题
- **Snazzy** - 鲜艳的色彩主题（需手动导入）

### 7. 便捷别名
安装完成后，以下别名自动生效：
- `ls` → `eza --icons`
- `ll` → `eza -l --icons`
- `la` → `eza -la --icons`
- `cat` → `bat`

## 先决条件

- macOS 11.0 (Big Sur) 或更高版本
- 网络连接
- 可选：已安装 Xcode Command Line Tools（脚本会自动检测）

## 快速开始

1. 克隆仓库：

```bash
git clone <repo-url>
cd macenv-ini
```

2. 给脚本添加执行权限（如果需要）：

```bash
chmod +x install.sh
```

3. 运行安装脚本：

```bash
./install.sh
```

4. 重新打开终端或运行以下命令使配置生效：

```bash
source ~/.zshrc
```

## 手动配置步骤

### 导入 iTerm2 主题

脚本已下载 Snazzy 主题到 `~/Snazzy.itermcolors`，需要手动导入：

1. 打开 iTerm2
2. 进入 **Preferences** → **Profiles** → **Colors** → **Color Presets...** → **Import...**
3. 选择 `~/Snazzy.itermcolors`
4. 点击 **Color Presets...** → **Snazzy** 应用主题

## 安装后验证

运行以下命令验证各组件是否安装成功：

```bash
# Homebrew
brew --version

# Node.js
node --version
npm --version
nvm --version

# Python
python3 --version
pipx --version
pyenv --version

# 常用工具
fzf --version
rg --version
fd --version
bat --version
eza --version
```

## 脚本特性

- **幂等性** - 可以安全地多次运行脚本，已安装的组件会自动跳过
- **自动配置** - 自动更新 `.zshrc` 配置文件
- **安全检查** - 使用 `command -v` 和文件存在性检查避免重复安装

## 自定义配置

### 切换 npm 镜像

默认使用淘宝镜像，如需切换回官方源：

```bash
npm config set registry https://registry.npmjs.org
```

### 安装其他 Node.js 版本

```bash
nvm install 18
nvm use 18
nvm alias default 18
```

### 安装其他 Python 版本

```bash
pyenv install 3.11.0
pyenv global 3.11.0
```

### 使用 pipx 安装 Python 工具

```bash
pipx install black
pipx install poetry
```

## 目录结构

```
.
├── install.sh      # 主安装脚本
├── README.md       # 项目文档
└── CLAUDE.md       # Claude Code 工作指南
```

## 常见问题

### Q: 脚本运行需要多长时间？
A: 取决于网络速度，通常需要 5-15 分钟。

### Q: 能否只安装部分组件？
A: 目前脚本会安装所有组件。如需定制，建议编辑 `install.sh` 脚本，注释掉不需要的部分。

### Q: 如何卸载已安装的工具？
A: 各工具卸载方式不同：
- Homebrew 包：`brew uninstall <package>`
- nvm：删除 `~/.nvm` 目录
- oh-my-zsh：`uninstall_oh_my_zsh`

### Q: 遇到权限问题怎么办？
A: 脚本会在需要时自动请求管理员密码。如果 Homebrew 安装失败，可能需要手动安装 Xcode Command Line Tools：

```bash
xcode-select --install
```

## 许可证

MIT License
