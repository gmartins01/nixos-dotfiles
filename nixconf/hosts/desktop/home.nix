{
  config,
  pkgs,
  inputs,
  lib,
  ...
}: let
  variant = "macchiato";
  accent = "lavender";
  kvantumThemePackage = pkgs.catppuccin-kvantum.override {
    inherit variant accent;
  };
in {
  imports = [
    ./../../modules/home-manager/default.nix
  ];

  home.username = "gmartins";
  home.homeDirectory = "/home/gmartins";

  fish.enable = false;

  /*
    qt = {
    enable = true;
    platformTheme.name = "kde";
  };
  */

  gtk = {
    enable = true;
    /*
      font.name = "TeX Gyre Adventor 10";
    theme = {
      name = "catppuccin-${variant}-${accent}-standard";
      package = pkgs.catppuccin-gtk
      .override
        {
          accents = [ accent ];
          variant = variant;
          size = "standard";
        };
    };
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };
    */
    /*
     iconTheme = {
      package = pkgs.adwaita-icon-theme;
      name = "Adwaita";
    };
    */

    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
    };

    gtk4.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
    };

    gtk3.bookmarks = [
      "file:///home/gmartins/Downloads"
      "file:///home/gmartins/Documents"
      "file:///home/gmartins/Music"
      "file:///home/gmartins/Pictures"
      "file:///home/gmartins/Videos"
    ];
  };

  xdg.configFile = {
    /*
      "gtk-4.0/assets".source = "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0/assets";
    "gtk-4.0/gtk.css".source = "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0/gtk.css";
    "gtk-4.0/gtk-dark.css".source = "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0/gtk-dark.css";
    */

    "Kvantum/kvantum.kvconfig".text = ''
      [General]
      theme=catppuccin-${variant}-${accent}
    '';

    "Kvantum/catppuccin-${variant}-${accent}".source = "${kvantumThemePackage}/share/Kvantum/catppuccin-${variant}-${accent}";
  };

  /*
    home.pointerCursor = {
    name = "Bibata-Modern-Ice";
    package = pkgs.bibata-cursors;
    size = 24;
    gtk.enable = true;
  };
  */

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
  ];

  #fonts.fontconfig.enable = true;
  xdg.mime.enable = true;
  xdg = {
    mimeApps.enable = false;
    mimeApps.defaultApplications = {
      "inode/directory" = ["org.gnome.Nautilus.desktop"];
      "text/plain" = ["code.desktop"];
      "application/xml" = ["code.desktop"];
      "image/jpeg" = ["org.kde.gwenview.desktop"];
      "image/png" = ["org.kde.gwenview.desktop"];
    };
  };

  home.file.".local/share/flatpak/overrides/global".text = let
    dirs = [
      "/nix/store:ro"
      "xdg-config/gtk-3.0:ro"
      "xdg-config/gtk-4.0:ro"
      "${config.xdg.dataHome}/icons:ro"
    ];
  in ''
    [Context]
    filesystems=${builtins.concatStringsSep ";" dirs}
  '';

  home.sessionVariables = {
    #QT_QPA_PLATFORMTHEME="kde";
    TERM = "kitty";
    TERMINAL = "kitty";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  home.stateVersion = "24.05";

  home.file = {
    "SDKs/Java/17".source = pkgs.jdk17;
    "SDKs/Java/8".source = pkgs.jdk8;
  };
}
