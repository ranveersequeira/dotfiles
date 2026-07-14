# Dotfiles

Personal macOS development environment managed with
[chezmoi](https://www.chezmoi.io/). This repository is the source state for the
files that should be reproducible across machines.

Git identity and global Git configuration are intentionally not managed here.
Keep those values machine-local or add them through a private/secrets flow.

## One-command setup

On a new macOS machine, run:

```sh
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/ranveersequeira/dotfiles/main/scripts/bootstrap.sh)"
```

The bootstrap script installs Homebrew if needed, clones or updates this repo at
`~/dotfiles`, installs the packages in `Brewfile`, installs Zap/Bun/TPM support
referenced by the shell and tmux config, initializes chezmoi, applies the
dotfiles, enables this repo's Git hooks, and attempts a first Neovim plugin
sync.

If the repo should live somewhere else, override the location:

```sh
DOTFILES_DIR="$HOME/src/dotfiles" /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/ranveersequeira/dotfiles/main/scripts/bootstrap.sh)"
```

## What is managed

| Source file | Target | Why it is here | Docs |
| --- | --- | --- | --- |
| `dot_zshrc` | `~/.zshrc` | Shell startup, PATH setup, plugin loading, completions, aliases, editor defaults, and local tool integrations. | [Zsh](https://zsh.sourceforge.io/Doc/) |
| `dot_tmux.conf` | `~/.tmux.conf` | tmux prefix, vi-style copy mode, pane/window bindings, status line, and TPM plugins. | [tmux](https://man7.org/linux/man-pages/man1/tmux.1.html), [TPM](https://github.com/tmux-plugins/tpm) |
| `dot_wezterm.lua` | `~/.wezterm.lua` | WezTerm terminal theme, font, tmux auto-session startup, tab/pane bindings, and link handling. | [WezTerm](https://wezfurlong.org/wezterm/config/files.html) |
| `dot_config/ghostty/config` | `~/.config/ghostty/config` | Ghostty terminal font, Gruvbox theme, macOS window behavior, keybinds, and terminal env. | [Ghostty](https://ghostty.org/docs/config) |
| `dot_config/nvim/` | `~/.config/nvim/` | Neovim setup based on LazyVim, including plugin lockfiles and editor configuration. | [Neovim](https://neovim.io/doc/), [LazyVim](https://www.lazyvim.org/) |
| `dot_config/opencode/opencode.jsonc` | `~/.config/opencode/opencode.jsonc` | OpenCode provider/model configuration, currently restricted to NVIDIA through `NVIDIA_API_KEY`. | [OpenCode config](https://opencode.ai/docs/config/), [OpenCode providers](https://opencode.ai/docs/providers/) |
| `dot_config/television/config.toml` | `~/.config/television/config.toml` | Television UI, Gruvbox theme, keybindings, history, and shell channel preferences. | [Television configuration](https://alexpasmantier.github.io/television/user-guide/configuration/) |
| `dot_aerospace.toml` | `~/.aerospace.toml` | AeroSpace tiling window manager layout, workspace, monitor, and movement bindings. | [AeroSpace](https://nikitabobko.github.io/AeroSpace/guide) |
| `dot_config/tmux/scripts/` | `~/.config/tmux/scripts/` | Small tmux helper scripts, including calendar/status integration. | [tmux status line](https://man7.org/linux/man-pages/man1/tmux.1.html#STATUS_LINE) |
| `.chezmoi.toml.tmpl` | chezmoi config template | Keeps chezmoi pointed at this source directory. | [chezmoi config](https://www.chezmoi.io/reference/configuration-file/) |
| `.chezmoiignore` | chezmoi ignore rules | Keeps repo-only files like this README and local hooks out of the applied home state. | [chezmoi ignore](https://www.chezmoi.io/reference/special-files/chezmoiignore/) |
| `.githooks/` | repo hooks | Applies the source state after commits, merges, and checkouts in this repo. | [Git hooks](https://git-scm.com/docs/githooks) |
| `Brewfile` | Homebrew bundle | Recreates the installed CLI/app/font package set with `brew bundle`. | [Homebrew Bundle](https://docs.brew.sh/Brew-Bundle-and-Brewfile) |
| `scripts/bootstrap.sh` | setup entry point | Automates Homebrew, package install, chezmoi init/apply, and first-run plugin setup. | [Homebrew install](https://brew.sh/), [chezmoi init](https://www.chezmoi.io/reference/commands/init/) |

## Homebrew packages

`Brewfile` is the installable package snapshot. Reinstall everything from it
with:

```sh
brew bundle --file "$HOME/dotfiles/Brewfile"
```

Current directly installed formulae captured from this machine:

```text
anomalyco/tap/opencode
azure-cli
bat
block-goose-cli
carapace
chezmoi
cloudflared
cmake
colima
direnv
docker
docker-compose
eza
fastfetch
fd
ffmpeg-full
figlet
fnm
fzf
gcc
gemini-cli
gh
git-delta
glab
glow
go
graphviz
grep
httpie
ical-buddy
imagemagick-full
jaq
jless
jmeter
jq
lazygit
llmfit
llvm
md5sha1sum
modem-dev/tap/hunk
neovim
pastel
pipx
pnpm
poppler
python@3.14
resvg
ripgrep
rtk
rust
sesh
sevenzip
superfile
television
tldr
tmux
tree
vite
xh
yarn
yazi
zoxide
```

Current casks captured from this machine:

```text
aerospace
android-platform-tools
bitwarden
boring-notch
bruno
caffeine
charles@4
codex
codexbar
connectiq-sdk-manager
font-fira-code-nerd-font
font-jetbrains-mono-nerd-font
font-symbols-only-nerd-font
gcloud-cli
ghostty
iina
orbstack
prisma-studio
visual-studio-code
wezterm
```

The Brewfile also records Go, Cargo, and npm global tools that Homebrew Bundle
detected: `cclogviewer`, `zoekt-index`, `ast-grep`, `tree-sitter-cli`,
`@openai/codex`, `@rama_nigg/open-cursor`, `ai-agent-workflow`, and `corepack`.

## Tooling choices

- [chezmoi](https://www.chezmoi.io/) keeps dotfiles declarative and makes it
  easy to diff, apply, and re-add files from `$HOME`.
- [Zap](https://www.zapzsh.com/) loads Zsh plugins without making `.zshrc`
  depend on a large framework.
- [Carapace](https://carapace.sh/) provides cross-shell command completions.
- [fnm](https://github.com/Schniz/fnm), [pnpm](https://pnpm.io/), and
  [Bun](https://bun.sh/docs) cover JavaScript runtime/package workflows.
- [zoxide](https://github.com/ajeetdsouza/zoxide) improves directory jumping.
- [Television](https://github.com/alexpasmantier/television) provides terminal
  fuzzy finding, path completion, and shell history search.
- [eza](https://eza.rocks/) and [bat](https://github.com/sharkdp/bat) replace
  common listing and file preview commands with richer defaults.
- [AeroSpace](https://nikitabobko.github.io/AeroSpace/guide) gives macOS an
  i3-like tiling workflow.
- [OpenCode](https://opencode.ai/docs/) keeps CLI agent provider and model
  defaults in versioned config while loading the API key from the environment.
- [Homebrew Bundle](https://docs.brew.sh/Brew-Bundle-and-Brewfile) turns the
  installed package set into a repeatable `Brewfile`.

## Common commands

```sh
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/ranveersequeira/dotfiles/main/scripts/bootstrap.sh)"
brew bundle --file "$HOME/dotfiles/Brewfile"
chezmoi status
chezmoi diff
chezmoi apply
chezmoi edit --apply ~/.tmux.conf
chezmoi re-add ~/.tmux.conf
brew bundle dump --file Brewfile --force
```

The local Git hooks in `.githooks/` run `chezmoi apply --source "$HOME/dotfiles"`
after commits, merges, and checkouts in this repo.

## Notes

Keep machine-local tokens and private values out of managed files. The shell
loads optional secrets from `~/.config/secrets/env`, which should not be tracked
in this repository.
