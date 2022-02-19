# `~/.gitconfig` file settings

```bash
[color]
	diff = auto
	status = auto
	branch = auto
	ui = true
[color "status"]
  added = green
  changed = red bold
  untracked = magenta bold

[color "branch"]
  remote = yellow
[user]
	email = qbuirette@apizr.fr
	name = nitnek
[core]
	editor = code -w
	excludefile = /Users/nitnek/.gitignore_global
	excludesfile = /Users/nitnek/.gitignore_global
	pager = diff-so-fancy | less --tabs=4 -RFX
[apply]
	whitespace = strip
[alias]
	co = checkout
	br = branch -v
	ci = commit
	st = status
	last = log -1 HEAD
	lg = log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --date=relative
	first = rev-list --max-parents=0 HEAD
	cleanup = "!git branch --merged | grep  -v '\\*\\|master\\|develop\\|staging\\|production' | xargs -n 1 git branch -d"
	rcleanup = "!git branch -r --merged | grep -v '\\*\\|master\\|develop\\|staging\\|production' | sed 's|origin/||' | xargs -n 1 git push --delete origin"
	kesako = "ls-remote"
[filter "media"]
	required = true
	clean = git media clean %f
	smudge = git media smudge %f
[pager]
	branch = cat
[interactive]
	diffFilter = diff-so-fancy --patch
[color "diff"]
	meta = 13
	frag = 12
	whitespace = red reverse
	new = green bold
	old = red bold
	commit = yellow bold
[color "diff-highlight"]
	oldNormal = red bold
	oldHighlight = red bold 52
	newNormal = green bold
	newHighlight = green bold 22
[diff-so-fancy]
	changeHunkIndicators = true
	stripLeadingSymbols = false
```
