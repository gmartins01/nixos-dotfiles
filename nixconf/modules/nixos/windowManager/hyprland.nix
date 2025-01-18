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
    qt6.qtwayland
    qt5.qtwayland
    libsForQt5.qtstyleplugin-kvantum
    libsForQt5.lightly
    #libsForQt5.kservice # to fix opening files with default applications
    nautilus
    
    libsForQt5.dolphin
    #libsForQt5.dolphin
    #xfce.thunar
    #libsForQt5.kwallet-pam
    #libsForQt5.kwallet

    nwg-look # theme apps
    libsForQt5.qtstyleplugins 
    libexif

    libsForQt5.gwenview # image viewer

    libsForQt5.kdegraphics-thumbnailers
    libsForQt5.qtimageformats
    libsForQt5.ffmpegthumbs
    libsForQt5.qtsvg
    libsForQt5.kservice
    #catppuccin-gtk
    #catppuccin-kvantum
    #nautilus-open-any-terminal
  ];

  services.gnome.gnome-keyring.enable = true;
  security.pam.services.sddm.enableGnomeKeyring = true;

 # Mount, trash, and other functionalities
  services.gvfs.enable = true;

  # Thumbnail support for images
  services.tumbler.enable = true;
  
  programs.thunar.enable = true;
  programs.xfconf.enable = true;
  programs.thunar.plugins = with pkgs.xfce; [
    thunar-archive-plugin
    thunar-volman
  ];
  #security.pam.services.sddm.enableKwallet = true;
  #security.pam.services.sddm = {
  #  enableKwallet = true;
  #  text = ''
  #    auth include login
  #  '';
  #};
  #security.pam.services.kwallet = {
  #  name = "kwallet";
  #  enableKwallet = true;
  #};

  #security.pam.services.root99.enableKwallet = true;
  
  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
  };

  qt = {
    enable = true;
    platformTheme = "qt5ct";
    style = "kvantum";
  };

    
  /*home-manager.users.gmartins = {

    # This home-manager config should set the values per user
    # But it has not effect. The system wide `qt` block above sets the environment variables,
    # this home-manager one does not.
    qt = {
      enable = true;
      platformTheme.name = "qtct";
      style.name = "kvantum";
    };
    
    xdg.configFile."Kvantum/kvantum.kvconfig".source = (pkgs.formats.ini {}).generate "kvantum.kvconfig" {
      General.theme = "catppuccin-frappe-blue";
    };

    xdg.configFile."qt5ct/qt5ct.conf".source = (pkgs.formats.ini {}).generate "kvantum.kvconfig" {
      Appearance.icon_theme = "Nordic-darker";
    };
  };*/


  programs.dconf.enable = true;
  

  programs.nautilus-open-any-terminal = {
    enable = true;
    terminal = "alacritty";
  };

  xdg.portal.extraPortals = [pkgs.xdg-desktop-portal-gtk ];
  xdg.portal.enable = true;

  systemd = {
    user.services.polkit-gnome-authentication-agent-1 = {
      description = "polkit-gnome-authentication-agent-1";
      wantedBy = ["graphical-session.target"];
      wants = ["graphical-session.target"];
      after = ["graphical-session.target"];
      serviceConfig = {
        Type = "simple";
        ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
        Restart = "on-failure";
        RestartSec = 1;
        TimeoutStopSec = 10;
      };
    };
  };
}
