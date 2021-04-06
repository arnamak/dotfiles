. $SCRIPTS_DIR/tmux_layout.sh
. $SCRIPTS_DIR/current/cd/cd_to_api_dir.sh
. $SCRIPTS_DIR/tmux_movement.sh
. $SCRIPTS_DIR/current/boot/boot_api.sh
. $SCRIPTS_DIR/current/boot/boot_ui.sh

cd_to_api_dir
tmux_layout_dubs
tmux_select_pane_left
boot_api
tmux_select_pane_right
cd_to_ui_dir
boot_ui
tmux_new_window_at_project_root
tmux_init_active_dev_tab
