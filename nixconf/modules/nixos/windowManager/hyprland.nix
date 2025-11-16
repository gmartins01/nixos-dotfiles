{
  inputs,
  config,
  pkgs,
  lib,
  ...
}: {
  programs.hyprland = {
    enable = true;
    #package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    #portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
    package = pkgs.hyprland;
    portalPackage = pkgs.xdg-desktop-portal-hyprland;
    withUWSM = true;
  };

  environment.systemPackages = with pkgs; [
    inputs.hyprpanel.packages.${pkgs.stdenv.hostPlatform.system}.default

    hyprpaper
  ];
}
