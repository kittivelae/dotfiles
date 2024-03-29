#!/bin/bash

LIGHT_MODE_BACKGROUND="#f0f0f0"
LIGHT_MODE_FOREGROUND="#333333"
LIGHT_MODE_BORDER="#999999"
LIGHT_MODE_CLIENT_FOCUSED="#5599ff"
LIGHT_MODE_CLIENT_UNFOCUSED="#bbbbbb"
LIGHT_MODE_WALLPAPER="/path/to/light_mode_wallpaper.jpg"

DARK_MODE_BACKGROUND="#1c1c1c"
DARK_MODE_FOREGROUND="#c0c0c0"
DARK_MODE_BORDER="#444444"
DARK_MODE_CLIENT_FOCUSED="#3a3a3a"
DARK_MODE_CLIENT_UNFOCUSED="#6a6a6a"
DARK_MODE_WALLPAPER="/path/to/dark_mode_wallpaper.jpg"

# Get current hour
CURRENT_HOUR=$(date +%H)

# Set initial mode based on the current hour (use dark mode between 19:00 - 06:00, light mode otherwise)
if [[ $CURRENT_HOUR -ge 19 ]] || [[ $CURRENT_HOUR -lt 6 ]]; then
    BACKGROUND=$DARK_MODE_BACKGROUND
    FOREGROUND=$DARK_MODE_FOREGROUND
    BORDER=$DARK_MODE_BORDER
    CLIENT_FOCUSED=$DARK_MODE_CLIENT_FOCUSED
    CLIENT_UNFOCUSED=$DARK_MODE_CLIENT_UNFOCUSED
    WALLPAPER=$DARK_MODE_WALLPAPER
else
    BACKGROUND=$LIGHT_MODE_BACKGROUND
    FOREGROUND=$LIGHT_MODE_FOREGROUND
    BORDER=$LIGHT_MODE_BORDER
    CLIENT_FOCUSED=$LIGHT_MODE_CLIENT_FOCUSED
    CLIENT_UNFOCUSED=$LIGHT_MODE_CLIENT_UNFOCUSED
    WALLPAPER=$LIGHT_MODE_WALLPAPER
fi

function switch_theme() {
    if [ "$BACKGROUND" == "$DARK_MODE_BACKGROUND" ]; then
        BACKGROUND=$LIGHT_MODE_BACKGROUND
        FOREGROUND=$LIGHT_MODE_FOREGROUND
        BORDER=$LIGHT_MODE_BORDER
        CLIENT_FOCUSED=$LIGHT_MODE_CLIENT_FOCUSED
        CLIENT_UNFOCUSED=$LIGHT_MODE_CLIENT_UNFOCUSED
        WALLPAPER=$LIGHT_MODE_WALLPAPER
    else
        BACKGROUND=$DARK_MODE_BACKGROUND
        FOREGROUND=$DARK_MODE_FOREGROUND
        BORDER=$DARK_MODE_BORDER
        CLIENT_FOCUSED=$DARK_MODE_CLIENT_FOCUSED
        CLIENT_UNFOCUSED=$DARK_MODE_CLIENT_UNFOCUSED
        WALLPAPER=$DARK_MODE_WALLPAPER
    fi
}
