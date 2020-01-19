-- index
    --Theme
    --Constants
    --Layouts
    --Menu
    --Widget bar
    --Tags
    --Screens
    --Mouse bindings
    --Key bindings
    --Rules
    --Signals

pcall(require, "luarocks.loader")

local sharedtags = require("awesome-sharedtags")

-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
require("awful.autofocus")
-- Widget and layout library
local wibox = require("wibox")
-- Theme handling library
local beautiful = require("beautiful")
-- Notification library
local naughty = require("naughty")
local menubar = require("menubar")
local hotkeys_popup = require("awful.hotkeys_popup")
-- Enable hotkeys help widget for VIM and other apps
-- when client with a matching name is opened:
require("awful.hotkeys_popup.keys")

if awesome.startup_errors then
    naughty.notify({ preset = naughty.config.presets.critical,
                     title = "Oops, there were errors during startup!",
                     text = awesome.startup_errors })
end

-- Handle runtime errors after startup
do
    local in_error = false
    awesome.connect_signal("debug::error", function (err)
        -- Make sure we don't go into an endless error loop
        if in_error then return end
        in_error = true
        naughty.notify({ preset = naughty.config.presets.critical, title = "Oops, an error happened!", text = tostring(err) })
        in_error = false
    end)
end


-- Theme
----------------------------------------------------------
beautiful.init("~/.config/awesome/theme.lua")
local function set_wallpaper(s)
    if beautiful.wallpaper then
        local wallpaper = beautiful.wallpaper
        -- If wallpaper is a function, call it with the screen
        if type(wallpaper) == "function" then
            wallpaper = wallpaper(s)
        end
        gears.wallpaper.maximized(wallpaper, s, true)
    end
end

    -- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
screen.connect_signal("property::geometry", set_wallpaper)


-- Constants
----------------------------------------------------------
terminal = "termite"
editor = os.getenv("EDITOR") or "nvim"
editor_cmd = terminal .. " -e " .. editor
modkey = "Mod4"

-- Layouts
----------------------------------------------------------
awful.layout.layouts = {
    awful.layout.suit.floating,
    awful.layout.suit.tile,
    awful.layout.suit.tile.left,
    awful.layout.suit.tile.bottom,
    awful.layout.suit.tile.top,
    awful.layout.suit.fair,
    awful.layout.suit.fair.horizontal,
    awful.layout.suit.spiral,
    awful.layout.suit.spiral.dwindle,
    awful.layout.suit.max,
    awful.layout.suit.max.fullscreen,
    awful.layout.suit.magnifier,
    awful.layout.suit.corner.nw,
    -- awful.layout.suit.corner.ne,
    -- awful.layout.suit.corner.sw,
    -- awful.layout.suit.corner.se,
}

-- Menu
----------------------------------------------------------
myawesomemenu = {
   { "hotkeys", function() hotkeys_popup.show_help(nil, awful.screen.focused()) end },
   { "manual", terminal .. " -e man awesome" },
   { "edit config", editor_cmd .. " " .. awesome.conffile },
   { "restart", awesome.restart },
   { "quit", function() awesome.quit() end },
}

mymainmenu = awful.menu({ items = { { "awesome", myawesomemenu, beautiful.awesome_icon },
                                    { "open terminal", terminal }
                                  }
                        })

mylauncher = awful.widget.launcher({ image = beautiful.awesome_icon,
                                     menu = mymainmenu })

-- Menubar configuration
menubar.utils.terminal = terminal

-- Widget bar
----------------------------------------------------------
mytextclock = wibox.widget.textclock()

-- Create a wibox for each screen and add it
local taglist_buttons = gears.table.join(
                    awful.button({ }, 1, function(t) t:view_only() end),
                    awful.button({ modkey }, 1, function(t)
                                              if client.focus then
                                                  client.focus:move_to_tag(t)
                                              end
                                          end),
                    awful.button({ }, 3, awful.tag.viewtoggle),
                    awful.button({ modkey }, 3, function(t)
                                              if client.focus then
                                                  client.focus:toggle_tag(t)
                                              end
                                          end),
                    awful.button({ }, 4, function(t) awful.tag.viewnext(t.screen) end),
                    awful.button({ }, 5, function(t) awful.tag.viewprev(t.screen) end)
                )

