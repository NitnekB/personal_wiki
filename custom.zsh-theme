if [ $UID -eq 0 ]; then NCOLOR="red"; else NCOLOR="yellow"; fi

function evaluateDocker() {
  local ref
  if [[ -n ${DOCKER_MACHINE_NAME} ]]; then
    ref=$DOCKER_MACHINE_NAME || return 0
    echo "/ %{$fg[blue]%}🐳  $ref%{$reset_color%}";
  fi
}

PROMPT='%n:%{$fg[$NCOLOR]%}%c ➤ %{$reset_color%}'
RPROMPT='%{$fg[$NCOLOR]%}%p $(git_prompt_info)%{$reset_color%} / %{$fg[red]%}💎 %{$reset_color%} %{$fg[red]%}‹$(rbenv version-name)› %{$reset_color%} $(evaluateDocker)'

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[green]%}git:%{$fg[yellow]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%} "
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[red]%}✗"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[blue]%}"
