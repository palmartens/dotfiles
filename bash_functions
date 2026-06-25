openGpaSession() {
    local session="gpa"

    # Als sessie al bestaat: attach
    if tmux has-session -t "$session" 2>/dev/null; then
        tmux attach -t "$session"
        return
    fi

    # Start nieuwe sessie - bovenste paneel
    tmux new-session -d -s "$session" -c "$HOME/gpa/logs/local" \
        'bash -c "./tail-logs.sh; exec bash"'

    # Maak linksonder paneel
    tmux split-window -v -c "$HOME/Sources/ws/DEV" -t "${session}:0"

    # Maak rechtsonder paneel
    tmux split-window -h -c "$HOME/Sources/ws/DEV" -t "${session}:0.1"

    # Start ctop (nu bestaat paneel 0.2 wél)
    tmux send-keys -t "${session}:0.2" 'ctop' C-m

    # Focus terug naar linksonder
    tmux select-pane -t "${session}:0.1"

    # Attach
    tmux attach -t "$session"
}

function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	command yazi "$@" --cwd-file="$tmp"
	IFS= read -r -d '' cwd < "$tmp"
	[ "$cwd" != "$PWD" ] && [ -d "$cwd" ] && builtin cd -- "$cwd"
	command rm -f -- "$tmp"
}

function fzfgo() {
  local file
  file=$(fzf -e --preview 'bat --style=numbers --color=always --line-range :500 {} 2>/dev/null || cat {}')

  if [ -n "$file" ]; then
    cd "$(dirname "$file")" || return
  fi
}
