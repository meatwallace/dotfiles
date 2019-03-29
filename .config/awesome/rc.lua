-- TODO(#3): clean up and finish baseline customization of awesome wm config

-- core
local gears = require('gears')
local awful = require('awful')

-- widget & layout
local wibox = require('wibox')

-- theming
local beautiful = require('beautiful')

-- notifications
local naughty = require('naughty')
local hotkeys_popup = require('awful.hotkeys_popup').widget

-- plugins
require('awful.autofocus')

-- enable vim help for our popup widget
require('awful.hotkeys_popup.keys.vim')

-- send a notification if we encountered issues during startup
if awesome.startup_errors then
  naughty.notify({
    preset = naughty.config.presets.critical,
    title = 'there was an error during startup',
    text = awesome.startup_errors,
  })
end

-- handle runtime errors after startup
do
  local in_error = false
  awesome.connect_signal('debug::error', function(err)
    -- avoid endless error handling loop
    if in_error then return end

    in_error = true

    naughty.notify({
      preset = naughty.config.presets.critical,
      title = 'Oops, an error happened!',
      text = tostring(err),
    })

    in_error = false
  end)
end

-- theme
theme = gears.filesystem.get_configuration_dir() .. 'theme.lua'
beautiful.init(theme)

-- utils
browser = os.getenv('BROWSER')
gui_editor = os.getenv('VISUAL')
editor = os.getenv('EDITOR')
terminal = os.getenv('TERMINAL')

-- core config
modkey = 'Mod4'

awful.layout.layouts
= {
  awful.layout.suit.tile,
  awful.layout.suit.floating,
  -- awful.layout.suit.tile.left,
  awful.layout.suit.tile.bottom,
  -- awful.layout.suit.tile.top,
  -- awful.layout.suit.fair,
  -- awful.layout.suit.fair.horizontal,
  -- awful.layout.suit.spiral,
  -- awful.layout.suit.spiral.dwindle,
  -- awful.layout.suit.max,
  -- awful.layout.suit.max.fullscreen,
  -- awful.layout.suit.magnifier,
  -- awful.layout.suit.corner.nw,
  -- awful.layout.suit.corner.ne,
  -- awful.layout.suit.corner.sw,
  -- awful.layout.suit.corner.se,
}

-- {{{ Wibar
-- Create a textclock widget
mytextclock = wibox.widget.textclock('%H:%M ')

darkblue = beautiful.bg_focus
blue = '#9EBABA'
red = '#EB8F8F'
separator = wibox.widget.textbox(' <span color="' .. blue .. '">| </span>')
spacer = wibox.widget.textbox(' <span color="' .. blue .. '"> </span>')

-- Create a wibox for each screen and add it
local taglist_buttons = gears.table.join(
  awful.button({}, 1, function(t)
    t:view_only()
  end),
  awful.button({ modkey }, 1, function(t)
    if client.focus then
      client.focus:move_to_tag(t)
    end
  end),
  awful.button({}, 3, awful.tag.viewtoggle),
  awful.button({ modkey }, 3, function(t)
    if client.focus then
      client.focus:toggle_tag(t)
    end
  end),
  awful.button({}, 4, function(t)
    awful.tag.viewnext(t.screen)
  end),
  awful.button({}, 5, function(t)
    awful.tag.viewprev(t.screen)
  end)
)

local tasklist_buttons = gears.table.join(
  awful.button({}, 1, function(c)
    if c == client.focus then
      c.minimized = true
      -- Without this, the following
      -- :isvisible() makes no sense
      -- This will also un-minimize
      -- the client, if needed
    else
      c.minimized = false
      if not c:isvisible() and c.first_tag then
        c.first_tag:view_only()
      end
      client.focus = c
      c:raise()
    end
  end),
  awful.button({}, 4, function()
    awful.client.focus.byidx(1)
  end),
  awful.button({}, 5, function()
    awful.client.focus.byidx(-1)
  end)
)

local function set_wallpaper(s)
  -- Wallpaper
  if beautiful.wallpaper then
    local wallpaper = beautiful.wallpaper
    -- If wallpaper is a function, call it with the screen
    if type(wallpaper) == 'function' then
      wallpaper = wallpaper(s)
    end
    gears.wallpaper.maximized(wallpaper, s, true)
  end
end

-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
screen.connect_signal('property::geometry', set_wallpaper)

awful.screen.connect_for_each_screen(function(s)
-- Wallpaper

-- Each screen has its own tag table.

-- Create a promptbox for each screen

-- Create an imagebox widget which will contains an icon indicating which layout we're using.
-- We need one layoutbox per screen.
-- Create a taglist widget

-- Create a tasklist widget

-- Create the wibox

-- Add widgets to the wibox -- Left widgets -- Middle widget -- Right widgets
  set_wallpaper(s)

  awful.tag({ '1', '2', '3', '4', '5', '6' }, s, awful.layout.layouts[1])

  s.mypromptbox = awful.widget.prompt()

  s.mylayoutbox = awful.widget.layoutbox(s)
  s.mylayoutbox:buttons(
    gears.table.join(
      awful.button({}, 1, function()
        awful.layout.inc(1)
      end),
      awful.button({}, 3, function()
        awful.layout.inc(-1)
      end),
      awful.button({}, 4, function()
        awful.layout.inc(1)
      end),
      awful.button({}, 5, function()
        awful.layout.inc(-1)
      end)
    )
  )
  s.mytaglist =
    awful.widget.taglist(s, awful.widget.taglist.filter.all, taglist_buttons)

  s.mytasklist =
    awful.widget.tasklist(
      s,
      awful.widget.tasklist.filter.currenttags,
      tasklist_buttons
    )

  s.mywibox = awful.wibar({
    position = 'top',
    screen = s,
  })

  s.mywibox:setup{
    layout = wibox.layout.align.horizontal,
    {
      layout = wibox.layout.fixed.horizontal,
      mylauncher,
      s.mytaglist,
      s.mypromptbox,
      separator,
    },
    s.mytasklist,
    {
      layout = wibox.layout.fixed.horizontal,
      wibox.widget.systray(),
      separator,
      mytextclock,
      s.mylayoutbox,
    },
  }
end)
-- }}}

-- screenshot helper functions
local function captureScreenshot(opts)
  opts = opts or ""
  
  awful.spawn.with_shell('maim ' .. opts .. ' ~/screenshots/$(date +%Y%m%d_%H%M%S_%N).png')
end

local function captureScreenshotSelection()
  capture_screenshot('--select')
end

local function captureScreenshotActiveWindow()
  capture_screenshot('--window=$(xdotool getactivewindow)')
end

-- {{{ Key bindings
globalkeys = gears.table.join(
  awful.key({ modkey }, 's', hotkeys_popup.show_help, {
    description = 'show help',
    group = 'awesome',
  }),
  awful.key({ modkey }, 'Left', awful.tag.viewprev, {
    description = 'view previous',
    group = 'tag',
  }),
  awful.key({ modkey }, 'Right', awful.tag.viewnext, {
    description = 'view next',
    group = 'tag',
  }),
  awful.key({ modkey }, 'Escape', awful.tag.history.restore, {
    description = 'go back',
    group = 'tag',
  }),

  awful.key(
    { modkey },
    'j',
    function()
      awful.client.focus.byidx(1)
    end,
    {
      description = 'focus next by index',
      group = 'client',
    }
  ),
  awful.key(
    { modkey },
    'k',
    function()
      awful.client.focus.byidx(-1)
    end,
    {
      description = 'focus previous by index',
      group = 'client',
    }
  ),

  -- Layout manipulation
  awful.key(
    { modkey, 'Shift' },
    'j',
    function()
      awful.client.swap.byidx(1)
    end,
    {
      description = 'swap with next client by index',
      group = 'client',
    }
  ),
  awful.key(
    { modkey, 'Shift' },
    'k',
    function()
      awful.client.swap.byidx(-1)
    end,
    {
      description = 'swap with previous client by index',
      group = 'client',
    }
  ),
  awful.key(
    { modkey, 'Control' },
    'j',
    function()
      awful.screen.focus_relative(1)
    end,
    {
      description = 'focus the next screen',
      group = 'screen',
    }
  ),
  awful.key(
    { modkey, 'Control' },
    'k',
    function()
      awful.screen.focus_relative(-1)
    end,
    {
      description = 'focus the previous screen',
      group = 'screen',
    }
  ),
  awful.key({ modkey }, 'u', awful.client.urgent.jumpto, {
    description = 'jump to urgent client',
    group = 'client',
  }),
  awful.key(
    { modkey },
    'Tab',
    function()
      awful.client.focus.history.previous()
      if client.focus then
        client.focus:raise()
      end
    end,
    {
      description = 'go back',
      group = 'client',
    }
  ),

  -- Standard program
  awful.key(
    { modkey },
    'Return',
    function()
      awful.spawn(terminal)
    end,
    {
      description = 'open a terminal',
      group = 'launcher',
    }
  ),
  awful.key({ modkey, 'Control' }, 'r', awesome.restart, {
    description = 'reload awesome',
    group = 'awesome',
  }),
  awful.key({ modkey, 'Shift' }, 'q', awesome.quit, {
    description = 'quit awesome',
    group = 'awesome',
  }),
  awful.key(
    { modkey },
    'l',
    function()
      awful.tag.incmwfact(0.05)
    end,
    {
      description = 'increase master width factor',
      group = 'layout',
    }
  ),
  awful.key(
    { modkey },
    'h',
    function()
      awful.tag.incmwfact(-0.05)
    end,
    {
      description = 'decrease master width factor',
      group = 'layout',
    }
  ),
  awful.key(
    { modkey, 'Shift' },
    'h',
    function()
      awful.tag.incnmaster(1, nil, true)
    end,
    {
      description = 'increase the number of master clients',
      group = 'layout',
    }
  ),
  awful.key(
    { modkey, 'Shift' },
    'l',
    function()
      awful.tag.incnmaster(-1, nil, true)
    end,
    {
      description = 'decrease the number of master clients',
      group = 'layout',
    }
  ),
  awful.key(
    { modkey, 'Control' },
    'h',
    function()
      awful.tag.incncol(1, nil, true)
    end,
    {
      description = 'increase the number of columns',
      group = 'layout',
    }
  ),
  awful.key(
    { modkey, 'Control' },
    'l',
    function()
      awful.tag.incncol(-1, nil, true)
    end,
    {
      description = 'decrease the number of columns',
      group = 'layout',
    }
  ),
  awful.key(
    { modkey },
    'p',
    function()
      awful.spawn('/usr/bin/rofi -show drun -modi window,drun')
    end,
    {
      description = 'launch rofi',
      group = 'launcher',
    }
  ),
  awful.key(
    { modkey, 'Shift' },
    'space',
    function()
      awful.layout.inc(-1)
    end,
    {
      description = 'select previous',
      group = 'layout',
    }
  ),
  
  -- screenshots
  awful.key({           }, 'Print', captureScreenshot,
            { group = 'screenshot', description = 'capture a screenshot' }),
  awful.key({ 'Control' }, 'Print', captureScreenshotActiveWindow,
            { group = 'screenshot', description = 'capture a screenshot of the active window' }),
  awful.key({ 'Shift'   }, 'Print', captureScreenshotSelection,
            { group = 'screenshot', description = 'capture a screenshot of a selection' }),



  awful.key(
    { modkey, 'Control' },
    'n',
    function()
      local c = awful.client.restore()
      -- Focus restored client
      if c then
        client.focus = c
        c:raise()
      end
    end,
    {
      description = 'restore minimized',
      group = 'client',
    }
  ),

  -- Prompt
  awful.key(
    { modkey },
    'r',
    function()
      awful.screen.focused().mypromptbox:run()
    end,
    {
      description = 'run prompt',
      group = 'launcher',
    }
  )
)

clientkeys = gears.table.join(
  awful.key(
    { modkey },
    'f',
    function(c)
      c.fullscreen = not c.fullscreen
      c:raise()
    end,
    {
      description = 'toggle fullscreen',
      group = 'client',
    }
  ),
  awful.key(
    { modkey },
    'x',
    function(c)
      c:kill()
    end,
    {
      description = 'close',
      group = 'client',
    }
  ),
  awful.key({ modkey, 'Control' }, 'space', awful.client.floating.toggle, {
    description = 'toggle floating',
    group = 'client',
  }),
  awful.key(
    { modkey, 'Control' },
    'Return',
    function(c)
      c:swap(awful.client.getmaster())
    end,
    {
      description = 'move to master',
      group = 'client',
    }
  ),
  awful.key(
    { modkey },
    'o',
    function(c)
      c:move_to_screen()
    end,
    {
      description = 'move to screen',
      group = 'client',
    }
  ),
  awful.key(
    { modkey },
    't',
    function(c)
      c.ontop = not c.ontop
    end,
    {
      description = 'toggle keep on top',
      group = 'client',
    }
  ),
  awful.key(
    { modkey },
    'n',
    function(c)
      -- The client currently has the input focus, so it cannot be
      -- minimized, since minimized clients can't have the focus.
      c.minimized = true
    end,
    {
      description = 'minimize',
      group = 'client',
    }
  ),
  awful.key(
    { modkey },
    'm',
    function(c)
      c.maximized = not c.maximized
      c:raise()
    end,
    {
      description = '(un)maximize',
      group = 'client',
    }
  ),
  awful.key(
    { modkey, 'Control' },
    'm',
    function(c)
      c.maximized_vertical = not c.maximized_vertical
      c:raise()
    end,
    {
      description = '(un)maximize vertically',
      group = 'client',
    }
  ),
  awful.key(
    { modkey, 'Shift' },
    'm',
    function(c)
      c.maximized_horizontal = not c.maximized_horizontal
      c:raise()
    end,
    {
      description = '(un)maximize horizontally',
      group = 'client',
    }
  )
)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it work on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 9 do
  globalkeys = gears.table.join(
  -- Toggle tag on focused client.
    globalkeys,
    -- View tag only.
    awful.key(
      { modkey },
      '#' .. i + 9,
      function()
        local screen = awful.screen.focused()
        local tag = screen.tags[i]
        if tag then
          tag:view_only()
        end
      end,
      {
        description = 'view tag #' .. i,
        group = 'tag',
      }
    ),
    -- Toggle tag display.
    awful.key(
      { modkey, 'Control' },
      '#' .. i + 9,
      function()
        local screen = awful.screen.focused()
        local tag = screen.tags[i]
        if tag then
          awful.tag.viewtoggle(tag)
        end
      end,
      {
        description = 'toggle tag #' .. i,
        group = 'tag',
      }
    ),
    -- Move client to tag.
    awful.key(
      { modkey, 'Shift' },
      '#' .. i + 9,
      function()
        if client.focus then
          local tag = client.focus.screen.tags[i]
          if tag then
            client.focus:move_to_tag(tag)
          end
        end
      end,
      {
        description = 'move focused client to tag #' .. i,
        group = 'tag',
      }
    ),
    awful.key(
      { modkey, 'Control', 'Shift' },
      '#' .. i + 9,
      function()
        if client.focus then
          local tag = client.focus.screen.tags[i]
          if tag then
            client.focus:toggle_tag(tag)
          end
        end
      end,
      {
        description = 'toggle focused client on tag #' .. i,
        group = 'tag',
      }
    )
  )
end

clientbuttons = gears.table.join(
  awful.button({}, 1, function(c)
    client.focus = c
    c:raise()
  end),
  awful.button({ modkey }, 1, awful.mouse.client.move),
  awful.button({ modkey }, 3, awful.mouse.client.resize)
)

-- Set keys
root.keys(globalkeys)
-- }}}

-- {{{ Rules
-- Rules to apply to new clients (through the "manage" signal).
awful.rules.rules = { -- All clients will match this rule.
{
  rule = {},
  properties = {
    -- border_width = beautiful.border_width,
    -- border_color = beautiful.border_normal,
    focus = awful.client.focus.filter,
    raise = true,
    keys = clientkeys,
    buttons = clientbuttons,
    size_hints_honor = false, -- Remove gaps between terminals
    screen = awful.screen.preferred,
    callback = awful.client.setslave,
    placement = awful.placement.no_overlap + awful.placement.no_offscreen,
  },
}, -- Floating clients.
{
  rule_any = {
    instance = {},
    class = {},
    name = {},
    role = { 'pop-up' }, -- e.g. Google Chrome's (detached) Developer Tools.
  },
  properties = { floating = true },
}, -- Add titlebars to normal clients and dialogs
{
  rule_any = {
    type = { 'normal', 'dialog' },
  },
  properties = { titlebars_enabled = true },
} }

-- Set Firefox to always map on the tag named "2" on screen 1.
-- { rule = { class = "Firefox" },
--   properties = { screen = 1, tag = "2" } },
-- }}}

-- {{{ Signals

local rounded_tiled_window = function(cr, width, height)
  gears.shape.rounded_rect(cr, width, height, beautiful.border_radius)
end

-- Signal function to execute when a new client appears.
client.connect_signal('manage', function(c)
  -- Set the windows at the slave,
  -- i.e. put it at the end of others instead of setting it master.
  -- if not awesome.startup then awful.client.setslave(c) end

  -- c.shape = rounded_tiled_window

  if awesome.startup and not c.size_hints.user_position and not c.size_hints.program_position then
    -- Prevent clients from being unreachable after screen count changes.
    awful.placement.no_offscreen(c)
  end
end)

-- Add a titlebar if titlebars_enabled is set to true in the rules.
client.connect_signal('request::titlebars', function(c)
  local left_titlebar = awful.titlebar(c, {
    bg_normal = beautiful.border_normal,
    bg_focus = beautiful.border_focus,
    size = beautiful.border_width,
    position = 'left',
  })

  local top_titlebar = awful.titlebar(c, {
    bg_normal = beautiful.border_normal,
    bg_focus = beautiful.border_focus,
    size = beautiful.border_width,
  })

  -- local bottom_titlebar = awful.titlebar(c, {
  -- bg_normal = beautiful.border_normal,
  -- bg_focus = beautiful.border_focus,
  -- size = beautiful.border_width,
  -- position = "bottom",
  -- })

  -- top_titlebar : setup {}
end)

client.connect_signal('focus', function(c) end)

client.connect_signal('unfocus', function(c) end)

-- Handle border sizes of clients.
for s = 1, screen.count() do
  screen[s]:connect_signal('arrange', function()
    local clients = awful.client.visible(s)
    local layout = awful.layout.getname(awful.layout.get(s))

    for _, c in pairs(clients) do
      -- No borders with only one humanly visible client
      if c.maximized then
      -- NOTE: also handled in focus, but that does not cover maximizing from a
      -- tiled state (when the client had focus).
      -- c.border_width = 0
      elseif c.floating or layout == 'floating' then
      -- c.border_width = beautiful.border_width
      elseif layout == 'max' or layout == 'fullscreen' then
      -- c.border_width = 0
      else
        local tiled = awful.client.tiled(c.screen)

        if #tiled == 1 then -- and c == tiled[1] then
          -- tiled[1].border_width = 1
          -- c.border_width = beautiful.border_width
        else
        end
      end
    end
  end)
end

-- }}}

client.connect_signal('property::fullscreen', function(c)
  if c.fullscreen then
    awful.titlebar.hide(c)
  else
    awful.titlebar.show(c)
  end
end)

client.connect_signal('property::maximized', function(c)
  if c.maximized then
    awful.titlebar.hide(c)
  else
    awful.titlebar.show(c)
  end
end)

client.connect_signal('property::floating', function(c)
  if c.floating then
    awful.titlebar.show(c)
  else
    awful.titlebar.hide(c)
  end
end)

awful.spawn.with_shell('~/.config/awesome/autorun.sh')
