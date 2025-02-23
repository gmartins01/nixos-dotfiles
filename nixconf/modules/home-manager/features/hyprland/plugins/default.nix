{ config, lib, pkgs, inputs, ... }:

with lib;

let
  cfg = config.hyprland.plugins;
in {
  options.hyprland.plugins = {
    enable = mkEnableOption "Enable Hyprland plugins system";

    csgoVulkanFix = mkOption {
      type = types.submodule (import ./csgo-vulkan-fix.nix { inherit lib pkgs inputs; });
      default = {};
      description = "CS:GO Vulkan Fix plugin configuration";
    };
  };

  config = mkIf cfg.enable (mkMerge [
    (mkIf cfg.csgoVulkanFix.enable {
      wayland.windowManager.hyprland = {
        plugins = [ cfg.csgoVulkanFix.package ];
        settings = cfg.csgoVulkanFix.settings;
      };
    })
  ]);
}