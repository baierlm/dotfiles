import os
import socket
import subprocess
from libqtile.config import ScratchPad, DropDown, Drag, Key, Screen, Group, Drag, Click, Rule
from libqtile.command import lazy, Client
from libqtile import layout, bar, widget, hook
from widgets import init_widgets_list, init_main_widgets_list
from keys import init_keys


# mod4 or mod = super key
mod = "mod4"
mod1 = "alt"
mod2 = "control"
home = os.path.expanduser('~')


@lazy.function
def window_to_prev_group(qtile):
    if qtile.currentWindow is not None:
        i = qtile.groups.index(qtile.currentGroup)
        qtile.currentWindow.togroup(qtile.groups[i - 1].name)


@lazy.function
def window_to_next_group(qtile):
    if qtile.currentWindow is not None:
        i = qtile.groups.index(qtile.currentGroup)
        qtile.currentWindow.togroup(qtile.groups[i + 1].name)


def temp():
    subprocess.Popen(['python', home + '/.config/qtile/group_setups.py'])

keys = init_keys()

group_names = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "0", ]

group_labels = group_names

group_layouts = ["monadtall", "monadtall", "monadtall", "monadtall", "monadtall", "monadtall", "monadtall", "monadtall",
                 "monadtall", "monadtall", ]
groups = []


for i in range(len(group_names)):
    groups.append(
        Group(
            name=group_names[i],
            layout=group_layouts[i].lower(),
            label=group_labels[i],

        ))

for group in groups:
    keys.extend([
        # CHANGE WORKSPACES
        Key([mod], group.name, lazy.group[group.name].toscreen()),
        Key([mod], "Tab", lazy.screen.next_group()),
        Key(["mod1"], "Tab", lazy.screen.next_group()),
        Key(["mod1", "shift"], "Tab", lazy.screen.prev_group()),

        # MOVE WINDOW TO SELECTED WORKSPACE 1-10 AND STAY ON WORKSPACE
        Key([mod, "shift"], group.name, lazy.window.togroup(group.name)),
        # MOVE WINDOW TO SELECTED WORKSPACE 1-10 AND FOLLOW MOVED WINDOW TO WORKSPACE
        #Key([mod, "shift"], group.name, lazy.window.togroup(
        #    group.name), lazy.group[group.name].toscreen()),
    ])

groups.extend([ScratchPad("scratchpad", [
    # define a drop down terminal.
    DropDown("term", "termite --config=" + home + "/.config/termite/config-no-trans", height=0.55, opacity=1),

    # define another terminal exclusively for qshell at different position
    DropDown("qshell", "termite --hold -e qshell",
             x=0.05, y=0.4, width=0.9, height=0.6, opacity=0.9,
             on_focus_lost_hide=True)]),
               ])


def init_layout_theme():
    return {"margin": 0,
            "border_width": 0,
            "border_focus": "#5e81ac",
            "border_normal": "#4c566a"
            }


layout_theme = init_layout_theme()

layouts = [
    layout.MonadTall(**layout_theme),
    layout.MonadWide(**layout_theme),
    layout.Matrix(**layout_theme),
    layout.Zoomy(**layout_theme),
]


def init_screens():
    return [Screen(top=bar.Bar(widgets=init_main_widgets_list(), size=20)),
            Screen(top=bar.Bar(widgets=init_widgets_list(), size=20))]


screens = init_screens()

# MOUSE CONFIGURATION
mouse = [
    Drag([mod], "Button1", lazy.window.set_position_floating(),
         start=lazy.window.get_position()),
    Drag([mod], "Button3", lazy.window.set_size_floating(),
         start=lazy.window.get_size())
]

dgroups_key_binder = None

dgroups_app_rules = []

main = None

def single_window(layout):
    layout.margin = 0
    layout.border_width = 0
    
def multiple_windows(layout):
    layout.margin = 8
    layout.border_width = 1

# Startup hooks
@hook.subscribe.startup_once
def start_once():
    subprocess.call([home + '/.config/qtile/scripts/autostart.sh'])


@hook.subscribe.startup
def start_always():
    # Set the cursor to something sane in X
    subprocess.Popen(['xsetroot', '-cursor_name', 'left_ptr'])


# Screen change hooks
@hook.subscribe.screen_change
def screen_change(qtile, env):
    qtile.cmd_restart()


# Client hooks
@hook.subscribe.client_new
def set_floating(window):
    if (window.window.get_wm_transient_for()
            or window.window.get_wm_type() in floating_types):
        window.floating = True


@hook.subscribe.client_managed
def client_managed(window):
    # subprocess.Popen(['notify-send', '-u', 'critical', str(window.group.layout)])
    if len(window.group.info()['windows']) > 1:
        multiple_windows(window.group.layout) 


@hook.subscribe.client_killed
def client_killed(window):
    # the deleted client will still be in window in the info
    if len(window.group.info()['windows']) <= 2:
        single_window(window.group.layout)


# Layout change hooks
@hook.subscribe.layout_change
def layout_change(layout, group):
    if len(group.info()['windows']) <= 1:
        single_window(layout)
    else:
        multiple_windows(layout)


floating_types = ["notification", "toolbar", "splash", "dialog"]

follow_mouse_focus = True
bring_front_click = False
cursor_warp = False
floating_layout = layout.Floating(float_rules=[
    {'wmclass': 'confirm'},
    {'wmclass': 'dialog'},
    {'wmclass': 'download'},
    {'wmclass': 'error'},
    {'wmclass': 'file_progress'},
    {'wmclass': 'notification'},
    {'wmclass': 'splash'},
    {'wmclass': 'toolbar'},
    {'wmclass': 'confirmreset'},
    {'wmclass': 'makebranch'},
    {'wmclass': 'maketag'},
    {'wmclass': 'Arandr'},
    {'wmclass': 'feh'},
    {'wmclass': 'Galculator'},
    {'wmclass': 'Oblogout'},
    {'wname': 'branchdialog'},
    {'wname': 'Open File'},
    {'wname': 'pinentry'},
    {'wmclass': 'ssh-askpass'},

], fullscreen_border_width=0, border_width=0)
auto_fullscreen = True
focus_on_window_activation = "smart"

wmname = "LG3D"
