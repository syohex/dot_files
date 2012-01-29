#!/bin/sh

EMACS_PID=`ps ux | grep --color=none 'emacs --reverse$' | awk '{ print $2 }'`

if [ "$EMACS_PID" = "" ]
then
    exec emacs --reverse
fi

EMACS_WID=`wmctrl -p -l | perl -awln -e "print \\$F[0] if \\$F[2] == $EMACS_PID"`
wmctrl -i -a $EMACS_WID
