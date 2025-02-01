{ inputs, config, pkgs, lib, ... }: {
  programs.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
  };

  environment.systemPackages = with pkgs; [
    hyprpanel
    hyprpaper

    # Screenshot
    slurp
    grim
    libnotify

    #clipboard
    wl-clipboard
    clipse
    
    libsForQt5.qt5ct
    kdePackages.qt6ct
    kdePackages.qtwayland
    qt5.qtwayland
    
    wofi # app launcher

    #libsForQt5.kwallet-pam
    #libsForQt5.kwallet

    nwg-look # theme apps
    
    rofi-wayland

    # To theme kde apps
    kdePackages.plasma-integration
    kdePackages.breeze

    bulky # Bulk rename
    
    glib
  ];

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
  };

  qt = {
    enable = true;
    platformTheme = "kde";
    style = "breeze";
  };
  
  xdg.portal.extraPortals = [pkgs.xdg-desktop-portal-gtk];
  xdg.portal.enable = true;

  xdg.mime.enable = true;
  xdg.menus.enable = true;

  xdg = {
    terminal-exec = {
      enable = true;
      settings = {
        default = [ "alacritty.desktop" ];
      };
    };
  };

}
