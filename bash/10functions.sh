
function __command_exists {
  hash $1 2>&-
}

# Split a temporary long-running process
#
# For example:
#
#   tmw watch df -h
function tmw {
  tmux split-window -dvb -p 30 "$*"
}
