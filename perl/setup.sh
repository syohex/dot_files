#!/bin/sh

# PAUSE configuration file
rm -f ~/.pause
ln -s $PWD/pause ~/.pause
chmod 600 ~/.pause

# ack configuration file
rm -f ~/.ackrc
ln -s $PWD/ackrc ~/.ackrc
