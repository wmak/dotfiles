import XMonad
import XMonad.Hooks.ManageDocks
import qualified XMonad.StackSet as W
import qualified Data.Map as M
import XMonad.Prompt
import XMonad.Prompt.Shell
import XMonad.Prompt.XMonad

myTerminal	= "urxvt"
myModMask	= mod4Mask -- Win key or Super_L
-- border settings
myBorderWidth	= 3
normalColor	= "#4CB09C"
focusedColor	= "#F04C16"
-- make room for xmobar
myLayout	= avoidStruts $ layoutHook defaultConfig
myManageHook	= manageDocks <+> manageHook defaultConfig
-- create colemak keybindings
myKeys		 conf@(XConfig {XMonad.modMask = modm}) = M.fromList 
		-- Move focus to the next window
		[ ((modm, xK_e), windows W.focusDown)
		-- Move focus to the previous window
		, ((modm, xK_i), windows W.focusUp)
		-- Start program launcher
		, ((modm, xK_r), spawn "dmenu_run")
		-- Swap the focused window with the next window
		, ((modm .|. shiftMask, xK_e), windows W.swapDown)
		-- Swap the focused window with the previous window
		, ((modm .|. shiftMask, xK_i), windows W.swapUp)
		-- Expand the master area
		, ((modm, xK_o), sendMessage Expand)
		-- Shrink the master area
		, ((modm, xK_n), sendMessage Shrink)
		]

main = xmonad $ defaultConfig
	{ terminal    		= myTerminal
	, modMask     		= myModMask
	, borderWidth 		= myBorderWidth
	, normalBorderColor 	= normalColor
	, focusedBorderColor	= focusedColor
	, layoutHook		= myLayout
	, manageHook		= myManageHook
	, keys			= myKeys <+> keys defaultConfig
	}

