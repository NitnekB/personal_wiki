if [ $UID -eq 0 ]; then NCOLOR="red"; else NCOLOR="yellow"; fi

function evaluateDocker() {
  local ref
  if [[ -n ${DOCKER_MACHINE_NAME} ]]; then
    ref=$DOCKER_MACHINE_NAME || return 0
    echo "%{$fg[magenta]%}/%{$reset_color%}%{$fg[blue]%} 🐳 $ref%{$reset_color%}";
  fi
}

local git_branch='$(git_prompt_status)%{$reset_color%}'
local git='$(git_prompt_info)%{$reset_color%}%{$fg[magenta]%}/%{$reset_color%}'
local ruby='%{$fg[red]%}💎 ‹$(rbenv version-name)›'
local docker='%{$reset_color%}$(evaluateDocker)'

PROMPT='%n%{$fg[magenta]%}:%{$reset_color%}%{$fg[$NCOLOR]%}%c ➤ %{$reset_color%}'
RPROMPT="${git} ${ruby} ${docker}"

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[green]%}➦ %{$fg[yellow]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%} "
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[red]%}✗"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[green]%} ✭"

ZSH_THEME_GIT_PROMPT_ADDED="%{$fg[green]%} ✚"
ZSH_THEME_GIT_PROMPT_MODIFIED="%{$fg[blue]%} ✹"
ZSH_THEME_GIT_PROMPT_DELETED="%{$fg[red]%} ✖"
ZSH_THEME_GIT_PROMPT_RENAMED="%{$fg[magenta]%} ➜"
ZSH_THEME_GIT_PROMPT_UNMERGED="%{$fg[yellow]%} ═"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg[cyan]%} ✭"
