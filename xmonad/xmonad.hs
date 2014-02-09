 import XMonad
 import XMonad.Hooks.DynamicLog

 main = xmonad =<< statusBar myBar myPP toggleStrutsKey myConfig

 myBar = "xmobar"

 -- Custom PP, configure it as you like. It determines what is being written to the bar.
 myPP = xmobarPP { 
	ppCurrent = xmobarColor "#429942" "" . wrap "<" ">" 
     }

 -- Key binding to toggle the gap for the bar.
 toggleStrutsKey XConfig {XMonad.modMask = modMask} = (modMask, xK_b)

 myConfig = defaultConfig
     { terminal    = myTerminal
     , modMask     = myModMask
     , borderWidth = myBorderWidth
     }

 -- yes, these are functions; just very simple ones
 -- that accept no input and return static values
 myTerminal    = "urxvt"
 myModMask     = mod4Mask -- Win key or Super_L
 myBorderWidth = 3
