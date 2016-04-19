#!/bin/bash
#
# pop-up calendar for dzen
#
# based on (c) 2007, by Robert Manea
# http://dzen.geekmode.org/dwiki/doku.php?id=dzen:calendar
# modified by urukrama
#

TODAY=$(expr `date +'%d'` + 0)
MONTH=`date +'%m'`
YEAR=`date +'%Y'`

CLR1='#1d2a30'
CLR2='#71c2af'
CLR3='#536641'

(
echo
echo "^fg($CLR2)^bg($CLR1)"`date +'%A %d %B %Y %n'`; echo
\
# current month, hilight header and today
$(echo cal -h) \
    | sed -r "s/^(.*[A-Za-z][A-Za-z]*.*)$/^fg($CLR2)^bg($CLR1)\1/;s/(^|[ ])($TODAY)($|[ ])/\1^fg($CLR2)^bg($CLR1)\2^fg($CLR3)^bg($CLR1)\3/"

# next month, hilight header
[ $MONTH -eq 12 ] && YEAR=`expr $YEAR + 1`
cal `expr \( $MONTH + 1 \) % 12` $YEAR \
    | sed -r "s/^(.*[A-Za-z][A-Za-z]*.*)$/^fg($CLR2)^bg($CLR1)\1/"

sleep 8
) \
    | dzen2 -fg "$CLR3" -bg "$CLR1" -fn 'DejaVu Sans Mono-12' -x 2770 -y 60 -w 380 -l 18 -sa c -e 'onstart=uncollapse;key_Escape=ungrabkeys,exit'
