{ pkgs, lib, config, ... }:

{

  wayland.windowManager.hyprland = {
    settings = {
      monitor = [
        "DP-1, 1920x1080@164, 0x0, 1"
        "DP-3, 2560x1440@164, 1920x0, 1"
      ];

      workspace = [
        "1, monitor:DP-3"
        "f[1], gapsout:0, gapsin:0" # for smart gaps
      ];
    };
  };

}