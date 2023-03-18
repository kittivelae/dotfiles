#!/bin/bash

# The Sway configuration file in ~/.config/sway/config calls this script.
# You should see changes to the status bar after saving this script.
# If not, do "killall swaybar" and $mod+Shift+c to reload the configuration.

# Get the last affirmation update time from the temp file
temp_file="$HOME/.config/sway/resources/last_affirmation_update"
if [ -f "$temp_file" ]; then
  last_affirmation_update=$(head -n 1 "$temp_file")
  affirmation=$(tail -n 1 "$temp_file")
else
  last_affirmation_update=0
  affirmation=""
fi

current_time=$(date +%s)

# Update the affirmation if 600 seconds have passed
if [ $((current_time - last_affirmation_update)) -ge 300 ]; then
  affirmation=$(shuf -n 1 "$HOME/.config/sway/resources/affirmations.txt")
  echo -e "$current_time\n$affirmation" > "$temp_file"
fi

# Your existing status update code...
uptime_formatted=$(uptime | cut -d ',' -f1  | cut -d ' ' -f4,5)
date_formatted=$(date "+%a %F %H:%M")
linux_version=$(uname -r | cut -d '-' -f1)

echo $affirmation $uptime_formatted ↑ $linux_version \| $date_formatted
