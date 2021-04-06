. $SCRIPTS_DIR/current/cd/cd_to_ui_dir.sh
. $SCRIPTS_DIR/current/ui/run_ui_tests.sh


function tmux_layout_dubs() {
  tmux split-window -h
}
function tmux_layout_trips() {
  tmux split-window -h
  tmux split-window -v
}
function tmux_layout_quads() {
  tmux split-window -v
  tmux split-window -h
  tmux select-pane -U
  tmux split-window -h
}
function tmux_init_active_dev_tab() {
  cd_to_ui_dir
  tmux split-window -v
  tmux split-window -v
  tmux split-window -v
  cd_to_ui_dir
  tmux split-window -h
  cd_to_ui_dir
  tmux select-pane -U
  tmux kill-pane
  tmux select-pane -U
  tmux kill-pane
  run_ui_tests
}
function tmux_new_window_at_project_root() {
  tmux new-window -c "#{$(echo $CURRENT_PROJECT_ROOT)}"
}
