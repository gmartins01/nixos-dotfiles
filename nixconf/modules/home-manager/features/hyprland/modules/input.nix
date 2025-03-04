{ pkgs, lib, config, ... }:

{

  wayland.windowManager.hyprland = {
    settings = {
      input = {
          kb_layout = "pt";

          follow_mouse = 1;

          sensitivity = 0; # -1.0 - 1.0, 0 means no modification.

          touchpad = {
              natural_scroll = false;
          };
      };

      gestures = {
        workspace_swipe = false;
      };

      device = [
        {
          name = "razer-razer-viper-ultimate-dongle-3";
          sensitivity = "-0.8";
        }

        {
          name = "razer-razer-viper-ultimate-dongle";
          sensitivity = "-0.8";
        }

        {
          name = "razer-razer-viper-ultimate-dongle-2";
          sensitivity = "-0.8";
        }
      ];
      
    };
  };

}