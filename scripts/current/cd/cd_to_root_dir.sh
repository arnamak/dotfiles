function cd_to_root_dir() {
  tmux send-keys "cd $(echo $CURRENT_PROJECT_ROOT)" "C-m"
  tmux send-keys "clear" "C-m"
}
