import XMonad
import Data.Monoid
import System.Exit
import XMonad.Actions.FloatKeys
import XMonad.Actions.FloatSnap
import XMonad.Hooks.Minimize
import XMonad.Layout.Maximize
import XMonad.Layout.Minimize
import Graphics.X11.ExtraTypes.XF86
import XMonad.Config.Desktop
import XMonad.Hooks.DynamicLog
import XMonad.Layout.Spacing
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers
import XMonad.Util.Cursor
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.Place
import XMonad.Util.SpawnOnce
import XMonad.Util.EZConfig
import XMonad.Hooks.EwmhDesktops
import XMonad.Actions.DynamicWorkspaces
import System.IO
import XMonad.Actions.Navigation2D
import XMonad.Layout.BinarySpacePartition
import qualified XMonad.StackSet as W
import qualified Data.Map        as M
import qualified DBus as D
import qualified DBus.Client as D
import qualified Codec.Binary.UTF8.String as UTF8

myTerminal = "st"
fg         = "#ebdbb2"
bg         = "#282828"
gray       = "#a89984"
bg1        = "#3c3836"
bg2        = "#505050"
bg3        = "#665c54"
bg4        = "#7c6f64"

green      = "#b8bb26"
darkgreen  = "#98971a"
red        = "#fb4934"
darkred    = "#cc241d"
yellow     = "#fabd2f"
blue       = "#83a598"
purple     = "#d3869b"
aqua       = "#8ec07c"
white      = "#eeeeee"

pur2       = "#5b51c9"
blue2      = "#2266d0"

-- Whether focus follows the mouse pointer.
myFocusFollowsMouse :: Bool
myFocusFollowsMouse = True
-- Whether clicking on a window to focus also passes the click to the window
myClickJustFocuses :: Bool
myClickJustFocuses = False

-- Width of the window border in pixels.
myBorderWidth   = 1

-- modMask lets you specify which modkey you want to use. The default
-- is mod1Mask ("left alt").  You may also consider using mod3Mask
-- ("right alt"), which does not conflict with emacs keybindings. The
-- "windows key" is usually mod4Mask.
--
myModMask       = mod4Mask

-- The default number of workspaces (virtual screens) and their names.
-- By default we use numeric strings, but any string may be used as a
-- workspace name. The number of workspaces is determined by the length
-- of this list.
--
-- A tagging example:
--
-- > workspaces = ["web", "irc", "code" ] ++ map show [4..9]
--
myWorkspaces    = ["1","2","3","4","5","6","7","8","9"]

-- Border colors for unfocused and focused windows, respectively.
myNormalBorderColor  = "#dddddd"
myFocusedBorderColor = "#ff0000"

------------------------------------------------------------------------
-- Key bindings. Add, modify or remove key bindings here.
myKeys conf@(XConfig {XMonad.modMask = modm}) = M.fromList $

    -- launch a terminal
    [ ((modm .|. shiftMask, xK_Return), spawn $ XMonad.terminal conf)

    -- launch rofi
    , ((controlMask,               xK_p     ), spawn "rofi -show drun")

    -- BSP
    , ((controlMask,               xK_g     ), sendMessage            Rotate)
    , ((controlMask,               xK_b     ), sendMessage            $ Swap)
    , ((shiftMask .|. controlMask, xK_n     ), sendMessage        SelectNode)
    , ((mod1Mask  .|. controlMask, xK_n     ), sendMessage          MoveNode)
    , ((shiftMask .|. controlMask, xK_v     ), sendMessage $ SplitShift Prev)
    , ((shiftMask .|. controlMask, xK_b     ), sendMessage $ SplitShift Next)
    , ((shiftMask .|. controlMask, xK_z     ), withFocused (sendMessage . maximizeRestore))
    -- no clue how these work, will revisit
    -- , ((myModMask,                 xK_Escape),     sendMessage Balance)
    -- , ((myModMask .|. shiftMask,   xK_Escape),     sendMessage Equalize)

    -- close focused window
    , ((modm .|. shiftMask,        xK_c     ),                          kill)

    -- Rotate through the available layout algorithms
    , ((modm,               xK_space ), sendMessage NextLayout)

    --  Reset the layouts on the current workspace to default
    , ((modm .|. shiftMask, xK_space ), setLayout $ XMonad.layoutHook conf)

    -- Resize viewed windows to the correct size
    , ((modm,               xK_n     ), refresh)

    -- Navigation2d
    , ((controlMask,                 xK_l), windowGo R False)
    , ((controlMask,                 xK_h ), windowGo L False)
    , ((controlMask,                 xK_k   ), windowGo U False)
    , ((controlMask,                 xK_j ), windowGo D False)

    -- Swap adjacent windows
    , ((shiftMask .|. controlMask, xK_l ), windowSwap R True)
    , ((shiftMask .|. controlMask, xK_h ), windowSwap L True)
    , ((shiftMask .|. controlMask, xK_k ), windowSwap U True)
    , ((shiftMask .|. controlMask, xK_j ), windowSwap D True)

     -- Quit xmonad
     , ((modm .|. shiftMask, xK_q     ), io (exitWith ExitSuccess))

     -- Restart xmonad
     , ((modm              , xK_q     ), spawn "xmonad --recompile; xmonad --restart")

    ]
    ++
    --
    -- ctrl-[1..9], Switch to workspace N
    -- ctrl-shift-[1..9], Move client to workspace N
    --
    [((m .|. controlMask, k), windows $ f i)
        | (i, k) <- zip (XMonad.workspaces conf) [xK_1 .. xK_9]
        , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]]

