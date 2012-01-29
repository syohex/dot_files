#!/bin/sh
export XMODIFIERS="@im=ibus"
export GTK_IM_MODULE="ibus"
ibus-daemon -d -x

gnome-settings-daemon &
gnome-power-manager &
gnome-volume-control-applet &
nm-applet --sm-disable &
exec /usr/bin/awesome -c ~/.config/awesome/rc.lua
