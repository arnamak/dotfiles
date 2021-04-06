function replace_local_api_url_for_ngrok_api_url() {
  sed -i "s/localhost:$NGROK_API_PORT/$NGROK_API_HOSTNAME/g" $(echo $CURRENT_PROJECT_UI_URLS)
}

function replace_ngrok_api_url_for_local_api_url() {
  sed -i "s/$NGROK_API_HOSTNAME/localhost:$NGROK_API_PORT/g" $(echo $CURRENT_PROJECT_UI_URLS)
}
