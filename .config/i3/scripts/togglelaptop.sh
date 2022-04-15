#!/bin/bash

SCREEN="eDP1"

if [ -z "$(xrandr --listactivemonitors|grep $SCREEN)" ]
then
    xrandr --output $SCREEN --auto
else
    xrandr --output $SCREEN --off
fi
