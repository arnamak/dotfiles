function boot_api() {
  tmux send-keys "$CURRENT_PROJECT_API_LANG_INIT" 'C-m'
  tmux send-keys "$CURRENT_PROJECT_DOCKER_CMD" 'C-m'
  tmux send-keys "$CURRENT_PROJECT_RUNNER_CMD" 'C-m'
}
