#!/bin/bash
# cap=$(cat /proc/acpi/battery/BAT0/info | grep 'last full capacity' | awk ' { print $4 }')
# cur=$(cat /proc/acpi/battery/BAT0/state | grep 'remaining capacity' | awk ' { print $3 }')
# bat=$(echo "print('{:.2f}'.format($cur * 100 / $cap))" | python3)
# notify-send -t 3000 -u low -i /usr/share/pixmaps/battery-low-symbolic.svg "Battery Level" "$bat %"

# this is a more universal way for debian machines
batvar=$(upower -e | grep 'BAT')
state=$(upower -i $batvar | grep 'state' | awk ' { print $2 }')
level=$(upower -i $batvar | grep 'percen' | awk ' { print $2 }')
notify-send -t 3000 -u low -i /usr/share/pixmaps/battery_notify.svg "Battery" "Battery State : $state\nBattery Level : $level"
