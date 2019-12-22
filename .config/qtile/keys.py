import os
import subprocess
from libqtile.config import Key
from libqtile.command import lazy

mod = "mod4"
mod1 = "alt"
mod2 = "control"
home = os.path.expanduser('~')

def init_keys():
    return [

        # SUPER + FUNCTION KEYS
        # Key([mod, 'shift'], "t", subprocess.Popen(['notify-send', os.environ['HOME']])),
        # Key([mod], "t", lazy.group["scratchpad"].dropdown_toggle("qshell")),
        Key([mod], "t", lazy.group["scratchpad"].dropdown_toggle("term"), desc='Dropdown Terminal'),
        Key([mod], "Print", lazy.spawn('gnome-screenshot -i'), desc='Screenshot'),
        Key([mod], "f", lazy.spawn('firefox'), desc='Firefox'),
        Key([mod], "d", lazy.spawn('rofi -show run'), desc='Rofi'),
        Key([mod], "q", lazy.window.kill(), desc='Kill Window'),
        Key([mod], "x", lazy.spawn('oblogout'), desc='Oblogout'),
        Key([mod], "Return", lazy.spawn('termite -e "tmux -f /home/mark/.config/tmux/tmux.conf"'), desc='Termite'),
        #Key([mod], "s", lazy.run_external(home + '/.config/qtile/group_setups.py'), desc='Dropdown Terminal'),

        # SUPER + SHIFT KEYS
        Key([mod, "shift"], "l", subprocess.call([home + '/.screenlayout/auto.sh'])),
        Key([mod, "shift"], "p", lazy.spawn('rofi-pass'), desc='Rofi Pass'),
        Key([mod, "shift"], "f", lazy.window.toggle_fullscreen(), desc='Fullscreen'),
        Key([mod, "shift"], "q", lazy.window.kill(), desc='Kill Window'),
        Key([mod, "shift"], "r", lazy.restart(), desc='Reload Qtile'),
        Key([mod, "shift"], "x", lazy.shutdown(), desc='Kill Qtile'),

        Key([mod, "shift"], "Return", lazy.spawn('termite'), desc='Termite'),
        # CONTROL + ALT KEYS

        # ALT + ... KEYS

        # CONTROL + SHIFT KEYS
        Key([mod2, "shift"], "Escape", lazy.spawn('xfce4-taskmanager')),

        # INCREASE/DECREASE BRIGHTNESS
        Key([], "XF86MonBrightnessUp", lazy.spawn("xbacklight -inc 10")),
        Key([], "XF86MonBrightnessDown", lazy.spawn("xbacklight -dec 10")),

        # INCREASE/DECREASE/MUTE VOLUME
        Key([], "XF86AudioMute", lazy.spawn("amixer -q set Master toggle")),
        Key([], "XF86AudioLowerVolume", lazy.spawn("amixer -q set Master 5%-")),
        Key([], "XF86AudioRaiseVolume", lazy.spawn("amixer -q set Master 5%+")),

        # QTILE LAYOUT KEYS
        Key([mod], "n", lazy.layout.normalize()),
        Key([mod], "space", lazy.next_layout()),

        # CHANGE FOCUS
        Key([mod], "Up", lazy.layout.up()),
        Key([mod], "Down", lazy.layout.down()),
        Key([mod], "Left", lazy.layout.left()),
        Key([mod], "Right", lazy.layout.right()),
        Key([mod], "k", lazy.layout.up()),
        Key([mod], "j", lazy.layout.down()),
        Key([mod], "h", lazy.layout.left()),
        Key([mod], "l", lazy.layout.right()),

        # RESIZE UP, DOWN, LEFT, RIGHT
        Key([mod, "control"], "l",
            lazy.layout.grow_right(),
            lazy.layout.grow(),
            lazy.layout.increase_ratio(),
            lazy.layout.delete(),
            ),
        Key([mod, "control"], "Right",
            lazy.layout.grow_right(),
            lazy.layout.grow(),
            lazy.layout.increase_ratio(),
            lazy.layout.delete(),
            ),
        Key([mod, "control"], "h",
            lazy.layout.grow_left(),
            lazy.layout.shrink(),
            lazy.layout.decrease_ratio(),
            lazy.layout.add(),
            ),
        Key([mod, "control"], "Left",
            lazy.layout.grow_left(),
            lazy.layout.shrink(),
            lazy.layout.decrease_ratio(),
            lazy.layout.add(),
            ),
        Key([mod, "control"], "k",
            lazy.layout.grow_up(),
            lazy.layout.grow(),
            lazy.layout.decrease_nmaster(),
            ),
        Key([mod, "control"], "Up",
            lazy.layout.grow_up(),
            lazy.layout.grow(),
            lazy.layout.decrease_nmaster(),
            ),
        Key([mod, "control"], "j",
            lazy.layout.grow_down(),
            lazy.layout.shrink(),
            lazy.layout.increase_nmaster(),
            ),
        Key([mod, "control"], "Down",
            lazy.layout.grow_down(),
            lazy.layout.shrink(),
            lazy.layout.increase_nmaster(),
            ),

        # FLIP LAYOUT FOR MONADTALL/MONADWIDE
        Key([mod, "shift"], "f", lazy.layout.flip()),

        # FLIP LAYOUT FOR BSP
        Key([mod, "mod1"], "k", lazy.layout.flip_up()),
        Key([mod, "mod1"], "j", lazy.layout.flip_down()),
        Key([mod, "mod1"], "l", lazy.layout.flip_right()),
        Key([mod, "mod1"], "h", lazy.layout.flip_left()),

        # MOVE WINDOWS UP OR DOWN BSP LAYOUT
        Key([mod, "shift"], "k", lazy.layout.shuffle_up()),
        Key([mod, "shift"], "j", lazy.layout.shuffle_down()),
        Key([mod, "shift"], "h", lazy.layout.shuffle_left()),
        Key([mod, "shift"], "l", lazy.layout.shuffle_right()),

        # MOVE WINDOWS UP OR DOWN MONADTALL/MONADWIDE LAYOUT
        Key([mod, "shift"], "Up", lazy.layout.shuffle_up()),
        Key([mod, "shift"], "Down", lazy.layout.shuffle_down()),
        Key([mod, "shift"], "Left", lazy.layout.swap_left()),
        Key([mod, "shift"], "Right", lazy.layout.swap_right()),

        # TOGGLE FLOATING LAYOUT
        Key([mod, "shift"], "space", lazy.window.toggle_floating()), ]
