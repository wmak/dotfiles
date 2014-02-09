import XMonad
import XMonad.Hooks.ManageDocks
import qualified XMonad.StackSet as W
import qualified Data.Map as M
import XMonad.Prompt
import XMonad.Prompt.Shell
import XMonad.Prompt.XMonad

main = xmonad $ defaultConfig
	{ terminal    		= myTerminal
	, modMask     		= myModMask
	, borderWidth 		= myBorderWidth
	, normalBorderColor 	= "#4CB09C"
	, focusedBorderColor	= "#F04C16"
	, layoutHook		= myLayout
	, manageHook		= myManageHook
	, keys			= myKeys <+> keys defaultConfig
	}

-- yes, these are functions; just very simple ones
-- that accept no input and return static values
myTerminal	= "urxvt"
myModMask	= mod4Mask -- Win key or Super_L
myBorderWidth	= 3
myLayout	= avoidStruts $ layoutHook defaultConfig
myManageHook	= manageDocks <+> manageHook defaultConfig
myKeys		 conf@(XConfig {XMonad.modMask = modm}) = M.fromList 
		-- Move focus to the next window
		[ ((modm, xK_n), windows W.focusDown)
		-- Move focus to the previous window
		, ((modm, xK_e), windows W.focusUp)
		-- Start program launcher
		, ((modm, xK_t), spawn "dmenu_run")
		-- Swap the focused window with the next window
		, ((modm .|. shiftMask, xK_n), windows W.swapDown)
		-- Swap the focused window with the previous window
		, ((modm .|. shiftMask, xK_e), windows W.swapUp)
		-- Expand the master area
		, ((modm, xK_i), sendMessage Expand)
		]
