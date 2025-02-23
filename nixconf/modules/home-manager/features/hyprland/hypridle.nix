{ pkgs, lib, inputs, ... }:

{

  services.hypridle = {
    enable = false;
    package = inputs.hypridle.packages.${pkgs.system}.hypridle;
   
    settings = {
      listener = [
        {
          timeout = 300;
          on-timeout = "ddcutil -l 'G27QC' setvcp 10 10 && ddcutil -l 'LG ULTRAGEAR' setvcp 10 10";
          on-resume = "ddcutil -l 'G27QC' setvcp 10 55 && ddcutil -l 'LG ULTRAGEAR' setvcp 10 55";
        }
        {
          timeout = 900;
          on-timeout = "hyprctl dispatch dpms off";
          on-resume = "hyprctl dispatch dpms on";
        }
      ];
    };
  };
  
  systemd.user.services.hypridle.Unit.After = lib.mkForce "graphical-session.target";
}
