#!/bin/bash

case "$1" in
    single)
        xrandr > /dev/null 2>&1
        xrandr --output LVDS1 --mode 1366x768 --output VGA1 --off
        pushd "$HOME"/.config/i3/ > /dev/null 2>&1
        mv config .config-multi-monitor
        sleep 1
        mv .config-single-monitor config
        sleep 1
        popd > /dev/null 2>&1
        sleep 1
        i3-msg -q reload
        sleep 2
        i3-msg -q restart
        sleep 1
        feh --bg-scale "$HOME/Public/desktop/wp-i3.png"
        ;;
    multi)
        xrandr > /dev/null 2>&1
        xrandr --output VGA1 --mode 1920x1080 --right-of LVDS1
        pushd "$HOME"/.config/i3/ > /dev/null 2>&1
        mv config .config-single-monitor
        sleep 1
        mv .config-multi-monitor config
        sleep 1
        popd > /dev/null 2>&1
        sleep 1
        i3-msg -q reload
        sleep 2
        i3-msg -q restart
        sleep 1
        feh --bg-scale "$HOME/Public/desktop/wp-i3.png" --bg-scale \
        "$HOME/Pictures/4-chin-wg/w-nonpleb/1482296134107.jpg"
        ;;
    *)
        echo "Usage: $0 {single|multi}"
        exit 1
esac

exit 0
