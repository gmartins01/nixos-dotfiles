{
  inputs,
  config,
  pkgs,
  lib,
  ...
}: {
  programs.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
    withUWSM = true;
  };

  environment.systemPackages = with pkgs; [
    inputs.hyprpanel.packages.${pkgs.system}.default

    hyprpaper

    # Screenshot
    slurp
    grim
    libnotify

    #clipboard
    wl-clipboard
    clipse
    copyq

    libsForQt5.qt5ct
    kdePackages.qt6ct
    kdePackages.qtwayland
    qt5.qtwayland

    fuzzel # app launcher

    bemoji # emoji selector

    # To theme kde apps
    kdePackages.plasma-integration
    kdePackages.breeze

    # To fix some gtk apps
    adwaita-icon-theme
    gnome-themes-extra
    papirus-icon-theme

    bulky # Bulk rename

    glib

    ddcutil

    bibata-cursors
  ];

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    BEMOJI_PICKER_CMD = "fuzzel";
  };

  qt = {
    enable = true;
    style = "breeze";
    platformTheme = "kde";
  };

  xdg.mime.enable = true;
  xdg.menus.enable = true;

  xdg = {
    portal = {
      enable = true;
      extraPortals = [pkgs.xdg-desktop-portal-gtk];
      config = {
        common.default = ["gtk"];
        hyprland.default = ["gtk" "hyprland"];
      };
    };
    terminal-exec = {
      enable = true;
      settings = {
        default = ["kitty.desktop"];
      };
    };
  };
}
