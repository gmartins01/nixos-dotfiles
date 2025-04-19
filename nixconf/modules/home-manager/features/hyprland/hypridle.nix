{
  pkgs,
  lib,
  inputs,
  ...
}: {
  services.hypridle = {
    enable = true;
    package = inputs.hypridle.packages.${pkgs.system}.hypridle;

    settings = {
      general = {
        "lock_cmd" = "pidof hyprlock || hyprlock";
        "before_sleep_cmd" = "loginctl lock-session";
        "after_sleep_cmd" = "hyprctl dispatch dpms on && ddcutil -l 'G27QC' setvcp 10 55 && ddcutil -l 'LG ULTRAGEAR' setvcp 10 50";
      };

      listener = [
        {
          timeout = 150;
          on-timeout = "ddcutil -l 'G27QC' setvcp 10 10 && ddcutil -l 'LG ULTRAGEAR' setvcp 10 10";
          on-resume = "ddcutil -l 'G27QC' setvcp 10 55 && ddcutil -l 'LG ULTRAGEAR' setvcp 10 50";
        }
        {
          timeout = 300;
          on-timeout = "loginctl lock-session";
        }
        {
          timeout = 330;
          on-timeout = "hyprctl dispatch dpms off";
          on-resume = "hyprctl dispatch dpms on && ddcutil -l 'G27QC' setvcp 10 55 && ddcutil -l 'LG ULTRAGEAR' setvcp 10 50";
        }
      ];
    };
  };

  systemd.user.services.hypridle.Unit.After = lib.mkForce "graphical-session.target";
}
