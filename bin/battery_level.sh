#!/bin/bash
cap=$(cat /proc/acpi/battery/BAT0/info | grep 'last full capacity' | awk ' { print $4 }')
cur=$(cat /proc/acpi/battery/BAT0/state | grep 'remaining capacity' | awk ' { print $3 }')
bat=$(echo "print('{:.2f}'.format($cur * 100 / $cap))" | python3)
notify-send -t 3000 -u low -i /usr/share/pixmaps/battery-low-symbolic.svg "Battery Level" "$bat %"
