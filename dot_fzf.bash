# Setup fzf
# ---------
if [[ ! "$PATH" == */home/vagrant/.fzf/bin* ]]; then
  PATH="${PATH:+${PATH}:}/home/vagrant/.fzf/bin"
fi

eval "$(fzf --bash)"
