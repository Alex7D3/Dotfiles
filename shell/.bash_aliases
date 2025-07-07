# If we are not running interactively do not continue loading this file.
case $- in
    *i*) ;;
      *) return;;
esac

alias vim="nvim"
alias vi="nvim"

alias venv="source .venv/bin/activate"
alias apt-update="sudo apt update -y && sudo apt upgrade -y"
