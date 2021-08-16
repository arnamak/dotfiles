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
alias gpurge="git branch | grep -v '^* main' | grep -v 'main' | xargs git branch -D"
#-------------------------------------------------------------UTILS--------------------------------------------------------------#
eval "$(zoxide init zsh)"
alias ls="exa --icons"
alias lst="exa -TL 2 --group-directories-first --icons"
alias man="batman"
alias rg="batgrep"
alias cd="z"
alias cat="bat"
#------------------------------------------------------------DOTFILE--------------------------------------------------------------#
alias nvimz="nvim $HOME/.zshrc"
alias sz="source $HOME/.zshrc"
alias nvimrc="nvim $HOME.config/nvim/init.vim"
##################################################################################################################################
#------------------------------------------------------------PLUGINS-------------------------------------------------------------#
##################################################################################################################################
#------------------------------------------------------------SOURCES-------------------------------------------------------------#
source "$HOME/.zinit/bin/zinit.zsh"

export HISTSIZE=100000
export SAVEHIST=100000
export HISTFILE="$HOME/.zsh_history"
setopt EXTENDED_HISTORY
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_FIND_NO_DUPS
setopt HIST_SAVE_NO_DUPS
setopt    appendhistory     #Append history to the history file (no overwriting)
setopt    sharehistory      #Share history across terminals
setopt    incappendhistory  #Immediately append to the history file, not just when a term is killed
zinit lucid for \
    as"command" from"gh-r" atinit'export N_PREFIX="$HOME/n"; [[ :$PATH: == *":$N_PREFIX/bin:"* ]] || PATH+=":$N_PREFIX/bin"' atload'eval "$(starship init zsh)"' bpick'*unknown-linux-gnu*' \
    starship/starship \
# zinit ice compile'(pure|async).zsh' pick'async.zsh' src'pure.zsh'
# zinit light sindresorhus/pure
zinit snippet OMZP::'command-not-found' # requires pkgfile (yay -S pkgfile) and update (pkgfile -u)
zinit wait lucid for \
  atload"ZINIT[COMPINIT_OPTS]=-C; zicompinit;" \
  light-mode atinit"
      typeset -gA FAST_HIGHLIGHT;
      FAST_HIGHLIGHT[git-cmsg-len]=100;
      zpcompinit;
      zpcdreplay;
  " \
      zdharma/fast-syntax-highlighting \
  atinit"
    zstyle ':completion:*' completer _expand _complete _ignored _approximate
    zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
    zstyle ':completion:*' menu select=2
    zstyle ':completion:*' select-prompt '%SScrolling active: current selection at %p%s'
    zstyle ':completion:*:descriptions' format '-- %d --'
    zstyle ':completion:*:processes' command 'ps -au$USER'
    zstyle ':completion:complete:*:options' sort false
    zstyle ':fzf-tab:complete:_zlua:*' query-string input
    zstyle ':completion:*:*:*:*:processes' command 'ps -u $USER -o pid,user,comm,cmd -w -w'
    zstyle ':fzf-tab:complete:kill:argument-rest' extra-opts --preview=$extract'ps --pid=$in[(w)1] -o cmd --no-headers -w -w' --preview-window=down:3:wrap
    zstyle ':fzf-tab:complete:cd:*' extra-opts --preview=$extract'exa -1 --color=always ${~ctxt[hpre]}$in'
  " \
  atload"!_zsh_autosuggest_start" \
    zsh-users/zsh-autosuggestions \
  atload"!_zsh_autosuggest_start; bindkey '^n' autosuggest-accept" \
    zdharma/history-search-multi-word

#------------------------------------------------------------PROMPTS-------------------------------------------------------------#
# PURE_PROMPT_SYMBOL="λ >> "
# zstyle :prompt:pure:path color green
# zstyle ':prompt:pure:prompt:*' color white
##################################################################################################################################
#------------------------------------------------------------CONFIGS-------------------------------------------------------------#
##################################################################################################################################
#------------------------------------------------------------ULIMITS-------------------------------------------------------------#
ulimit -n 65536 65536
ulimit -f unlimited
#------------------------------------------------------------HISTORY-------------------------------------------------------------#

if [ -z "${DISPLAY}" ] && [ "${XDG_VTNR}" -eq 1 ]; then
  exec startx -- vt1 &> /dev/null
fi
eval $(fnm env)
bindkey -e
export KEYTIMEOUT=1
alias luamake=/home/arnamak/lua-language-server/3rd/luamake/luamake
