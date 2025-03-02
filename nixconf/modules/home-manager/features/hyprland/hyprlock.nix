{ pkgs, lib, inputs,config, ... }:

{

  programs.hyprlock = {
    enable = true;
    package = inputs.hyprlock.packages.${pkgs.system}.hyprlock;
    
    settings = {
      general = {
        disable_loading_bar = true;
        immediate_render = true;
        hide_cursor = false;
        no_fade_in = true;
      };

      input-field = [
        {
          monitor = "eDP-3";

          size = "300, 50";
          valign = "bottom";
          position = "0%, 10%";

          outline_thickness = 1;

          font_color = lib.mkForce "rgb(b6c4ff)";
          outer_color = lib.mkForce "rgba(180, 180, 180, 0.5)";
          inner_color = lib.mkForce "rgba(200, 200, 200, 0.1)";
          check_color = lib.mkForce "rgba(247, 193, 19, 0.5)";
          fail_color = lib.mkForce "rgba(255, 106, 134, 0.5)";

          fade_on_empty = false;
          placeholder_text = "Enter Password";

          dots_spacing = 0.2;
          dots_center = true;
          dots_fade_time = 100;

          shadow_color = lib.mkForce "rgba(0, 0, 0, 0.1)";
          shadow_size = 7;
          shadow_passes = 2;
        }
      ];

      label = [
        {
          monitor = "";
          text = "$TIME";
          font_size = 150;
          color = lib.mkForce "rgb(b6c4ff)";

          position = "0%, 30%";

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
          font_size = 20;
          color = lib.mkForce "rgb(b6c4ff)";

          position = "0%, 40%";

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
