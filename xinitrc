#!/bin/sh

xsetroot -cursor_name left_ptr	# set the cursor icon
sh ~/.fehbg &			# set the bg image

setxkbmap -layout colemak	# set the keyboard layout
xset s noblank

xrdb -merge ~/.Xresources	# get urxvt to read .Xresources
xbindkeys &			# bind keys
xset -b				# disable the system beep
xmobar &			# start xmobar
google-chrome-stable & # run google chrome
urxvt -T Terminal & # run a terminal

exec xmonad			# start xmonad

