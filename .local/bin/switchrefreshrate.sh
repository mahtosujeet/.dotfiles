MONITOR="eDP-1"

if echo "$(hyprctl monitors)" | grep '0x0' | grep -q '144'; then
    hyprctl keyword monitor "$MONITOR,1920x1080@60,0x0,1"
    notify-send -u normal -t 5000 "Changed Refresh Rate:" "144Hz -> 60Hz"
else
    hyprctl keyword monitor "$MONITOR,1920x1080@144,0x0,1"
    notify-send -u normal -t 5000 "Changed Refresh Rate:" "60Hz -> 144Hz"
fi