myNavigation2DConfig = def { layoutNavigation   = [("Spacing Maximize BSP", centerNavigation)] }
------------------------------------------------------------------------
-- Mouse bindings: default actions bound to mouse events
--
myMouseBindings (XConfig {XMonad.modMask = modm}) = M.fromList $

    -- mod-button1, Set the window to floating mode and move by dragging
    [ ((modm, button1), (\w -> focus w >> mouseMoveWindow w
                                       >> windows W.shiftMaster))

    -- mod-button2, Raise the window to the top of the stack
    , ((modm, button2), (\w -> focus w >> windows W.shiftMaster))

    -- mod-button3, Set the window to floating mode and resize by dragging
    , ((modm, button3), (\w -> focus w >> mouseResizeWindow w
                                       >> windows W.shiftMaster))

    -- you may also bind events to the mouse scroll wheel (button4 and button5)
    ]

------------------------------------------------------------------------
-- Layouts:

-- You can specify and transform your layouts by modifying these values.
-- If you change layout bindings be sure to use 'mod-shift-space' after
-- restarting (with 'mod-q') to reset your layout state to the new
-- defaults, as xmonad preserves your old layout settings by default.
--
-- The available layouts.  Note that each layout is separated by |||,
-- which denotes layout choice.
--
myLayout = avoidStruts (maximize (emptyBSP)) ||| avoidStruts (tiled)
  where
     -- default tiling algorithm partitions the screen into two panes
     tiled   = Tall nmaster delta ratio

     -- The default number of windows in the master pane
     nmaster = 1

     -- Default proportion of screen occupied by master pane
     ratio   = 1/2

     -- Percent of screen to increment by when resizing panes
     delta   = 3/100

------------------------------------------------------------------------
-- Window rules:

-- Execute arbitrary actions and WindowSet manipulations when managing
-- a new window. You can use this to, for example, always float a
-- particular program, or have a client always appear on a particular
-- workspace.
--
-- To find the property name associated with a program, use
-- > xprop | grep WM_CLASS
-- and click on the client you're interested in.
--
-- To match on the WM_NAME, you can use 'title' in the same way that
-- 'className' and 'resource' are used below.
--
myManageHook = composeAll
    [ className =? "MPlayer"        --> doFloat
    , className =? "Gimp"           --> doFloat
    , className =? "Navigator"      --> doFloat
    , resource  =? "desktop_window" --> doIgnore
    , resource  =? "kdesktop"       --> doIgnore ]

myManageHook' = composeOne [ isFullscreen -?> doFullFloat ]
------------------------------------------------------------------------
-- Event handling

-- * EwmhDesktops users should change this to ewmhDesktopsEventHook
--
-- Defines a custom handler function for X Events. The function should
-- return (All True) if the default handler is to be run afterwards. To
-- combine event hooks use mappend or mconcat from Data.Monoid.
--
myEventHook = ewmhDesktopsEventHook

------------------------------------------------------------------------
-- Status bars and logging

-- Perform an arbitrary action on each internal state change or X event.
-- See the 'XMonad.Hooks.DynamicLog' extension for examples.
--
myLogHook :: D.Client -> PP
myLogHook dbus = def
    { ppOutput = dbusOutput dbus
    , ppLayout = wrap ("%{F" ++ green ++ "} ") " %{F-}"
    , ppSep = " | "
    , ppOrder = \(_:l:_) -> [l]
    }

 -- Emit a DBus signal on log updates
