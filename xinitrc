#!/bin/sh
xrdb -load ~/.Xresources &
source ~/.bash_profile &
~/statusbar.sh &
# Set the desktop background
feh --bg-scale /home/abuser/Pictures/wallYES.jpg &

# Start system tray applications
picom &
nmcli radio wifi on &
xbindkeys &
numlockx on &
~/.config/autostart-scripts/start-nm-applet.sh &
export PATH="$PATH:/usr/bin:$HOME/scripts" &
killall trayer; trayer --edge top --align right --SetDockType true --SetPartialStrut true --expand true --widthtype percent --width 10 --transparent true --tint 0x000000 --height 20 --distance 80 --distancefrom top --margin 30 &
nm-applet &

# Execute dwm
# spotify &> /dev/null &
# discord &> /dev/null &
# steam -silent &> /dev/null &
exec dwm 
