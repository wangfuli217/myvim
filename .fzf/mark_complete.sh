#------------------------------------------------
# Name    : mkb
# Input   : path
# Purpose : soft symlink passed path to ~/.marks
#           empty input raises error cose 1
#------------------------------------------------
mkb() {
    # # add help option == print and exit
    # if [ "$1" == "-h" ]; then
    #     echo "Usage:"
    #   return 0
    # fi
    if [[ -n "$1" ]]
    then
        echo "symlinking \$PWD to \$HOME/.marks/$1"
        ln -s "$PWD" "$HOME/.marks/$1"
    else
        # echo "input is empty : symlink \$PWD to \$HOME/.marks/$(basename $PWD)"
        # ln -s "$PWD" $HOME/.marks/
        echo "mkb"
        echo "===="
        echo
        echo "Wrapper to symlinking current directory to \$HOME/.marks."
        echo "Input with trailing / are treated like directory, symlinking to 'input/original_name'"
        echo "Input without trailing / are used like final ouput name."
        echo
        echo "Usage:"
        echo "   mkb ${GREEN}STRING${RESET} > ln -s \$PWD \$HOME/.marks/${GREEN}STRING${RESET}"
        echo "   mkb ${GREEN}DIRECTORY${RED}/${RESET} > ln -s \$PWD \$HOME/.marks/${GREEN}DIRECTORY${RESET}/${RED}ORIGINAL_NAME${RESET}"
      return 0
    fi
}
#------------------------------------------------

listmarks () { find ~/.marks | fzf --preview "ls $LS_OPTIONS -l {}/" --select-1 --exit-0 --height=50%; }

mkg() {
    if [ $# -eq 0 ]
    then
        echo "mkg"
        echo "======"
        echo
        echo "Dummy cd wrapper to add fzf completion to \$HOME/.marks/ directory."
        echo "See also cdmark_fzf"
        echo
        echo "Usage:"
        echo "   mkg ${GREEN}STRING${RESET} > cd ${GREEN}STRING${RESET}"
        return 1
    else
       # jump to realpath of input symlink
       cd "$(realpath "$1")"
    fi
}


# this completes the mkg command when jumping
alias cdmark_fzf='cd $(listmarks)'
alias goto='mkg'
alias goln='mkb'
# see [junegunn/fzf: A command-line fuzzy finder](https://github.com/junegunn/fzf#custom-fuzzy-completion)
_fzf_complete_marks() {

  _fzf_complete --multi --preview 'exa -lTL 2 --color=always {}/ | head -200' --reverse --preview-window wrap --min-height 15 -- "$@" < <(
    find ~/.marks -type l
  )
}

_fzf_complete_marks_wrap() {
  local trigger=${FZF_COMPLETION_TRIGGER-'**'}
  local cur="${COMP_WORDS[COMP_CWORD]}"
  if [[ -z "$cur" ]]; then
    COMP_WORDS[$COMP_CWORD]=$trigger
  elif [[ "$cur" != *"$trigger" ]]; then
    return 1
  fi

  _fzf_complete_marks "$@"
}

# _fzf_complete_marks_post() {
#   realpath $1
# }

# Kill completion (supports empty completion trigger)
complete -o default -o bashdefault -F _fzf_complete_marks_wrap mkg goto

# this completes the mkb command when marking
_fzf_complete_marks_ls() {
  _fzf_complete --multi --reverse  -- "$@" < <(
    find ~/.marks -type d
  )
}

_fzf_complete_marks_ls_post() {
  cut -c 22-
}

complete -o default -o bashdefault -F _fzf_complete_marks_ls mkb

_fzf_complete_goln() {
  _fzf_complete --multi --reverse --prompt="goln> " -- "$@" < <(
    [ -f /home/wangfuli/.fzf-marks ] && cat  /home/wangfuli/.fzf-marks | awk -F ':' '{ print $1 }'
  )
}

[ -n "$BASH" ] && complete -F _fzf_complete_goln -o default -o bashdefault goln
[ -n "$BASH" ] && complete -F _fzf_complete_goln -o default -o bashdefault mkb