-- Tags
----------------------------------------------------------
local tags = sharedtags({
    { name = "1", layout = awful.layout.layouts[2], gap = 4, gap_single_client = 0},
    { name = "2", layout = awful.layout.layouts[2], gap = 4, gap_single_client = 0},
    { name = "3", layout = awful.layout.layouts[2], gap = 4, gap_single_client = 0},
    { name = "4", layout = awful.layout.layouts[2], gap = 4, gap_single_client = 0},
    { name = "5", layout = awful.layout.layouts[2], gap = 4, gap_single_client = 0},
    { name = "6", layout = awful.layout.layouts[2], gap = 4, gap_single_client = 0},
    { name = "7", layout = awful.layout.layouts[2], gap = 4, gap_single_client = 0},
    { name = "8", layout = awful.layout.layouts[2], gap = 4, gap_single_client = 0},
    { name = "9", layout = awful.layout.layouts[2], gap = 4, gap_single_client = 0}

})

--Screens
----------------------------------------------------------
awful.screen.connect_for_each_screen(function(s)
     -- Wallpaper
    set_wallpaper(s)


    -- Create a promptbox for each screen
    s.mypromptbox = awful.widget.prompt()
    -- Create an imagebox widget which will contain an icon indicating which layout we're u    sing.
    -- We need one layoutbox per screen.
    s.mylayoutbox = awful.widget.layoutbox(s)
    s.mylayoutbox:buttons(gears.table.join(
                           awful.button({ }, 1, function () awful.layout.inc( 1) end),
                           awful.button({ }, 3, function () awful.layout.inc(-1) end),
                           awful.button({ }, 4, function () awful.layout.inc( 1) end),
                           awful.button({ }, 5, function () awful.layout.inc(-1) end)))
    -- Create a taglist widget
    s.mytaglist = awful.widget.taglist {
        screen  = s,
        filter  = awful.widget.taglist.filter.noempty,
        buttons = taglist_buttons
    }

    -- Create the wibox
    s.mywibox = awful.wibar({ position = "top", screen = s, opacity = 0.9 })

    -- Add widgets to the wibox
    s.mywibox:setup {
        layout = wibox.layout.align.horizontal,
        { -- Left widgets
            layout = wibox.layout.fixed.horizontal,
            mylauncher,
            s.mytaglist,
            s.mypromptbox,
        },
        s.mytasklist, -- Middle widget
        { -- Right widgets
            layout = wibox.layout.fixed.horizontal,
            mykeyboardlayout,
            wibox.widget.systray(),
            mytextclock,
            s.mylayoutbox,
        },
    }
end)


-- Mouse bindings
----------------------------------------------------------
root.buttons(gears.table.join(
    awful.button({ }, 3, function () mymainmenu:toggle() end),
    awful.button({ }, 4, awful.tag.viewnext),
    awful.button({ }, 5, awful.tag.viewprev)
))

