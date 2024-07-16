# This expects the following to be installed:
# - tmux
# - tmuxinator
# - fzf
# - eza
#
# First install oh-my-zsh and required plugins:
# sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
# >>>> https://github.com/ajeetdsouza/zoxide <<<<
# git clone https://github.com/Aloxaf/fzf-tab ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/fzf-tab
# git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
# git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
# git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

#export SHELL=zsh
export EDITOR=nvim
export GOPATH=~/go
export PATH=/opt/homebrew/bin:$PATH:/usr/local/go/bin:~/bin:~/.local/bin:$GOPATH/bin:/opt/nvim/bin
export TAMAGO=/home/mhutchinson/Download/tamago1.21.5/bin/go

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
# ZSH_THEME="jonathan"
ZSH_THEME="powerlevel10k/powerlevel10k"

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
	git
	golang
	fzf
	tmuxinator
	zsh-autosuggestions
	zsh-syntax-highlighting
	fzf-tab
)

source $ZSH/oh-my-zsh.sh

autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /usr/bin/terraform terraform

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/home/mhutchinson/Download/google-cloud-sdk/path.zsh.inc' ]; then . '/home/mhutchinson/Download/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/home/mhutchinson/Download/google-cloud-sdk/completion.zsh.inc' ]; then . '/home/mhutchinson/Download/google-cloud-sdk/completion.zsh.inc'; fi

setopt noincappendhistory
setopt nosharehistory
setopt appendhistory

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

fixssh() {
  eval $(tmux show-env -s |grep '^SSH_')
}

eval "$(zoxide init zsh --cmd cd)"

# disable sort when completing `git checkout`
zstyle ':completion:*:git-checkout:*' sort false
# set descriptions format to enable group support
# NOTE: don't use escape sequences here, fzf-tab will ignore them
zstyle ':completion:*:descriptions' format '[%d]'
# set list-colors to enable filename colorizing
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
# force zsh not to show completion menu, which allows fzf-tab to capture the unambiguous prefix
zstyle ':completion:*' menu no
# preview directory's content with eza when completing cd
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 --color=always $realpath'
# switch group using `<` and `>`
zstyle ':fzf-tab:*' switch-group '<' '>'

ZSH_HIGHLIGHT_STYLES[globbing]='fg=#00BFFF'
ZSH_HIGHLIGHT_STYLES[history-expansion]='fg=#00BFFF'

zstyle ':fzf-tab:*' fzf-command ftb-tmux-popup

enable-fzf-tab

# Copy this to ~/.oh-my-zsh/custom/traps.zsh
# function __trap_exit_tmux {
# 	test $(tmux list-windows | wc -l) = 1 || exit
# 	test $(tmux list-panes | wc -l) = 1 || exit
# 	tmux switch-client -t 0
# }
#
# [[ -o interactive ]] && trap __trap_exit_tmux EXIT

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
alias config='git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
