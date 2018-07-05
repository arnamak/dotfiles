export TERM="xterm-256color"

 PROMPT="λ >> "

 # quick access to dotfiles
 alias vim="/usr/local/bin/vim"
 alias vimz="vim ~/.zshrc"
 alias vimrc="vim ~/.vimrc"
 alias sz="source ~/.zshrc"

 # git
 alias gc="git commit "
 alias gad="git add ."
 alias gap="git add -p"
 alias gapn='git add --intent-to-add . && git add --patch' # Patch mode with untracked files. This is the one I primarily use.
 alias gs='git status'
 alias ggpush='git push'
 alias ggpull='git pull'
 alias gco='git checkout '
 alias gcd='git checkout develop'
 alias gca='git commit --amend'
 alias reset="git reset "
 alias gl="git log --oneline --all --graph"

 # Used to create a tmux session with the name of the directory you're in
 alias tat='sh /Users/arnamak/.scripts/tat.sh'

 # Script that mostly automates the use of PathogenVim. More: github.com/arnamak/dotfiles/scripts/infect.sh
 alias infect='sh /Users/arnamak/.scripts/infect.sh'

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"
export PATH="/usr/local/opt/qt@5.5/bin:$PATH"
export PATH="/usr/local/opt/icu4c/bin:$PATH"
export PATH="/usr/local/opt/icu4c/sbin:$PATH"
source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
 [[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
_not_inside_tmux() { [[ -z "$TMUX" ]] }

ensure_tmux_is_running() {
  if _not_inside_tmux; then
    tat
  fi
}

ensure_tmux_is_running
ulimit -n 65536 65536
export PATH="/usr/local/opt/erlang@19/bin:$PATH"
