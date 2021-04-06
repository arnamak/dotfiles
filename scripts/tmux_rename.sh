function tmux_rename_session_with_key() {
  tmux rename-session $(echo $NGROK_TMUX_SESSION_KEY)
}
