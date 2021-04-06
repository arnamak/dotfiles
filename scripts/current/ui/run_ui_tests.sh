function run_ui_tests() {
  tmux send-keys "$CURRENT_PROJECT_UI_TEST_RUNNER" "C-m"
}
