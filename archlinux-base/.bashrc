#
# ~/.bashrc
#
# If not running interactively, don't do anything
[[ $- != *i* ]] && return

export TERM=xterm-256color
export PAGER='nvim -R'

alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '

# Credit: https://github.com/rust-lang/rustup/blob/master/src/cli/self_update/env.sh
case ":${PATH}:" in
    *:"$HOME/.local/share/bob/nvim-bin":*)
        ;;
    *)
        export PATH="$HOME/.local/share/bob/nvim-bin:$PATH"
        ;;
esac

set -o vi
eval "$(fzf --bash)"
