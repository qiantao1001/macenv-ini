# macenv-ini

一个用于 macOS 环境初始化的脚本工程模板，用于安装常用命令行工具并统一配置用户 shell / editor / dotfiles 等。

> 这是一个模板 README；后续请在对应位置补充项目具体细节（脚本名、工具清单等）。

## 目录（示例）

- `install.sh`：主安装脚本（示例）
- `Brewfile` / `packages.txt`：列出要安装的 Homebrew 包或工具
- `dotfiles/`：个性化配置（`.zshrc`, `.gitconfig` 等）
- `README.md`：本文件

## 项目简介

简短说明本项目的目的：自动化在一台全新的 macOS 机器上安装常用开发工具与配置个人化环境，节省重复配置时间。

## 先决条件

- macOS 版本：请注明最低支持的 macOS 版本（示例：macOS 12+）
- 已安装 Xcode Command Line Tools（或说明脚本会自动安装）
- 有 Homebrew（脚本可选安装）

## 快速开始

1. 克隆仓库：

```
git clone <repo-url>
cd macenv-ini
```

2. 预览脚本并执行（强烈建议先阅读脚本内容）：

```
./install.sh   # 或者 ./setup.sh，根据项目实际脚本名替换
```

3. 可能的交互步骤：
- 输入管理员密码以安装必要工具
- 选择是否安装可选软件包或配置

## 可配置项（占位）

- `BREW_PACKAGES`：Homebrew 包列表
- `CASK_APPS`：通过 `brew install --cask` 安装的应用
- `GEM_PACKAGES` / `NPM_PACKAGES`：语言生态的全局包

在此说明如何编辑这些列表，以及脚本如何读取这些文件（例如 `Brewfile`、`packages.txt`）。

## 常见命令示例

- 更新脚本（示例）

```
git pull origin main
./install.sh --update
```

- 仅安装 Homebrew 列表：

```
./install.sh --brew-only
```

（根据实际脚本支持的参数补充）

## 自定义与扩展

- 如何添加新的安装项到 `Brewfile` 或 `packages.txt`
- 如何在 `dotfiles/` 中添加或修改配置文件
- 如何将个人私有配置与仓库分离（示例：使用 `.env.local` 或 `local/` 目录）

## 调试与常见问题

- 权限问题：如何在脚本中以安全方式请求 `sudo` 权限
- 已安装冲突：如何跳过已存在的包或强制覆盖

## 贡献指南

欢迎贡献：请先 fork 仓库并创建 PR。建议在 PR 描述中说明变更目的，并在可能时添加可复现的测试步骤。

## 许可证 & 作者

- 许可证：在此处填写许可证类型（例如 MIT）
- 作者：在此处填写作者/维护者信息

## 待填项（请补充）

- 实际脚本名称（`install.sh` / `setup.sh` / 其它）
- 要安装的具体包列表（`Brewfile`、`cask`、`npm` 等）
- 支持的 macOS 最低版本
- 任何自定义步骤或必须的外部凭证说明

---

如需我可以：
- 将上述模板保存到仓库（已完成）
- 根据你的项目实际脚本，替换占位命令并完善示例命令
- 添加一个示例 `Brewfile` 或 `install.sh` 可运行样例

请告诉我你想先补充哪些具体信息。谢谢！
