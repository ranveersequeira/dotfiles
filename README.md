# Dotfiles

Personal macOS development environment managed with
[chezmoi](https://www.chezmoi.io/). This repository is the source state for the
files that should be reproducible across machines.

Git identity and global Git configuration are intentionally not managed here.
Keep those values machine-local or add them through a private/secrets flow.

## What is managed

| Source file | Target | Why it is here | Docs |
| --- | --- | --- | --- |
| `dot_zshrc` | `~/.zshrc` | Shell startup, PATH setup, plugin loading, completions, aliases, editor defaults, and local tool integrations. | [Zsh](https://zsh.sourceforge.io/Doc/) |
| `dot_tmux.conf` | `~/.tmux.conf` | tmux prefix, vi-style copy mode, pane/window bindings, status line, and TPM plugins. | [tmux](https://man7.org/linux/man-pages/man1/tmux.1.html), [TPM](https://github.com/tmux-plugins/tpm) |
| `dot_wezterm.lua` | `~/.wezterm.lua` | WezTerm terminal theme, font, tmux auto-session startup, tab/pane bindings, and link handling. | [WezTerm](https://wezfurlong.org/wezterm/config/files.html) |
| `dot_config/ghostty/config` | `~/.config/ghostty/config` | Ghostty terminal font, Gruvbox theme, macOS window behavior, keybinds, and terminal env. | [Ghostty](https://ghostty.org/docs/config) |
| `dot_config/nvim/` | `~/.config/nvim/` | Neovim setup based on LazyVim, including plugin lockfiles and editor configuration. | [Neovim](https://neovim.io/doc/), [LazyVim](https://www.lazyvim.org/) |
| `dot_config/opencode/opencode.jsonc` | `~/.config/opencode/opencode.jsonc` | OpenCode provider/model configuration, currently restricted to NVIDIA through `NVIDIA_API_KEY`. | [OpenCode config](https://opencode.ai/docs/config/), [OpenCode providers](https://opencode.ai/docs/providers/) |
| `dot_aerospace.toml` | `~/.aerospace.toml` | AeroSpace tiling window manager layout, workspace, monitor, and movement bindings. | [AeroSpace](https://nikitabobko.github.io/AeroSpace/guide) |
| `dot_config/tmux/scripts/` | `~/.config/tmux/scripts/` | Small tmux helper scripts, including calendar/status integration. | [tmux status line](https://man7.org/linux/man-pages/man1/tmux.1.html#STATUS_LINE) |
| `.chezmoi.toml.tmpl` | chezmoi config template | Keeps chezmoi pointed at this source directory. | [chezmoi config](https://www.chezmoi.io/reference/configuration-file/) |
| `.chezmoiignore` | chezmoi ignore rules | Keeps repo-only files like this README and local hooks out of the applied home state. | [chezmoi ignore](https://www.chezmoi.io/reference/special-files/chezmoiignore/) |
| `.githooks/` | repo hooks | Applies the source state after commits, merges, and checkouts in this repo. | [Git hooks](https://git-scm.com/docs/githooks) |

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

## Common commands

```sh
chezmoi status
chezmoi diff
chezmoi apply
chezmoi edit --apply ~/.tmux.conf
chezmoi re-add ~/.tmux.conf
```

The local Git hooks in `.githooks/` run `chezmoi apply --source "$HOME/dotfiles"`
after commits, merges, and checkouts in this repo.

## Notes

Keep machine-local tokens and private values out of managed files. The shell
loads optional secrets from `~/.config/secrets/env`, which should not be tracked
in this repository.
