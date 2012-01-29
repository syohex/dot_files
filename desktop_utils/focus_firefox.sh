#!/bin/sh

wmctrl -a 'Firefox'

if [ $? -ne 0 ]
then
    exec firefox
fi
