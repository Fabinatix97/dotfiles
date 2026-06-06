-- https://wiki.hypr.land/Configuring/Basics/Window-Rules/
local suppressMaximizeRule = hl.window_rule({
    -- Ignore maximize requests from all apps. You'll probably like this.
    name  = "suppress-maximize-events",
    match = { class = ".*" },
    suppress_event = "maximize",
})
suppressMaximizeRule:set_enabled(false)

hl.window_rule({
    -- Fix some dragging issues with XWayland
    name  = "fix-xwayland-drags",
    match = {
        class      = "^$",
        title      = "^$",
        xwayland   = true,
        float      = true,
        fullscreen = false,
        pin        = false,
    },
    no_focus = true,
})

hl.window_rule({
  name = "firefox-ws1",
  match = { class = "firefox" },
  workspace = "1 silent",
})

hl.window_rule({
  name = "kitty-ws2",
  match = { class = "kitty" },
  workspace = "2 silent",
})

-- Hyprland-run windowrule
hl.window_rule({
    name  = "move-hyprland-run",
    match = { class = "hyprland-run" },
    move  = "20 monitor_h-120",
    float = true,
})

hl.window_rule({
  name = "nautilus-float-center",
  match = { class = "org.gnome.Nautilus" },
  float = true,
  center = true,
})

hl.window_rule({
  name = "waybar-popup",
  match = { class = "waybar" },
  float = true,
  center = true,
  max_size = { 1500, 1000 },
})
