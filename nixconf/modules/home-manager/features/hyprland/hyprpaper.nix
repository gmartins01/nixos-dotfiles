{
  lib,
  pkgs,
  inputs,
  config,
  ...
}: {
  services.hyprpaper = {
    enable = true;
    package = pkgs.hyprpaper;

    settings = {
      preload = ["~/Pictures/wallpaper.png"];
      wallpaper = [", ~/Pictures/wallpaper.png"];
    };
  };

  systemd.user.services.hyprpaper.Unit.After = lib.mkForce "graphical-session.target";
}

