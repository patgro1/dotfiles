pkill wlogout
if ! command -v hyprlock >/dev/null 2>&1
then
    swaylock --clock --indicator
else
    hyprlock
fi

