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

    kdePackages.plasma-integration
    kdePackages.breeze
  ];

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
  };

  qt = {
    enable = true;
    platformTheme = "kde";
    #style = "kvantum";
  };

  

  xdg.portal.extraPortals = [pkgs.xdg-desktop-portal-gtk];
  xdg.portal.enable = true;
  
  stylix.enable = false;
  stylix.targets.grub.enable = false;
  
  stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-macchiato.yaml";

  stylix.image = ./wallpaper.jpg;

  stylix.cursor.package = pkgs.bibata-cursors;
  stylix.cursor.name = "Bibata-Modern-Ice";
  stylix.cursor.size = 26;

  stylix.fonts = {
    monospace = {
      package = pkgs.nerd-fonts.jetbrains-mono;
      name = "JetBrainsMono Nerd Font Mono";
    };
    sansSerif = {
      package = pkgs.dejavu_fonts;
      name = "DejaVu Sans";
    };
    serif = {
      package = pkgs.dejavu_fonts;
      name = "DejaVu Serif";
    };
  };

  stylix.fonts.sizes = {
    applications = 10;
    terminal = 12;
    desktop = 10;
    popups = 10;
  };
 
  stylix.opacity = {
    applications = 1.0;
    terminal = 1.0;
    desktop = 1.0;
    popups = 1.0;
  };
  
  stylix.polarity = "dark";

}
