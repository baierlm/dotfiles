# COLORS FOR THE BAR

from libqtile import widget
import arcobattery
import arcomemory
import os

home = os.path.expanduser('~')

def init_colors():
    return [["#2F343F", "#2F343F"],  # color 0
            ["#2F343F", "#2F343F"],  # color 1
            ["#c0c5ce", "#c0c5ce"],  # color 2
            ["#fba922", "#fba922"],  # color 3
            ["#3384d0", "#3384d0"],  # color 4
            ["#f3f4f5", "#f3f4f5"],  # color 5
            ["#cd1f3f", "#cd1f3f"],  # color 6
            ["#62FF00", "#62FF00"],  # color 7
            ["#6790eb", "#6790eb"],  # color 8
            ["#a9a9a9", "#a9a9a9"]]  # color 9

def gruvbox():
    return [['#282828','#282828'],    # color 0
            ['#282828','#282828'],    # color 1
            ['#282828','#282828'],    # color 2
            ['#fabd2f','#fabd2f'],    # color 3
            ['#83a598','#83a598'],    # color 4
            ['#d5c4a1','#d5c4a1'],    # color 5
            ['#8ec07c','#8ec07c'],    # color 6
            ['#d5c4a1','#d5c4a1'],    # color 7
            ['#665c54','#665c54'],    # color 8
            ['#fb4934','#fb4934']]    # color 9


colors = gruvbox();


# WIDGETS FOR THE BAR

def init_widgets_list():
    return [
        widget.CurrentLayoutIcon(
            font="Noto Sans Bold",
            foreground=colors[5],
            background=colors[1]
        ),
        widget.GroupBox(font="FontAwesome",
                        fontsize=16,
                        margin_y=-1,
                        margin_x=0,
                        padding_y=6,
                        padding_x=5,
                        borderwidth=0,
                        disable_drag=True,
                        active=colors[9],
                        inactive=colors[5],
                        rounded=False,
                        highlight_method="line",
                        this_current_screen_border=colors[8],
                        foreground=colors[2],
                        background=colors[1],
                        hide_unused=True,
                        markup=True
                        ),
        widget.WindowName(font="Noto Sans",
                          fontsize=12,
                          foreground=colors[5],
                          background=colors[1],
                          ),
        # Using the Notify widget will disable other notification services
        arcomemory.Memory(
            font="Noto Sans",
            fmt='{MemUsed}/{MemTotal}M',
            update_interval=1,
            fontsize=12,
            foreground=colors[5],
            background=colors[1],
        ),
        # battery option 1 or ArcoLinux Horizontal icons by default
        arcobattery.BatteryIcon(
            padding=0,
            scale=0.6,
            y_poss=3,
            theme_path=home + "/.config/qtile/icons/battery_icons_horiz",
            update_interval=5,
            background=colors[1]
        ),

       widget.Clock(
            foreground=colors[5],
            background=colors[1],
            fontsize=12,
            format="%d.%m.%Y  %H:%M"
        ),
            ]


def init_main_widgets_list():
    widget_list = init_widgets_list()
    widget_list.extend([
        widget.Systray(
            background=colors[1],
            icon_size=20,
            padding=4
        )])
    return widget_list

