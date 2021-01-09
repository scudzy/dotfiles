# Setup fzf
# ---------
if [[ ! "$PATH" == */home/scudzy/.fzf/bin* ]]; then
  export PATH="${PATH:+${PATH}:}/home/scudzy/.fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/home/scudzy/.fzf/shell/completion.zsh" 2> /dev/null

# Key bindings
# ------------
source "/home/scudzy/.fzf/shell/key-bindings.zsh"
