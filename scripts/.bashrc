alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '

alias pacman='sudo pacman'
alias upgr='pacman -Syyu --ignore qemu-git && yay -Syyu '
alias fuck='sudo $(history -p !!)'

alias bd=". bd -si"