-- Key bindings
----------------------------------------------------------
globalkeys = gears.table.join(
    -- mod
    awful.key({ modkey }, "Return", function () awful.spawn('termite -e "tmux -f /home/mark/.config/tmux/tmux.conf"') end,
        {description = "open a tmux session in termite", group = "launcher"}),
    awful.key({ modkey }, "f", function () awful.spawn("firefox") end,
        {description = "Firefox", group = "launcher"}),
    awful.key({ modkey }, "d", function () awful.spawn("rofi -show run") end,
        {description = "Rofi", group = "launcher"}),
    awful.key({ modkey }, "p", function () awful.spawn("rofi-pass") end,
        {description = "Rofi-pass", group = "launcher"}),
    awful.key({ modkey }, "x", function () awful.spawn("oblogout") end,
        {description = "Oblogout", group = "launcher"}),
    awful.key({ modkey }, "Print", function () awful.spawn("gnome-screenshot -i") end,
        {description = "Gnome screenshot", group = "launcher"}),

    -- mode + shift
    awful.key({ modkey, "Shift" }, "r", awesome.restart,
        {description = "reload awesome", group = "awesome"}),
    awful.key({ modkey, "Shift" }, "Return", function () awful.spawn(terminal) end,
        {description = "open a terminal", group = "launcher"}),
    awful.key({ modkey, "Shift"   }, "e", awesome.quit,
        {description = "quit awesome", group = "awesome"}),

    -- mod + control
    awful.key({ modkey, "Control"}, "l", function () awful.tag.incmwfact( 0.05) end,
              {description = "increase master width factor", group = "layout"}),
    awful.key({ modkey, "Control"}, "h", function () awful.tag.incmwfact(-0.05) end,
              {description = "decrease master width factor", group = "layout"}),

    -- Layout keys
    awful.key({ modkey, }, "space", function () awful.layout.inc( 1) end,
        {description = "select next", group = "layout"}),
    awful.key({ modkey, "Shift"   }, "j", function () awful.client.swap.byidx(  1) end,
        {description = "swap with next client by index", group = "client"}),
    awful.key({ modkey, "Shift"   }, "k", function () awful.client.swap.byidx( -1)  end,
        {description = "swap with previous client by index", group = "client"}),
    awful.key({ modkey,           }, "j", function () awful.client.focus.byidx( 1) end,
        {description = "focus next by index", group = "client"}),
    awful.key({ modkey,           }, "k", function () awful.client.focus.byidx(-1) end,
        {description = "focus previous by index", group = "client"})
)

clientkeys = gears.table.join(
    awful.key({ modkey, "Shift" }, "f",
        function (c)
            c.fullscreen = not c.fullscreen
            c:raise()
        end,
        {description = "toggle fullscreen", group = "client"}),

    awful.key({ modkey, }, "q", function (c) c:kill() end,
        {description = "close", group = "client"}),

    awful.key({ modkey, "Shift"}, "q", function (c) c:kill() end,
        {description = "close", group = "client"}),

    awful.key({ modkey, "Shift" }, "space",  awful.client.floating.toggle,
        {description = "toggle floating", group = "client"})
)

for i = 1, 9 do
    globalkeys = gears.table.join(globalkeys,
        -- View tag only.
        awful.key({ modkey }, "#" .. i + 9,
                  function ()
                        local screen = awful.screen.focused()
                        local tag = tags[i]
                        if tag then
                           sharedtags.viewonly(tag, screen)
                        end
                  end,
                  {description = "view tag #"..i, group = "tag"}),
        -- Toggle tag display.
        awful.key({ modkey, "Control" }, "#" .. i + 9,
                  function ()
                      local screen = awful.screen.focused()
                      local tag = tags[i]
                      if tag then
                         sharedtags.viewtoggle(tag, screen)
                      end
                  end,
                  {description = "toggle tag #" .. i, group = "tag"}),
        -- Move client to tag.
        awful.key({ modkey, "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus then
                          local tag = tags[i]
                          if tag then
                              client.focus:move_to_tag(tag)
                          end
                     end
                  end,
                  {description = "move focused client to tag #"..i, group = "tag"}),
        -- Toggle tag on focused client.
        awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus then
                          local tag = tags[i]
                          if tag then
                              client.focus:toggle_tag(tag)
                          end
                      end
                  end,
                  {description = "toggle focused client on tag #" .. i, group = "tag"})
    )
end

clientbuttons = gears.table.join(
    awful.button({ }, 1, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
    end),
    awful.button({ modkey }, 1, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
        awful.mouse.client.move(c)
    end),
    awful.button({ modkey }, 3, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
        awful.mouse.client.resize(c)
    end)
)

-- Set keys
root.keys(globalkeys)
-- }}}

