# Dotfiles

Managed with [chezmoi](https://www.chezmoi.io/), using this repository as the source state.

## Common commands

```sh
chezmoi status
chezmoi diff
chezmoi apply
chezmoi edit --apply ~/.tmux.conf
chezmoi re-add ~/.tmux.conf
```

The local Git hooks in `.githooks/` apply source changes automatically after commits, merges, and checkouts in this repo.

## Notes

`.zshrc` is managed. Keep machine-local tokens and private values out of it unless they are moved into an encrypted chezmoi/secrets flow.
