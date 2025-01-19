{ config, pkgs, inputs, lib, ... }:
let
  variant = "frappe";
  accent = "lavender";
  kvantumThemePackage = pkgs.catppuccin-kvantum.override {
    inherit variant accent;
  };
in
{
  imports =
    [
      ./../../modules/home-manager/default.nix
    ];

  home.username = "gmartins";
  home.homeDirectory = "/home/gmartins";

  fish.enable = false;

  qt = {
    enable = true;
    #qt5ct
    platformTheme.name = "qt6ct";
    style.name = "kvantum";
  };


  gtk = {
    enable = true;
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

    gtk3.extraConfig = {
      Settings = ''
        gtk-application-prefer-dark-theme=1
      '';
    };

    gtk4.extraConfig = {
      Settings = ''
        gtk-application-prefer-dark-theme=1
      '';
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
    "gtk-4.0/assets".source = "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0/assets";
    "gtk-4.0/gtk.css".source = "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0/gtk.css";
    "gtk-4.0/gtk-dark.css".source = "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0/gtk-dark.css";
     
    "Kvantum/kvantum.kvconfig".text = ''
      [General]
      theme=catppuccin-${variant}-${accent}
    '';

    "Kvantum/catppuccin-${variant}-${accent}".source = "${kvantumThemePackage}/share/Kvantum/catppuccin-${variant}-${accent}";

    "menus/applications.menu".text = builtins.readFile ./applications.menu;
  };
  
  home.pointerCursor = {
    name = "Bibata-Modern-Ice";
    package = pkgs.bibata-cursors;
    size = 26;
    gtk.enable = true;
  };
  
  

  home.stateVersion = "24.05"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
  ];


  #fonts.fontconfig.enable = true;

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/gmartins/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    #QT_QPA_PLATFORMTHEME="qt6ct";
    #QT_STYLE_OVERRIDE="kvantum";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;


}
