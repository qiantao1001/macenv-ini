# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a macOS environment initialization repository that automates the setup of a new macOS development machine. It installs Homebrew, configures zsh with oh-my-zsh, sets up useful plugins, and configures iTerm2 theming.

## Repository Structure

- `install.sh` - Main installation script that sets up the entire environment
- `README.md` - Project documentation (in Chinese)

## What the Install Script Does

The `install.sh` script performs the following actions:

1. **Homebrew Installation** - Installs Homebrew package manager if not present
2. **oh-my-zsh Setup** - Installs oh-my-zsh framework (with RUNZSH=no and CHSH=no to avoid interactive prompts)
3. **Zsh Plugins** - Installs two useful plugins:
   - `zsh-autosuggestions` - Fish-like suggestions as you type
   - `zsh-syntax-highlighting` - Syntax highlighting for shell commands
4. **Pure Prompt** - Installs the Pure ZSH prompt theme (minimal and fast)
5. **iTerm2 Theme** - Downloads the Snazzy color theme for iTerm2

## Key Implementation Details

- The script is idempotent - it checks if components are already installed before attempting installation
- Uses `command -v` to check for existing installations
- Uses directory/file existence checks before git clones
- Appends to `~/.zshrc` only if the configuration isn't already present (uses `grep -q` checks)
- Pure prompt is installed to `~/.zsh/pure` and configured via fpath
- Snazzy theme is downloaded to `~/Snazzy.itermcolors` (manual import into iTerm2 required)

## Common Tasks

### Run the installation script

```bash
./install.sh
```

### Make the script executable (if needed)

```bash
chmod +x install.sh
```

### Test script changes

Since this script modifies the local environment (Homebrew, shell configuration), test changes carefully:
1. Review the script logic first
2. Consider testing individual sections in isolation
3. The script is safe to run multiple times due to idempotency checks

## Notes

- The script modifies `~/.zshrc` directly by appending configuration lines
- The Snazzy theme requires manual import into iTerm2 after download
- The script assumes macOS (Darwin) and uses `/opt/homebrew/bin/brew` paths
- All git clones use HTTPS URLs from GitHub
