# /etc/skel/.bashrc

# Test for an interactive shell.  There is no need to set anything
# past this point for scp and rcp, and it's important to refrain from
# outputting anything in those cases.
if [[ $- != *i* ]] ; then
	# Shell is non-interactive.  Be done now!
	return
fi

HISTSIZE=20000
HISTFILESIZE=20000

shopt -s histappend

bind "set completion-ignore-case on"
set -o vi

# Put your fun stuff here.

alias vim='nvim'
alias i3lock='i3lock -i ~/Pictures/wallpapers/ocean_1758733229656562.png'
alias mkdir='mkdir -p'

PS1="\[\e[01;32m\]\u@\h\[\e[01;34m\] \W λ \[\e[00m\]"
