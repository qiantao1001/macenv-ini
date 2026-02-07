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

echo "安装完成！请重新打开终端以应用更改。"