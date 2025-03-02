{ config, inputs, pkgs, ... }:

{
  stylix.enable = true;
  #stylix.targets.grub.enable = false;
  #stylix.targets.qt.enable = false;

  stylix.base16Scheme = {
      base00 = "24273a"; # base
      base01 = "1e2030"; # mantle
      base02 = "363a4f"; # surface0
      base03 = "494d64"; # surface1
      base04 = "5b6078"; # surface2
      base05 = "cad3f5"; # text
      base06 = "f4dbd6"; # rosewater
      base07 = "b7bdf8"; # lavender
      base08 = "ed8796"; # red
      base09 = "f5a97f"; # peach
      base0A = "eed49f"; # yellow
      base0B = "a6da95"; # green
      base0C = "8bd5ca"; # teal
      base0D = "8aadf4"; # blue
      base0E = "c6a0f6"; # mauve
      base0F = "f0c6c6"; # flamingo
  };

  stylix.image = ./wallpaper.png;

  stylix.cursor.package = pkgs.bibata-cursors;
  stylix.cursor.name = "Bibata-Modern-Ice";
  stylix.cursor.size = 24;
  
  stylix.targets.qt.enable = false;
  stylix.iconTheme.enable = true;
  stylix.iconTheme.dark = "Papirus-Dark";
  stylix.iconTheme.light = "Papirus";
  stylix.iconTheme.package = pkgs.papirus-icon-theme;
  stylix.targets.gtk.flatpakSupport.enable = false;
  stylix.targets.hyprlock.enable = false;
  
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
