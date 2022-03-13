!/bin/bash

# Reverse left-right mouse button
current=$(xmodmap -pp | head -5 | tail -1 | awk '{print $2}');
if [ "$current" -eq "1" ]
then
    xmodmap -e "pointer = 3 2 1";
else
    xmodmap -e "pointer = 1 2 3";
fi
