{ inputs, config, pkgs, lib, catppuccin, ... }: {
  programs.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
  };

  environment.systemPackages = with pkgs; [
    hyprpanel
    hyprpaper
    wl-clipboard
    wl-clip-persist
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
  ];

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
  };

  qt = {
    enable = true;
    platformTheme = "kde";
    style = "kvantum";
  };

  

  xdg.portal.extraPortals = [pkgs.xdg-desktop-portal-gtk];
  xdg.portal.enable = true;

  
}
