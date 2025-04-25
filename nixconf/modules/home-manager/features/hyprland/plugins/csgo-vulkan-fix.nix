{
  lib,
  pkgs,
  inputs,
  ...
}: {
  options = {
    enable = lib.mkEnableOption "CS:GO Vulkan Fix plugin";

    package = lib.mkOption {
      type = lib.types.package;
      default = inputs.hyprland-plugins.packages.${pkgs.stdenv.hostPlatform.system}.csgo-vulkan-fix;
      description = "Package for the CS:GO Vulkan Fix plugin";
    };

    settings = lib.mkOption {
      type = lib.types.attrs;
      default = {
        "plugin:csgo-vulkan-fix" = {
          res_w = 1920;
          res_h = 1080;
          class = "cs2";
          fix_mouse = true;
        };
      };
      description = "Configuration settings for the plugin";
    };
  };
}

