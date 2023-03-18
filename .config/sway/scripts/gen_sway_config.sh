#!/bin/bash

# Read the SWAY_THEMES_DIR environment variable and set the fallback value if necessary
SWAY_THEMES_DIR="${SWAY_THEMES_DIR:-$HOME/.config/sway/themes}"

# Determine the current theme symlink
if [ $(date +%H) -ge 19 ] || [ $(date +%H) -lt 6 ]; then
  CURRENT_THEME="$SWAY_THEMES_DIR/dark_theme"
else
  CURRENT_THEME="$SWAY_THEMES_DIR/light_theme"
fi

# Generate the sway config file with the expanded environment variable and symlink
{
  cat << EOF
# Sway config file with expanded environment variables

set \$themes $SWAY_THEMES_DIR
include $CURRENT_THEME

EOF

  # Include the content of your base config file
  cat ~/.config/sway/config_base

  cat << EOF
bindsym \$mod+Shift+r exec ~/.config/sway/scripts/gen_sway_config.sh && swaymsg reload
EOF

} > ~/.config/sway/config
