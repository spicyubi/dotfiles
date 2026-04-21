#
# ~/.bashrc
#
# If not running interactively, don't do anything
[[ $- != *i* ]] && return

fastfetch

alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias pf='~/scripts/port-forwarding.sh'
alias info='info --vi-keys'

PS1='[\u@\h \W]\$ '

# arch linux docs. start ssh agent automatically
if ! pgrep -u "$USER" ssh-agent > /dev/null; then
    ssh-agent -t 3h > "$XDG_RUNTIME_DIR/ssh-agent.env"
fi
if [ ! -f "$SSH_AUTH_SOCK" ]; then
    source "$XDG_RUNTIME_DIR/ssh-agent.env" >/dev/null
fi

VPNUS="/etc/wireguard/mango-US-CA-57.conf"
VPNSG="/etc/wireguard/mango-SG-17.conf"
VPNSG2="/etc/wireguard/mango-4-SG-18.conf"
VPNID="/etc/wireguard/mango-ID-16.conf"

export MANPAGER='nvim +Man! "+set nu relativenumber"'
eval "$(starship init bash)"
. "/home/kevin/.local/share/bob/env/env.sh"

eval "$(fzf --bash)"
set -o vi
