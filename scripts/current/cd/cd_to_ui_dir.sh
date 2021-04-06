function cd_to_ui_dir() {
  tmux send-keys "cd $(echo $CURRENT_PROJECT_UI_ROOT)" "C-m"
  tmux send-keys "clear" "C-m"
}
