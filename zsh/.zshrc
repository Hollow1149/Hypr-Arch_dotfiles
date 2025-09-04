#############################
### Environment Variables ###
#############################

export FONTCONFIG_PATH=/etc/fonts
export PATH="$HOME/.local/bin:$PATH"
export QT_QPA_PLATFORMTHEME=qt6ct
export PGHOST=~/Applications/PostgreSQL_db/

#####################
### Shell Options ###
#####################

### History related options ###
HISTFILE=~/.histfile
HISTSIZE=5000
SAVEHIST=$HISTSIZE
HISTDUP=erase

setopt appendhistory sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

### zsh behaviour ###

setopt extendedglob notify
unsetopt autocd beep nomatch

### Keybinds ###
bindkey -e
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward


####################################
### Zinit Plugin Manager Options ###
####################################

### Directory for Zinit (plugin manager) and plugins ###
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

### Download Zinit if its not present ###

### make Zinit Directory ###
if [ ! -d "$ZINIT_HOME" ]; then
  mkdir -p "$(dirname $ZINIT_HOME)"
fi

### get Zinit from its git repo ###
if [ ! -d "$ZINIT_HOME/.git" ]; then
  git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

### Load/Source Zinit ###
source "${ZINIT_HOME}/zinit.zsh"


####################
### Load Plugins ###
####################

### Snippets ###
zinit snippet OMZP::command-not-found

### Zinit Plugins ###
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab


########################
### Completion Setup ###
########################

### Load Completions ###
autoload -Uz compinit && compinit

### Completion styling ###
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'lsd -A --icon always $realpath' 


##########################
### Shell Integrations ###
##########################

eval "$(fzf --zsh)" # Using Ctrl+r #

zinit cdreplay -q


############################
### oh-my-posh execution ###
############################

if [ "$TERM_PROGRAM" != "Apple_Terminal" ]; then
  eval "$(oh-my-posh init zsh --config ~/.cache/oh-my-posh/themes/catppuccin_mocha.omp.json)"
fi

##########################
### Yazi shell wrapper ###
##########################
function yazi() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	command yazi "$@" --cwd-file="$tmp"
	IFS= read -r -d '' cwd < "$tmp"
	[ -n "$cwd" ] && [ "$cwd" != "$PWD" ] && builtin cd -- "$cwd"
	rm -f -- "$tmp"
}

###############
### Aliases ###
###############
alias ppd-start="sudo systemctl unmask power-profiles-daemon.service && sudo systemctl stop auto-cpufreq && sudo  systemctl enable --now power-profiles-daemon.service"
alias ppd-stop="sudo systemctl disable --now power-profiles-daemon.service"
alias auto-start="sudo systemctl stop power-profiles-daemon.service && sudo systemctl enable --now auto-cpufreq"
alias auto-stop="sudo systemctl disable --now auto-cpufreq"
alias pgctl_start="pg_ctl -D /home/Artemis/Applications/PostgreSQL_db/ -l /home/Artemis/Applications/PostgreSQL_db/logfile start"
alias pgctl_stop="pg_ctl -D /home/Artemis/Applications/PostgreSQL_db/ stop"
alias lsda="lsd -A"

export NVM_DIR="$HOME/.config/nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

################################
### Run Pokemon-colorscripts ###
################################
pokemon-colorscripts -r --no-title
