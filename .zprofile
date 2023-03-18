if [ -z "${DISPLAY}" ] && [ "${XDG_VTNR}" -eq 1 ]; then
  ~/.config/sway/scripts/gen_sway_config.sh
  exec sway --unsupported-gpu
fi

