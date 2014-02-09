#!/bin/sh

xsetroot -cursor_name left_ptr	# set the cursor icon
sh ~/.fehbg &			# set the bg image

setxkbmap -layout colemak	# set the keyboard layout

xrdb -merge ~/.Xresources	# get urxvt to read .Xresources
xbindkeys &			# bind keys
xset -b				# disable the system beep
xmobar &

exec xmonad			# start xmonad
