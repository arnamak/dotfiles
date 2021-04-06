#! /bin/sh
. $SCRIPTS_DIR/tmux_layout.sh
. $SCRIPTS_DIR/tmux_rename.sh
. $SCRIPTS_DIR/current/cd/cd_to_api_dir.sh
. $SCRIPTS_DIR/tmux_movement.sh
. $SCRIPTS_DIR/current/ui/switch_api_url.sh
. $SCRIPTS_DIR/current/boot/boot_api.sh
. $SCRIPTS_DIR/current/boot/boot_ui.sh
. $SCRIPTS_DIR/current/ngrok/ngrok_serve_tmux_session.sh
. $SCRIPTS_DIR/current/ngrok/ngrok_serve_api.sh

tmux_rename_session_with_key
cd_to_api_dir
tmux_layout_quads
tmux_select_pane_left
boot_api
tmux_select_pane_down
ngrok_serve_api
tmux_select_pane_right
tmux_select_pane_up
cd_to_ui_dir
boot_ui
tmux_select_pane_down
ngrok_serve_tmux_session
tmux_new_window_at_project_root
replace_local_api_url_for_ngrok_api_url
tmux_init_active_dev_tab
