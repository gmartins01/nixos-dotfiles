{ pkgs, lib, inputs,config, ... }:

{

  programs.hyprlock = {
    enable = true;
    package = inputs.hyprlock.packages.${pkgs.system}.hyprlock;
    
    settings = {

      background = {
        monitor = "";
        path = "screenshot";
        color = lib.mkForce "rgba(25, 20, 20, 1.0)";
        blur_passes = 2;
      };

      input-field = {
        monitor = "";
        size = "20%, 5%";
        outline_thickness = 3;
        inner_color = lib.mkForce "rgba(0, 0, 0, 0.0)";

        outer_color = lib.mkForce "rgba(${config.stylix.base16Scheme.base07}ff)";
        check_color= lib.mkForce "rgba(${config.stylix.base16Scheme.base0A}ff)";
        fail_color= lib.mkForce "rgba(${config.stylix.base16Scheme.base08}ff)";

        rounding = 12;
        fade_on_empty = false;
        font_color = lib.mkForce "rgba(${config.stylix.base16Scheme.base05}ff)";

        position = "0, -20";
        halign = "center";
        valign = "center";
      };

       label = [
        {
          monitor = "";
          text = "$TIME";
          font_size = 50;
          color = lib.mkForce "rgba(${config.stylix.base16Scheme.base07}ff)";

          position = "0%, 10%";

          valign = "center";
          halign = "center";

          shadow_color = lib.mkForce "rgba(0, 0, 0, 0.1)";
          shadow_size = 20;
          shadow_passes = 2;
          shadow_boost = 0.3;
        }
        {
          monitor = "";
          text = "cmd[update:3600000] date +'%a %b %d'";
          font_size = 30;
          color = lib.mkForce "rgba(${config.stylix.base16Scheme.base07}ff)";

          position = "0%, 15%";

          valign = "center";
          halign = "center";

          shadow_color = lib.mkForce "rgba(0, 0, 0, 0.1)";
          shadow_size = 20;
          shadow_passes = 2;
          shadow_boost = 0.3;
        }
      ];

    };

  };
  
}
