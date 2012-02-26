#!/bin/sh

if which gnome-terminal > /dev/null 2>&1
then
    exec env VTK_CJK_WIDTH=1 gnome-terminal --hide-menubar --disable-factory \
            --working-directory=$HOME
fi

if which xfce4-terminal > /dev/null 2>&1
then
    exec xfce4-terminal --hide-menubar
fi

zenity --error --text "Please install Terminal Emulator Programs!!"

