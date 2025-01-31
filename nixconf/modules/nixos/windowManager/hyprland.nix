{ inputs, config, pkgs, lib, ... }: {
  programs.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
  };

  environment.systemPackages = with pkgs; [
    hyprpanel
    hyprpaper
    wl-clipboard
    clipse
    
    libsForQt5.qt5ct
    kdePackages.qt6ct
    kdePackages.qtwayland
    qt5.qtwayland
    #libsForQt5.qtstyleplugin-kvantum
    #libsForQt5.lightly
    #libsForQt5.qtstyleplugins 
    
    wofi
    #libsForQt5.dolphin

    #libsForQt5.kwallet-pam
    #libsForQt5.kwallet

    nwg-look # theme apps
    
    rofi-wayland

    kdePackages.plasma-integration
    kdePackages.breeze

    bulky # Bulk rename

    nemo-with-extensions
    #nemo-python
    #cinnamon-common
    #cinnamon-desktop
    
    glib
    dconf-editor
    #eww
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
