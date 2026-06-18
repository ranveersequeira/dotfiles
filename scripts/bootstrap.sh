#!/usr/bin/env bash
set -euo pipefail

repo_url="${DOTFILES_REPO_URL:-https://github.com/ranveersequeira/dotfiles.git}"
repo_dir="${DOTFILES_DIR:-$HOME/dotfiles}"
brewfile="$repo_dir/Brewfile"

log() {
  printf '\n==> %s\n' "$*"
}

warn() {
  printf 'warning: %s\n' "$*" >&2
}

if [[ "$(uname -s)" != "Darwin" ]]; then
  printf 'This bootstrap is for macOS only.\n' >&2
  exit 1
fi

if ! command -v brew >/dev/null 2>&1; then
  log "Installing Homebrew"
  NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

if [[ -x /opt/homebrew/bin/brew ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
elif [[ -x /usr/local/bin/brew ]]; then
  eval "$(/usr/local/bin/brew shellenv)"
fi

if ! command -v git >/dev/null 2>&1; then
  log "Installing Git"
  brew install git
fi

if [[ -d "$repo_dir/.git" ]]; then
  log "Updating dotfiles repo"
  git -C "$repo_dir" pull --ff-only
elif [[ -e "$repo_dir" ]]; then
  printf '%s exists but is not a Git checkout. Move it away or set DOTFILES_DIR.\n' "$repo_dir" >&2
  exit 1
else
  log "Cloning dotfiles repo"
  git clone "$repo_url" "$repo_dir"
fi

log "Installing Homebrew packages"
brew update
brew bundle --file "$brewfile"

if ! command -v chezmoi >/dev/null 2>&1; then
  log "Installing chezmoi"
  brew install chezmoi
fi

log "Installing Zap for Zsh plugins"
zap_dir="${XDG_DATA_HOME:-$HOME/.local/share}/zap"
if [[ -d "$zap_dir/.git" ]]; then
  git -C "$zap_dir" pull --ff-only || warn "Could not update Zap"
elif [[ ! -e "$zap_dir" ]]; then
  git clone --depth 1 https://github.com/zap-zsh/zap.git "$zap_dir"
else
  warn "$zap_dir exists but is not a Git checkout; leaving it untouched"
fi

if ! command -v bun >/dev/null 2>&1; then
  log "Installing Bun"
  curl -fsSL https://bun.sh/install | bash
fi

log "Installing tmux plugin manager"
tpm_dir="$HOME/.tmux/plugins/tpm"
if [[ -d "$tpm_dir/.git" ]]; then
  git -C "$tpm_dir" pull --ff-only || warn "Could not update TPM"
elif [[ ! -e "$tpm_dir" ]]; then
  git clone https://github.com/tmux-plugins/tpm "$tpm_dir"
else
  warn "$tpm_dir exists but is not a Git checkout; leaving it untouched"
fi

log "Applying chezmoi dotfiles"
chezmoi init --source "$repo_dir"
chezmoi apply --source "$repo_dir"
git -C "$repo_dir" config core.hooksPath .githooks

if [[ -x "$tpm_dir/bin/install_plugins" ]] && command -v tmux >/dev/null 2>&1; then
  log "Installing tmux plugins"
  "$tpm_dir/bin/install_plugins" || warn "tmux plugin install failed; open tmux and press prefix + I"
fi

if command -v nvim >/dev/null 2>&1; then
  log "Syncing Neovim plugins"
  nvim --headless "+Lazy! sync" +qa || warn "Neovim plugin sync failed; run nvim and let Lazy retry"
fi

log "Done"
