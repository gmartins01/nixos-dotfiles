{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:
with lib; let
  cfg = config.hyprland.plugins;
in {
  options.hyprland.plugins = {
    enable = mkEnableOption "Enable Hyprland plugins system";

    csgoVulkanFix = mkOption {
      type = types.submodule (import ./csgo-vulkan-fix.nix {inherit lib pkgs inputs;});
      default = {};
      description = "CS:GO Vulkan Fix plugin configuration";
    };

    dynamicCursors = mkOption {
      type = types.submodule (import ./hypr-dynamic-cursors.nix {inherit lib pkgs inputs;});
      default = {};
      description = "hypr dynamic cursors  plugin configuration";
    };

    hyprbars = mkOption {
      type = types.submodule (import ./hyprbars.nix {inherit lib pkgs inputs;});
      default = {};
      description = "Hyprbars plugin configuration";
    };
  };

  config = mkIf cfg.enable (mkMerge [
    (mkIf cfg.csgoVulkanFix.enable {
      wayland.windowManager.hyprland = {
        plugins = [cfg.csgoVulkanFix.package];
        settings = cfg.csgoVulkanFix.settings;
      };
    })

    (mkIf cfg.dynamicCursors.enable {
      wayland.windowManager.hyprland = {
        plugins = [cfg.dynamicCursors.package];
        settings = cfg.dynamicCursors.settings;
      };
    })

    (mkIf cfg.hyprbars.enable {
      wayland.windowManager.hyprland = {
        plugins = [cfg.hyprbars.package];
        settings = cfg.hyprbars.settings;
      };
    })
  ]);
}
