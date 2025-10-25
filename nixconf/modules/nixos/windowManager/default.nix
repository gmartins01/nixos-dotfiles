{
  config,
  inputs,
  pkgs,
  ...
}: {
  imports = [
    ./hyprland.nix
    ./awesome.nix
  ];

  programs.niri.enable = true;

  environment.systemPackages = with pkgs; [
    xwayland-satellite

    # Screenshot
    slurp
    grim
    libnotify

    #clipboard
    wl-clipboard
    clipse
    stable.copyq

    stable.libsForQt5.qt5ct
    stable.kdePackages.qt6ct
    stable.kdePackages.qtwayland
    stable.qt5.qtwayland

    fuzzel # app launcher

    bemoji # emoji selector

    # To theme kde apps
    # kdePackages.plasma-integration
    # kdePackages.breeze

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

  #  qt = {
  #    enable = true;
  # #   # style = "breeze";
  #    platformTheme = "kde";
  #  };

  xdg.mime.enable = true;
  xdg.menus.enable = true;

  xdg = {
    portal = {
      enable = true;
      xdgOpenUsePortal = true;
      config = {
        common.default = ["gtk" "gnome"];
        hyprland.default = ["gtk" "hyprland"];
        niri = {
          default = ["gnome" "gtk"];
          "org.freedesktop.impl.portal.Access" = "gtk";
          "org.freedesktop.impl.portal.Notification" = "gtk";
          "org.freedesktop.impl.portal.Secret" = "gnome-keyring";
          "org.freedesktop.impl.portal.FileChooser" = "gtk";
          "org.freedesktop.impl.portal.ScreenCast" = "gnome";
          "org.freedesktop.portal.ScreenCast" = "gnome";
        };
      };

      extraPortals = [pkgs.xdg-desktop-portal-gtk pkgs.xdg-desktop-portal-gnome];
    };
    terminal-exec = {
      enable = true;
      settings = {
        default = ["kitty.desktop"];
      };
    };
  };
}
