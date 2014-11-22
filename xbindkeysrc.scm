###########################
# xbindkeys configuration #
###########################
#
# Version: 0.1.3
#
# If you edit this, do not forget to uncomment any lines that you change.
# The pound(#) symbol may be used anywhere for comments.
#
# A list of keys is in /usr/include/X11/keysym.h and in
# /usr/include/X11/keysymdef.h 
# The XK_ is not needed. 
#
# List of modifier (on my keyboard): 
#   Control, Shift, Mod1 (Alt), Mod2 (NumLock), 
#   Mod3 (CapsLock), Mod4, Mod5 (Scroll). 
#
# Another way to specifie a key is to use 'xev' and set the 
# keycode with c:nnn or the modifier with m:nnn where nnn is 
# the keycode or the state returned by xev 
#
# This file is created by xbindkey_config 
# The structure is : 
# # Remark 
# "command" 
# m:xxx + c:xxx 
# Shift+... 




#keystate_numlock = enable
#keystate_scrolllock = enable
#keystate_capslock = enable



#Volume Up
"amixer set Master 2dB+ unmute"
    m:0x0 + c:123
    XF86AudioRaiseVolume 

#Volume Down
"amixer set Master 2dB- unmute"
    m:0x0 + c:122
    XF86AudioLowerVolume 

#LockScreen
"slock"
    m:0x0 + c:198
    XF86AudioMicMute 

#Chrome
"google-chrome-beta &"
    m:0x0 + c:156
    XF86Launch1 

#Max Brightness
"xbacklight -set 80"
    m:0x0 + c:233
    XF86MonBrightnessUp 

#Min Brightness
"xbacklight -set 1"
    m:0x0 + c:232
    XF86MonBrightnessDown 

#Mild Brightness adjust.
"xbacklight -inc 10"
    m:0x4 + c:233
    Control + XF86MonBrightnessUp 

#Mild Brightness adjust2
"xbacklight -dec 10"
    m:0x4 + c:232
    Control + XF86MonBrightnessDown 

#Screenshot
"scrot /home/wmak/.screenshot.png && imgur /home/wmak/.screenshot.png"
    m:0xc + c:12
    Control+Alt + 3 

#Select Screenshot
"sleep 0.5 && scrot -s /home/wmak/.screenshot.png && imgur /home/wmak/.screenshot.png"
    m:0xc + c:10
    Control+Alt + 1 

#Screenshot Window
"scrot -u /home/wmak/.screenshot.png && imgur /home/wmak/.screenshot.png"
    m:0xc + c:11
    Control+Alt + 2 

#
# End of xbindkeys configuration
