echo "Provide the username and repo name portion of the URL (e.g. '/arnamak/infect.git')"
read plugin
cd ~/.config/nvim/bundle && \
    git clone git://github.com"$(echo $plugin)"
