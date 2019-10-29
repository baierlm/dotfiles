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


colors = init_colors()


# WIDGETS FOR THE BAR

def init_widgets_list():
    return [
        widget.CurrentLayoutIcon(
            font="Noto Sans Bold",
            foreground=colors[5],
            background=colors[1]
        ),
        widget.Sep(
            linewidth=1,
            padding=10,
            foreground=colors[2],
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

        widget.Sep(
            linewidth=1,
            padding=10,
            foreground=colors[2],
            background=colors[1]
        ),
        widget.WindowName(font="Noto Sans",
                          fontsize=12,
                          foreground=colors[5],
                          background=colors[1],
                          ),
        # Using the Notify widget will disable other notification services

        widget.CPUGraph(
            border_color=colors[2],
            fill_color=colors[8],
            graph_color=colors[8],
            background=colors[1],
            border_width=0,
            line_width=1,
            core="all",
            type="box"
        ),
        widget.Sep(
            linewidth=1,
            padding=10,
            foreground=colors[2],
            background=colors[1]
        ),
        # widget.TextBox(
        #         font="FontAwesome",
        #         text="  ",
        #         foreground=colors[4],
        #         background=colors[1],
        #         padding = 0,
        #         fontsize=16
        #         ),
        arcomemory.Memory(
            font="Noto Sans",
            fmt='{MemUsed}/{MemTotal}M',
            update_interval=1,
            fontsize=12,
            foreground=colors[5],
            background=colors[1],
        ),
        # battery option 1  or ArcoLinux Horizontal icons by default
        widget.Sep(
            linewidth=1,
            padding=10,
            foreground=colors[2],
            background=colors[1]
        ),
        arcobattery.BatteryIcon(
            padding=0,
            scale=0.6,
            y_poss=3,
            theme_path=home + "/.config/qtile/icons/battery_icons_horiz",
            update_interval=5,
            background=colors[1]
        ),
        widget.Sep(
            linewidth=1,
            padding=10,
            foreground=colors[2],
            background=colors[1]
        ),
        widget.TextBox(
            font="FontAwesome",
            text="  ",
            foreground=colors[3],
            background=colors[1],
            padding=0,
            fontsize=16
        ),
        widget.Clock(
            foreground=colors[5],
            background=colors[1],
            fontsize=12,
            format="%Y-%m-%d %H:%M"
        ),
        widget.Sep(
            linewidth=1,
            padding=10,
            foreground=colors[2],
            background=colors[1]
        ),
        widget.Systray(
            background=colors[1],
            icon_size=20,
            padding=4
        ),
    ]