dbusOutput :: D.Client -> String -> IO ()
dbusOutput dbus str = do
    let signal = (D.signal objectPath interfaceName memberName) {
            D.signalBody = [D.toVariant $ UTF8.decodeString str]
        }
    D.emit dbus signal
  where
    objectPath = D.objectPath_ "/org/xmonad/Log"
    interfaceName = D.interfaceName_ "org.xmonad.Log"
    memberName = D.memberName_ "Update"

myAddSpaces :: Int -> String -> String
myAddSpaces len str = sstr ++ replicate (len - length sstr) ' '
  where
    sstr = shorten len str
------------------------------------------------------------------------
-- Startup hook

-- Perform an arbitrary action each time xmonad starts or is restarted
-- with mod-q.  Used by, e.g., XMonad.Layout.PerWorkspace to initialize
-- per-workspace layout choices.
--
-- By default, do nothing.
myStartupHook = do
    setDefaultCursor xC_left_ptr
    spawnOnce "nitrogen --restore &"
    spawn "/home/arnamak/.config/polybar/init-polybar.sh"
    -- spawnOnce "picom -b --experimental-backends --config /home/arnamak/.config/picom/picom.conf"

------------------------------------------------------------------------
-- Command to launch the bar.
-- Key binding to toggle the gap for the bar.
toggleStrutsKey XConfig {XMonad.modMask = modMask} = (modMask, xK_b)

------------------------------------------------------------------------
-- Now run xmonad with all the defaults we set up.

-- Run xmonad with the settings you specify. No need to modify this.
--
-- main = xmonad . ewmh =<< defaults

-- A structure containing your configuration settings, overriding
-- fields in the default config. Any you don't override, will
-- use the defaults defined in xmonad/XMonad/Config.hs
--
main :: IO ()
main = do
  dbus <- D.connectSession
  D.requestName dbus (D.busName_ "org.xmonad.Log")
    [D.nameAllowReplacement, D.nameReplaceExisting, D.nameDoNotQueue]

  xmonad $ withNavigation2DConfig myNavigation2DConfig $ ewmh $ desktopConfig {
      -- simple stuff
        terminal           = myTerminal,
        focusFollowsMouse  = myFocusFollowsMouse,
        clickJustFocuses   = myClickJustFocuses,
        borderWidth        = myBorderWidth,
        modMask            = myModMask,
        workspaces         = myWorkspaces,
        normalBorderColor  = myNormalBorderColor,
        focusedBorderColor = myFocusedBorderColor,

      -- key bindings
        keys               = myKeys,
        mouseBindings      = myMouseBindings,

      -- hooks, layouts
        layoutHook         = spacingRaw True (Border 0 10 10 10) True (Border 10 10 10 10) True $ myLayout,
        manageHook         = placeHook (smart (0.5, 0.5))
                            <+> manageDocks
                            <+> myManageHook
                            <+> myManageHook'
                            <+> manageHook def,
        handleEventHook    = docksEventHook <+> minimizeEventHook <+> fullscreenEventHook <+> myEventHook,
        logHook            = dynamicLogWithPP (myLogHook dbus),
        startupHook        = myStartupHook
    }

-- | Finally, a copy of the default bindings in simple textual tabular format.
help :: String
help = unlines ["The default modifier key is 'alt'. Default keybindings:",
    "",
    "-- launching and killing programs",
    "mod-Shift-Enter  Launch terminal",
    "mod-p            Launch rofi",
    "mod-Shift-c      Close/kill the focused window",
    "mod-Space        Rotate through the available layout algorithms",
    "mod-Shift-Space  Reset the layouts on the current workSpace to default",
    "mod-n            Resize/refresh viewed windows to the correct size",
    "",
    "-- move focus up or down the window stack",
    "mod-Tab        Move focus to the next window",
    "mod-Shift-Tab  Move focus to the previous window",
    "ctrl-h         Move focus to the next window left",
    "ctrl-l          Move focus to the previous window right",
    "ctrl-j         Move focus to the next window down",
    "ctrl-k          Move focus to the previous window up",
    "",
    "-- increase or decrease number of windows in the master area",
    "mod-comma  (mod-,)   Increment the number of windows in the master area",
    "mod-period (mod-.)   Deincrement the number of windows in the master area",
    "",
    "-- quit, or restart",
    "mod-Shift-q  Quit xmonad",
    "mod-q        Restart xmonad",
    "ctrl-[1..9]   Switch to workSpace N",
    "",
    "-- Workspaces & screens",
    "ctrl-Shift-[1..9]   Move client to workspace N",
    "",
    "-- Mouse bindings: default actions bound to mouse events",
    "mod-button1  Set the window to floating mode and move by dragging",
    "mod-button2  Raise the window to the top of the stack",
    "mod-button3  Set the window to floating mode and resize by dragging"]
