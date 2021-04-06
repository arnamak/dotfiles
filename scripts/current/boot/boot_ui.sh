function boot_ui() {
  tmux send-keys "$CURRENT_PROJECT_UI_SERVER_CMD" "C-m"
}
