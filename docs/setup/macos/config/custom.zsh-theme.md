# `~/.oh-my-zsh/themes/custom.zsh-theme` file configuration

Take care to use it on `~/.zshrc` file!

```bash
if [ $UID -eq 0 ]; then NCOLOR="red"; else NCOLOR="yellow"; fi

EMOJI_NODE=🔗
EMOJI_RUBY=💎
NODE_MAJOR_LTS="v16"

#function evaluateDocker() {
#  local ref
#  if [[ -n ${DOCKER_MACHINE_NAME} ]]; then
#    ref=$DOCKER_MACHINE_NAME || return 0
#    echo "%{$fg[magenta]%}/%{$reset_color%}%{$fg[blue]%} 🐳 $ref%{$reset_color%}";
#  fi
#}

function evaluateGit() {
  inside_git_repo="$(git rev-parse --is-inside-work-tree 2>/dev/null)"
  if [ "$inside_git_repo" ]; then
    echo "$(git_prompt_info)%{$reset_color%}%{$fg[magenta]%}/%{$reset_color%}"
  fi
}

function evaluateNode() {
  node_version="$(node --version)"
  if [[ "$NODE_MAJOR_LTS" < "$node_version" ]]; then
    echo "%{$fg[green]%}$EMOJI_NODE‹$node_version›"
  else
    echo "%{$fg[red]%}$EMOJI_NODE%{$fg[green]%}‹$node_version›"
  fi
}

function evaluateCodeContext() {
  if [[ -f package.json ]]; then
    echo $(evaluateNode)
  elif [[ -f Gemfile ]]; then
    echo "%{$fg[red]%}$EMOJI_RUBY‹$(rbenv version-name)›"
  else
    echo "%{$fg[cyan]%}$EMOJI_NODE%{$fg[green]%}‹$(node --version)›"
  fi
}

local git_branch='$(git_prompt_status)%{$reset_color%}'
local git='$(evaluateGit)'
local code_context='$(evaluateCodeContext)'

PROMPT="%{$fg[white]%}%n%{$fg[magenta]%}:%{$reset_color%}%{$fg[$NCOLOR]%}%c ➤ %{$reset_color%} "
RPROMPT="${git} ${code_context}%{$reset_color%}"

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[cyan]%}➦ %{$fg[yellow]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%} "
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[red]%}✗"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[green]%}✔"

ZSH_THEME_GIT_PROMPT_ADDED="%{$fg[green]%} ✚"
ZSH_THEME_GIT_PROMPT_MODIFIED="%{$fg[blue]%} ✹"
ZSH_THEME_GIT_PROMPT_DELETED="%{$fg[red]%} ✖"
ZSH_THEME_GIT_PROMPT_RENAMED="%{$fg[magenta]%} ➜"
ZSH_THEME_GIT_PROMPT_UNMERGED="%{$fg[yellow]%} ═"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg[cyan]%} ✭"
```
