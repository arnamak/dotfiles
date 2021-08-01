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
export PATH="$PATH:$HOME/.local/bin"
export PATH="$PATH:/usr/local/bin"
export PATH="$PATH:/usr/bin"
export PATH="$PATH:/usr/local/sbin"
export PATH="$PATH:/usr/sbin"
export PATH="$PATH:/snap/bin"
export PATH="$PATH:/bin"
#--------------------------------------------------------------FZF---------------------------------------------------------------#
export FZF_DEFAULT_OPTS="--cycle --layout=reverse --border=rounded --marker='+'"
export FORGIT_FZF_DEFAULT_OPTS="
  --disabled --preview-window='up:60%' --bind=j:down,k:up --bind=space:preview-down,ctrl-space:preview-up
"
export EDITOR="nvim"
source $HOME/.current/.global.env
#------------------------------------------------------------PROJECT-------------------------------------------------------------#
source $HOME/.current/.env
#--------------------------------------------------------------EXA---------------------------------------------------------------#
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
alias ls="exa"
alias lst="exa -TL 2 --group-directories-first"
alias man="batman"
alias rg="batgrep"
alias cd="z"
alias cat="bat"
#------------------------------------------------------------DOTFILE--------------------------------------------------------------#
alias nvimz="vim $HOME/.zshrc"
alias sz="source $HOME/.zshrc"
alias nvimrc="vim $HOME.config/nvim/init.vim"
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
# =============================================================================
# Utility functions for zoxide.
# =============================================================================
# pwd based on the value of _ZO_RESOLVE_SYMLINKS.
function __zoxide_pwd() {
    \builtin pwd -L
}
# cd + custom logic based on the value of _ZO_ECHO.
function __zoxide_cd() {
    \builtin cd "$@"
}
# Hook to add new entries to the database.
function __zoxide_hook() {
    zoxide add -- "$(__zoxide_pwd)"
}
# Initialize hook.
if [ "${__zoxide_hooked}" != '1' ]; then
    __zoxide_hooked='1'
    chpwd_functions=("${chpwd_functions[@]}" "__zoxide_hook")
fi
# Jump to a directory using only keywords.
function __zoxide_z() {
    if [ "$#" -eq 0 ]; then
        __zoxide_cd ~
    elif [ "$#" -eq 1 ] && [ "$1" = '-' ]; then
        if [ -n "${OLDPWD}" ]; then
            __zoxide_cd "${OLDPWD}"
        else
            # shellcheck disable=SC2016
            \builtin printf 'zoxide: $OLDPWD is not set'
            return 1
        fi
    elif [ "$#" -eq 1 ] &&  [ -d "$1" ]; then
        __zoxide_cd "$1"
    else
        \builtin local __zoxide_result
        __zoxide_result="$(zoxide query --exclude "$(__zoxide_pwd)" -- "$@")" \
            && __zoxide_cd "${__zoxide_result}"
    fi
}
# Jump to a directory using interactive search.
function __zoxide_zi() {
    \builtin local __zoxide_result
    __zoxide_result="$(zoxide query -i -- "$@")" && __zoxide_cd "${__zoxide_result}"
}
# Remove definitions.
function __zoxide_unset() {
    \builtin unalias "$@" &>/dev/null
    \builtin unfunction "$@" &>/dev/null
    \builtin unset "$@" &>/dev/null
}
__zoxide_unset 'z'
function z() {
    __zoxide_z "$@"
}
__zoxide_unset 'zi'
function zi() {
    __zoxide_zi "$@"
}
# Initialize zoxide
eval "$(zoxide init zsh)"
eval "$(fnm env)"
