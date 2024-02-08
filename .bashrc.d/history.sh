# Save each command immediately instead of waiting until the session is closed
PROMPT_COMMAND="history -a"

# Append to the history file instead of overwriting it
shopt -s histappend

# Ignore commands that have a leading space, duplicates, and commands that match the previous command
HISTCONTROL=ignoreboth:ignoredups

# Ignore specific commands from being saved in history
HISTIGNORE="cd:ls:clear:exit"

# Set the maximum number of commands to be saved in history
HISTSIZE=100000

# Set the maximum number of lines in the history file
HISTFILESIZE=100000000

# Set the format of the timestamp for each command in history
HISTTIMEFORMAT="%F %T "
