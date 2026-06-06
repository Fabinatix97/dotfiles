hl.config({
    -- https://wiki.hypr.land/Configuring/Basics/Variables/#general
    general = {
        gaps_in  = 5,
        gaps_out = 20,
        border_size = 2,
        col = {
            active_border   = { colors = {"rgba(33ccffee)", "rgba(00ff99ee)"}, angle = 45 },
            inactive_border = "rgba(595959aa)",
        },
        layout = "dwindle",
    },

    -- https://wiki.hypr.land/Configuring/Basics/Variables/#input
    input = {
        kb_layout  = "de",
        follow_mouse = 1,
        sensitivity = 0,
        touchpad = {
            natural_scroll = false,
        },
    },

    -- https://wiki.hypr.land/Configuring/Basics/Variables/#decoration
    decoration = {
        rounding       = 10,
        rounding_power = 2,
        active_opacity   = 1.0,
        inactive_opacity = 1.0,
        shadow = {
            enabled      = true,
            range        = 4,
            render_power = 3,
            color        = 0xee1a1a1a,
        },
        blur = {
            enabled   = true,
            size      = 3,
            passes    = 1,
            vibrancy  = 0.1696,
        },
    },

    -- https://wiki.hypr.land/Configuring/Basics/Variables/#animations
    animations = {
        enabled = true,
    },

    -- https://wiki.hypr.land/Configuring/Layouts/Dwindle-Layout/
    dwindle = {
        preserve_split = true,
    },

    -- https://wiki.hypr.land/Configuring/Basics/Variables/#misc
    misc = {
        force_default_wallpaper = 0,
        disable_hyprland_logo   = true,
        disable_hyprland_guiutils_check = true
    },
})