-- Rules
----------------------------------------------------------
awful.rules.rules = {
    -- All clients will match this rule.
    { rule = { },
      properties = { border_width = beautiful.border_width,
                     border_color = beautiful.border_normal,
                     focus = awful.client.focus.filter,
                     raise = true,
                     keys = clientkeys,
                     buttons = clientbuttons,
                     screen = awful.screen.preferred,
                     placement = awful.placement.no_overlap+awful.placement.no_offscreen
     }
    },

    -- Floating clients.
    { rule_any = {
        instance = {
          "DTA",  -- Firefox addon DownThemAll.
          "copyq",  -- Includes session name in class.
          "pinentry",
        },
        class = {
          "Oblogout",
          "Arandr",
          "Blueman-manager",
          "Gpick",
          "Kruler",
          "MessageWin",  -- kalarm.
          "Sxiv",
          "Wpa_gui",
          "veromix",
          "xtightvncviewer"},

        -- Note that the name property shown in xprop might be set slightly after creation of the client
        -- and the name shown there might not match defined rules here.
        name = {
          "Event Tester",  -- xev.
        },
        role = {
          "AlarmWindow",  -- Thunderbird's calendar.
          "ConfigManager",  -- Thunderbird's about:config.
          --"pop-up",       -- e.g. Google Chrome's (detached) Developer Tools.
        }
      }, properties = { floating = true }},

    -- Add titlebars to normal clients and dialogs
    { rule_any = {type = { "normal", "dialog" }
      }, properties = { titlebars_enabled = true }
    },
    { rule = { instance = "todoist"},
        properties = { tag = "5"}

    },
    -- Set Firefox to always map on the tag named "2" on screen 1.
    -- { rule = { class = "Firefox" },
    --   properties = { screen = 1, tag = "2" } },
}

-- Signals
----------------------------------------------------------
-- Signal function to execute when a new client appears.
client.connect_signal("manage", function (c)
    -- Set the windows at the slave,
    -- i.e. put it at the end of others instead of setting it master.
    -- if not awesome.startup then awful.client.setslave(c) end

    if awesome.startup
      and not c.size_hints.user_position
      and not c.size_hints.program_position then
        -- Prevent clients from being unreachable after screen count changes.
        awful.placement.no_offscreen(c)
    end

    -- Enable round corners with the shape api
    c.shape = function(cr,w,h)
        gears.shape.rounded_rect(cr,w,h,6)
    end
end)

-- Add a titlebar if titlebars_enabled is set to true in the rules.
client.connect_signal("request::titlebars", function(c)
    -- buttons for the titlebar
    local buttons = gears.table.join(
        awful.button({ }, 1, function()
            c:emit_signal("request::activate", "titlebar", {raise = true})
            awful.mouse.client.move(c)
        end),
        awful.button({ }, 3, function()
            c:emit_signal("request::activate", "titlebar", {raise = true})
            awful.mouse.client.resize(c)
        end)
    )

    awful.titlebar(c) : setup {
        { -- Left
            --  awful.titlebar.widget.iconwidget(c),
            buttons = buttons,
            layout  = wibox.layout.fixed.horizontal
        },
        { -- Middle
            { -- Title
                align  = "center",
                widget = awful.titlebar.widget.titlewidget(c)
            },
            buttons = buttons,
            layout  = wibox.layout.flex.horizontal
        },
        { -- Right
            --awful.titlebar.widget.floatingbutton (c),
            --awful.titlebar.widget.maximizedbutton(c),
            --awful.titlebar.widget.stickybutton   (c),
            --awful.titlebar.widget.ontopbutton    (c),
            --awful.titlebar.widget.closebutton    (c),
            layout = wibox.layout.fixed.horizontal()
        },
        layout = wibox.layout.align.horizontal
    }
end)

-- Enable sloppy focus, so that focus follows mouse.
client.connect_signal("mouse::enter", function(c)
    c:emit_signal("request::activate", "mouse_enter", {raise = false})
end)

client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)

awful.util.spawn_with_shell("~/.config/awesome/scripts/autorun.sh")
