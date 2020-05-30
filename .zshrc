PURE_PROMPT_SYMBOL="λ >> "
#################################################################################################################################
#                                                             PATH                                                              #
#################################################################################################################################
export PATH="$HOME/.zinit/polaris/bin"
export PATH="$PATH:$HOME/.local/bin"
export PATH="$HOME/.pyenv/bin:$PATH"
export PATH="$PATH:/usr/local/sbin"
export PATH="$PATH:/usr/local/bin"
export PATH="$PATH:/usr/sbin"
export PATH="$PATH:/snap/bin"
export PATH="$PATH:/usr/bin"
export PATH="$PATH:/bin"
#################################################################################################################################
#-----------------------------------------------------------ALIASES-------------------------------------------------------------#
############################################################--Git--##############################################################
alias gad="git add ."
alias gc="git commit "
alias gco='git checkout '
alias gcm='git checkout master'
alias gcd='git checkout develop'
alias gapn='git add --intent-to-add . && git add --patch'
alias purge="git branch | grep -v '^* master' | grep -v 'develop' | grep -v 'master' | grep -v '* develop' | xargs git branch -D"
############################################################-Utils-##############################################################
alias xclip="xclip -selection c" # Pipe to copy (e.g. echo test | xclip)
alias ls="ls --color=auto"
###########################################################-Scripts-#############################################################
alias infect="~/.scripts/infect.sh" # Interface for installing Pathogen plugins
alias tat="~/.scripts/tat.sh" # Creates a tmux session based on the name of dir
alias li="~/.scripts/li.sh" # Fetch login details from 1Password
###########################################################-Dotfiles-############################################################
alias vim="/usr/bin/nvim"
alias vimz="vim ~/.zshrc"
alias sz="source ~/.zshrc"
alias vimrc="vim ~/.config/nvim/init.vim"
alias fd="fdfind"
#########################################################-Project dirs-##########################################################
alias ui="cd /home/arnamak/Projects/adept-app/web_ui/src/@abbvie/adept-ui/"
alias api="cd /home/arnamak/Projects/adept-app/web_api/"
#################################################################################################################################
#-----------------------------------------------------LANGUAGES AND FRAMEWORKS--------------------------------------------------#
#############################################################-Python-############################################################
source ~/.poetry/env
eval "$(pyenv init - zsh --no-rehash)"
eval "$(pyenv virtualenv-init -)"
##############################################################-Node-#############################################################
export NVM_LAZY_LOAD=true
export NVM_AUTO_USE=true
#################################################################################################################################
#------------------------------------------------------------PLUGINS------------------------------------------------------------#
#################################################################################################################################
source "$HOME/.zinit/bin/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}'
zinit light zsh-users/zsh-autosuggestions
zinit light zdharma/history-search-multi-word
zinit light zdharma/fast-syntax-highlighting
zinit light "lukechilds/zsh-nvm"
zinit ice pick"async.zsh" src"pure.zsh"
zinit light sindresorhus/pure
zinit ice atclone"dircolors -b LS_COLORS > c.zsh" atpull'%atclone' pick"c.zsh" nocompile'!'
zinit light trapd00r/LS_COLORS
zinit snippet 'https://github.com/ohmyzsh/ohmyzsh/blob/master/plugins/colored-man-pages/colored-man-pages.plugin.zsh'
zinit snippet 'https://github.com/ohmyzsh/ohmyzsh/blob/master/plugins/command-not-found/command-not-found.plugin.zsh'
zinit snippet 'https://github.com/ohmyzsh/ohmyzsh/blob/master/plugins/zsh-interactive-cd/zsh-interactive-cd.plugin.zsh'
#################################################################################################################################
#---------------------------------------------------------CONFIGURATION---------------------------------------------------------#
#############################################################-Prompt-############################################################
zstyle :prompt:pure:path color green
zstyle ':prompt:pure:prompt:*' color white
#############################################################-Ulimit-############################################################
ulimit -n 65536 65536
ulimit -f unlimited
#############################################################-History-###########################################################
export HISTSIZE=100000
export SAVEHIST=100000
export HISTFILE=~/.zsh_history
export PER_DIRECTORY_HISTORY_TOGGLE=^=
##############################################################-Misc-#############################################################
bindkey '^n' autosuggest-accept
eval "$(hub alias -s)"
export FZF_DEFAULT_COMMAND="fdfind --type f --exclude node_modules --exclude __pycache__ --exclude poetry.lock"
export FZF_DEFAULT_OPTS='--bind=ctrl-u:up,ctrl-y:down'
#################################################################################################################################
#------------------------------------------------------------Unused-------------------------------------------------------------#
#################################################################################################################################
# _not_inside_tmux() { [[ -z "$TMUX" ]] }
# ensure_tmux_is_running() {
# if _not_inside_tmux; then
#   tat
# fi
# }
# ensure_tmux_is_running

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
