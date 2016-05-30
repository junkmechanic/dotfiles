#!/bin/sh
xrandr --output VGA1 --off --output LVDS1 --mode 1366x768 --pos 1920x0 --rotate normal --output DP1 --off --output HDMI1 --mode 1920x1080 --pos 0x0 --rotate normal &
pkill conky &
conky -c ~/.conky/conkyrc-stats &
killall tint2 &
tint2 -c ~/.config/tint2/tint2rc_lvsd &
nitrogen --restore &
