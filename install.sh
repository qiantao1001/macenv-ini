#!/bin/bash

# 安装 Homebrew 的脚本

# 检查是否已安装 brew
if command -v brew >/dev/null 2>&1; then
    echo "Homebrew 已安装。"
    exit 0
fi

# 安装 Homebrew
echo "正在安装 Homebrew..."
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# 更新环境变量
if [[ "$(uname)" == "Darwin" ]]; then
    echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi

echo "Homebrew 安装完成。"

# 安装 oh-my-zsh
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    echo "正在安装 oh-my-zsh..."
    RUNZSH=no CHSH=no sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    echo "oh-my-zsh 安装完成。"
else
    echo "oh-my-zsh 已安装。"
fi

# 安装 zsh-autosuggestions 插件
if [ ! -d "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions" ]; then
    echo "正在安装 zsh-autosuggestions 插件..."
    git clone https://github.com/zsh-users/zsh-autosuggestions "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions"
    echo "zsh-autosuggestions 插件安装完成。"
else
    echo "zsh-autosuggestions 插件已安装。"
fi

# 安装 zsh-syntax-highlighting 插件
if [ ! -d "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting" ]; then
    echo "正在安装 zsh-syntax-highlighting 插件..."
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting"     
    echo "zsh-syntax-highlighting 插件安装完成。"
else
    echo "zsh-syntax-highlighting 插件已安装。"
fi

# 安装 pure (Pretty, minimal and fast ZSH prompt)
if [ ! -d "$HOME/.zsh/pure" ]; then
    echo "正在安装 pure ZSH prompt..."
    mkdir -p "$HOME/.zsh"
    git clone https://github.com/sindresorhus/pure.git "$HOME/.zsh/pure"
    echo "pure ZSH prompt 安装完成。"
else
    echo "pure ZSH prompt 已安装。"
fi

# 添加 pure 到 .zshrc
if ! grep -q 'fpath+=("$HOME/.zsh/pure")' "$HOME/.zshrc"; then
    echo 'fpath+=("$HOME/.zsh/pure")' >> "$HOME/.zshrc"
    echo 'autoload -U promptinit; promptinit' >> "$HOME/.zshrc"
    echo 'prompt pure' >> "$HOME/.zshrc"
    echo ".zshrc 已更新以启用 pure。"
fi

# 安装 iTerm2 的 Snazzy 主题
SNZZ_THEME_URL="https://raw.githubusercontent.com/sindresorhus/iterm2-snazzy/master/Snazzy.itermcolors"
SNZZ_THEME_PATH="$HOME/Snazzy.itermcolors"

if [ ! -f "$SNZZ_THEME_PATH" ]; then
    echo "正在下载 Snazzy 主题..."
    curl -fsSL "$SNZZ_THEME_URL" -o "$SNZZ_THEME_PATH"
    echo "Snazzy 主题已下载到 $SNZZ_THEME_PATH"
else
    echo "Snazzy 主题已存在。"
fi

echo "请手动在 iTerm2 中导入 Snazzy 主题：$SNZZ_THEME_PATH"

# 安装 nvm (Node Version Manager)
if [ ! -d "$HOME/.nvm" ]; then
    echo "正在安装 nvm..."
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
    echo "nvm 安装完成。"
else
    echo "nvm 已安装。"
fi

# 将 nvm 配置添加到 .zshrc
if ! grep -q 'export NVM_DIR="$HOME/.nvm"' "$HOME/.zshrc"; then
    echo 'export NVM_DIR="$HOME/.nvm"' >> "$HOME/.zshrc"
    echo '[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm' >> "$HOME/.zshrc"
    echo "nvm 配置已添加到 .zshrc。"
fi

# 安装 Node.js LTS 版本
if ! command -v node >/dev/null 2>&1; then
    echo "正在安装 Node.js LTS 版本..."
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
    nvm install --lts
    nvm use --lts
    nvm alias default 'lts/*'
    echo "Node.js LTS 版本安装完成。"
else
    echo "Node.js 已安装，版本：$(node --version)"
fi

# 设置 npm 国内镜像（可选，加速下载）
if command -v npm >/dev/null 2>&1; then
    echo "正在设置 npm 使用淘宝镜像..."
    npm config set registry https://registry.npmmirror.com
    echo "npm 镜像设置完成。"
fi

# 安装 Python 和 pip (使用 Homebrew)
if ! command -v python3 >/dev/null 2>&1; then
    echo "正在安装 Python 3..."
    brew install python
    echo "Python 3 安装完成。"
else
    echo "Python 3 已安装，版本：$(python3 --version)"
fi

# 安装 pipx (Python 包管理工具)
if ! command -v pipx >/dev/null 2>&1; then
    echo "正在安装 pipx..."
    brew install pipx
    pipx ensurepath
    echo "pipx 安装完成。"
else
    echo "pipx 已安装。"
fi

# 安装 pyenv (Python 版本管理工具)
if ! command -v pyenv >/dev/null 2>&1; then
    echo "正在安装 pyenv..."
    brew install pyenv
    echo "pyenv 安装完成。"
else
    echo "pyenv 已安装。"
fi

# 将 pyenv 配置添加到 .zshrc
if ! grep -q 'eval "$(pyenv init -)"' "$HOME/.zshrc"; then
    echo '# pyenv configuration' >> "$HOME/.zshrc"
    echo 'export PYENV_ROOT="$HOME/.pyenv"' >> "$HOME/.zshrc"
    echo '[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"' >> "$HOME/.zshrc"
    echo 'eval "$(pyenv init -)"' >> "$HOME/.zshrc"
    echo "pyenv 配置已添加到 .zshrc。"
fi

# 安装常用开发工具
echo "正在安装常用开发工具..."

# Git 配置提示
if ! command -v git >/dev/null 2>&1; then
    brew install git
fi

# 安装常用工具
brew install --quiet \
    wget \
    curl \
    tree \
    fzf \
    ripgrep \
    fd \
    bat \
    eza \
    tlrc \
    git-delta \
    jq \
    yq \
    htop \
    ncdu \
    tldr \
    2>/dev/null || true

echo "常用开发工具安装完成。"

# 配置 fzf (模糊查找)
if [ -f "$(brew --prefix)/opt/fzf/install" ]; then
    "$(brew --prefix)/opt/fzf/install" --all --no-bash --no-fish 2>/dev/null || true
fi

# 将常用别名添加到 .zshrc
if ! grep -q '# Custom aliases' "$HOME/.zshrc"; then
    echo "" >> "$HOME/.zshrc"
    echo '# Custom aliases' >> "$HOME/.zshrc"
    echo 'alias ls="eza --icons"' >> "$HOME/.zshrc"
    echo 'alias ll="eza -l --icons"' >> "$HOME/.zshrc"
    echo 'alias la="eza -la --icons"' >> "$HOME/.zshrc"
    echo 'alias cat="bat"' >> "$HOME/.zshrc"
    echo 'alias htop="btm"' >> "$HOME/.zshrc"
    echo 'alias du="ncdu"' >> "$HOME/.zshrc"
    echo "常用别名已添加到 .zshrc。"
fi

echo "安装完成！请重新打开终端以应用更改。"