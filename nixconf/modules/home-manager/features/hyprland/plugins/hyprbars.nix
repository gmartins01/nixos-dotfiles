{
  lib,
  pkgs,
  inputs,
  ...
}: {
  options = {
    enable = lib.mkEnableOption "Hyprbars plugin";

    package = lib.mkOption {
      type = lib.types.package;
      default = inputs.hyprland-plugins.packages.${pkgs.stdenv.hostPlatform.system}.hyprbars;
      description = "Package for the Hyprbars plugin";
    };

    settings = lib.mkOption {
      type = lib.types.attrs;
      default = {
        "plugin:hyprbars" = {
          rar_height = 20;
        };
      };
      description = "Configuration settings for the plugin";
    };
  };
}

