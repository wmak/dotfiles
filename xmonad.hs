import XMonad
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.InsertPosition
import qualified XMonad.StackSet as W
import qualified Data.Map as M
import XMonad.Prompt
import XMonad.Prompt.Shell
import XMonad.Prompt.XMonad
import XMonad.Layout.Spacing -- Add padding
import XMonad.Layout.NoBorders(smartBorders)
import XMonad.Layout.ResizableTile

myTerminal = "urxvt"
myModMask = mod4Mask -- Win key or Super_L
-- border settings
myBorderWidth = 2
normalColor = "#212121"
focusedColor = "#E91E63"
-- make room for xmobar
myLayout = avoidStruts 
	$ theLayout
	where
		theLayout = tiled ||| mirrortiled ||| fullscreen
		tiled		= spacing 5 $ ResizableTall 1 (2/100) (1/2) []
		mirrortiled	= Mirror $ spacing 2 $ ResizableTall 2 (2/100) (3/4) []
		fullscreen	= spacing 0 $ smartBorders $ Full
		nmaster		= 1
		ratio		= 1/2
		delta		= 2/100

myManageHook = insertPosition End Newer <+> manageDocks 
	<+> manageHook defaultConfig
-- setup workspaces
myWorkspaces = ["main", "work", "msg"] ++ map show [4..9]
-- create colemak keybindings
myKeys conf@(XConfig {XMonad.modMask = modm}) = M.fromList 
		-- Move focus to the next window
		[ ((modm, xK_e), windows W.focusDown)
		-- Move focus to the previous window
		, ((modm, xK_i), windows W.focusUp)
		-- Swap the focused window with the next window
		, ((modm .|. shiftMask, xK_e), windows W.swapDown)
		-- Swap the focused window with the previous window
		, ((modm .|. shiftMask, xK_i), windows W.swapUp)
		-- Expand the master area
		, ((modm, xK_o), sendMessage Expand)
		-- Shrink the master area
		, ((modm, xK_n), sendMessage Shrink)
		-- Expand the height
		, ((modm, xK_u), sendMessage MirrorExpand)
		-- Shrink the height
		, ((modm, xK_y), sendMessage MirrorShrink)
		-- toggle gaps
		, ((modm, xK_b), sendMessage ToggleStruts)
		-- reset the layout
		, ((modm, xK_k), refresh)
		]

main = xmonad $ defaultConfig
	{ terminal = myTerminal
	, modMask = myModMask
	, borderWidth = myBorderWidth
	, normalBorderColor = normalColor
	, focusedBorderColor = focusedColor
	, layoutHook = myLayout
	, manageHook = myManageHook
	, keys = myKeys <+> keys defaultConfig
	}

