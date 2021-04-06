cd ~/.config/nvim/bundle

while PLGS= read -r plugin; do
  git clone git://github.com"$(echo $plugin)"
done <$HOME/dotfiles/.vim-plugins-parseable.txt
