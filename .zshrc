##################################################################################################################################
#----------------------------------------------------------DEPENDENCIES----------------------------------------------------------#
##################################################################################################################################
#
# Some functionality depends on these packages:
## fzf
## ripgrep
## bat
## bat-extra
## exa
#
##################################################################################################################################
#-----------------------------------------------------------VARIABLES------------------------------------------------------------#
##################################################################################################################################
#-------------------------------------------------------------PATHS--------------------------------------------------------------#
export PATH="$PATH:$HOME/.current"
export PATH="$PATH:$HOME/.local/bin"
export PATH="$PATH:$HOME/.pyenv/bin"
export PATH="$PATH:/usr/local/bin"
export PATH="$PATH:/usr/bin"
export PATH="$PATH:/usr/local/sbin"
export PATH="$PATH:/usr/sbin"
export PATH="$PATH:/bin"
#--------------------------------------------------------------FZF---------------------------------------------------------------#
export FZF_DEFAULT_OPTS="--cycle --layout=reverse --border=rounded --marker='+'"
export FORGIT_FZF_DEFAULT_OPTS="
  --disabled --preview-window='up:60%' --bind=j:down,k:up --bind=space:preview-down,ctrl-space:preview-up
"
#------------------------------------------------------------PROJECT-------------------------------------------------------------#
source $HOME/.current/.env
#--------------------------------------------------------------EXA---------------------------------------------------------------#
export _ZO_DATA_DIR="$HOME/.current/zoxide"
export _ZO_ECHO="0"
export _ZO_RESOLVE_SYMLINKS=1
export EXA_COLORS="uu=38;5;248"
export LS_COLORS="*.js=33:*.jsx=34:*.test.jsx=31;4:*.log=38;5;248:*.lock=38;5;248:*.json=38;5;004;1:di=38;5;048;1;4:ex=31;1"
##################################################################################################################################
#------------------------------------------------------------ALIASES-------------------------------------------------------------#
##################################################################################################################################
#--------------------------------------------------------------GIT---------------------------------------------------------------#
alias gad="git add ."
alias gc="git commit "
alias gco='git checkout '
alias gapn="git add --intent-to-add . && git add --patch"
alias gpurge="git branch | grep -v '^* master' | grep -v 'master' | xargs git branch -D"
#-------------------------------------------------------------UTILS--------------------------------------------------------------#
eval "$(zoxide init zsh)"
alias ls="exa --icons"
alias lst="exa -TL 2 --group-directories-first --icons"
alias man="batman"
alias rg="batgrep"
alias vim="/usr/bin/nvim"
alias cd="z"
alias cat="bat"
#------------------------------------------------------------SCRIPTS--------------------------------------------------------------#
alias infect="$SCRIPTS_DIR/infect.sh"
alias dev="$SCRIPTS_DIR/current/boot.sh"
alias devngrok="$SCRIPTS_DIR/current/boot_with_ngrok.sh"
#------------------------------------------------------------DOTFILE--------------------------------------------------------------#
alias vimz="vim $HOME/.zshrc"
alias sz="source $HOME/.zshrc"
alias vimrc="vim $HOME.config/nvim/init.vim"
##################################################################################################################################
#------------------------------------------------------------PLUGINS-------------------------------------------------------------#
##################################################################################################################################
#------------------------------------------------------------SOURCES-------------------------------------------------------------#
source "$HOME/.zinit/bin/zinit.zsh"

zinit ice compile'(pure|async).zsh' pick'async.zsh' src'pure.zsh'
zinit light sindresorhus/pure
zinit light zdharma/history-search-multi-word
zinit snippet OMZP::'command-not-found'
zinit wait lucid for \
  atload"ZINIT[COMPINIT_OPTS]=-C; zicompinit;" \
    zdharma/fast-syntax-highlighting \
  atinit wfxr/forgit \
  atload"!_zsh_autosuggest_start; bindkey '^n' autosuggest-accept" \
    zsh-users/zsh-autosuggestions \
#------------------------------------------------------------PROMPTS-------------------------------------------------------------#
PURE_PROMPT_SYMBOL="λ >> "
zstyle :prompt:pure:path color green
zstyle ':prompt:pure:prompt:*' color white
##################################################################################################################################
#------------------------------------------------------------CONFIGS-------------------------------------------------------------#
##################################################################################################################################
#------------------------------------------------------------ULIMITS-------------------------------------------------------------#
ulimit -n 65536 65536
ulimit -f unlimited
#------------------------------------------------------------HISTORY-------------------------------------------------------------#
export HISTSIZE=100000
export SAVEHIST=100000
export HISTFILE="$HOME/.zsh_history"
export PER_DIRECTORY_HISTORY_TOGGLE=^=

if [ -z "${DISPLAY}" ] && [ "${XDG_VTNR}" -eq 1 ]; then
  exec startx -- vt1 &> /dev/null
fi
eval $(fnm env)

alias luamake=/home/arnamak/lua-language-server/3rd/luamake/luamake
