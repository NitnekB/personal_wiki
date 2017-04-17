alias meteo="clear && curl -4 wttr.in/lille"

alias -g G='|grep '

# Console Bindkey
bindkey "^[^[[C" forward-word
bindkey "^[^[[D" backward-word

# Function to find IP Address from a container
function dip() {
  docker inspect --format '{{ .NetworkSettings.IPAddress }}' $1
}
