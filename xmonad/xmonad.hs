import XMonad
import XMonad.Hooks.ManageDocks

main = xmonad $ defaultConfig
	{ terminal    		= myTerminal
	, modMask     		= myModMask
	, borderWidth 		= myBorderWidth
	, normalBorderColor 	= "#4CB09C"
	, focusedBorderColor	= "#F04C16"
	, layoutHook		= myLayout
	, manageHook		= myManageHook
	}

-- yes, these are functions; just very simple ones
-- that accept no input and return static values
myTerminal    = "urxvt"
myModMask     = mod4Mask -- Win key or Super_L
myBorderWidth = 3
myLayout = avoidStruts $ layoutHook defaultConfig
myManageHook = manageDocks <+> manageHook defaultConfig
