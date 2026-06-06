-- https://wiki.hypr.land/Configuring/Basics/Autostart/
hl.on("hyprland.start", function () 
  hl.exec_cmd("waybar & swaync & hypridle")
  hl.exec_cmd("swaybg -i ~/.config/backgrounds/zelda-and-link.jpg -m fill")
  hl.exec_cmd("cliphist wipe")
  hl.exec_cmd("wl-paste --watch cliphist store")
end)
