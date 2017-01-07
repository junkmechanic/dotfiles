#!/usr/bin/bash

wid=$1
class=$2
instance=$3
title=$(xtitle "$wid")
# echo "wid : $wid ; class : $class ; instance : $instance ; title : $title" >>~/tmp/bspwm_external_rules.log

if [[ "$title" == 'Task Manager - Chromium' ]]; then
    echo "state=floating"
elif [[ "$class" == "Spacefm" ]]; then
    case $title in
        Stopped)
            echo "state=floating"
            ;;
    esac
fi
