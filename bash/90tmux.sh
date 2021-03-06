
[[ -s $HOME/.tmuxinator/scripts/tmuxinator ]] && source $HOME/.tmuxinator/scripts/tmuxinator

tmuxinator_completion="`ls -1 ~/.rbenv/versions/*/lib/ruby/gems/*/gems/tmuxinator-*/completion/tmuxinator.bash 2>/dev/null|tail -1`"

[[ -e "$tmuxinator_completion" ]] && source "$tmuxinator_completion"

# Re-source, dunno why, but it just doesn't stick
if [[ "$TMUX" ]]; then
  tmux source-file ~/.tmux.conf
fi
