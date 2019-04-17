# `~/.gitconfig` file settings

```bash
[color]
	diff = auto
	status = auto
	branch = auto
	ui = true
[user]
	email = <YOUR_GIT_MAIL>.com
	name = <YOUR_NICKNAME>
[core]
	editor = nano
	excludefile = /Users/<YOUR_ACCOUNT>/.gitignore_global
	excludesfile = /Users/<YOUR_ACCOUNT>/.gitignore_global
[apply]
	whitespace = strip
[alias]
	co = checkout
	br = branch
	ci = commit
	st = status
	last = log -1 HEAD
	lg = log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --date=relative
	first = rev-list --max-parents=0 HEAD
	cleanup = "!git branch --merged | grep  -v '\\*\\|master\\|develop\\|staging\\|production' | xargs -n 1 git branch -d"
	rcleanup = "!git branch -r --merged | grep -v '\\*\\|master\\|develop\\|staging\\|production' | sed 's|origin/||' | xargs -n 1 git push --delete origin"
[filter "media"]
	required = true
	clean = git media clean %f
	smudge = git media smudge %f
[pager]
	branch = cat
```
