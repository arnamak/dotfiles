function cd_to_api_dir() {
  tmux send-keys "cd $(echo $CURRENT_PROJECT_API_DIR)" "C-m"
  tmux send-keys "clear" "C-m"
}
