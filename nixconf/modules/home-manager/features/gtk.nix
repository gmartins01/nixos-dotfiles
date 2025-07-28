{
  lib,
  pkgs,
  config,
  ...
}: {
  home.pointerCursor = {
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Ice";
    size = 24;
    gtk.enable = true;
    x11.enable = true;
  };

  gtk = {
    enable = true;

    gtk2.configLocation = "${config.xdg.configHome}/gtk-2.0/gtkrc";

    theme = {
      name = "adw-gtk3-dark";
      package = pkgs.adw-gtk3;
    };

    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };

    font = {
      name = "Sans";
      size = 10;
    };

    gtk3.bookmarks = [
      "file:///home/gmartins/Downloads"
      "file:///home/gmartins/Documents"
      "file:///home/gmartins/Music"
      "file:///home/gmartins/Pictures"
      "file:///home/gmartins/Videos"
    ];
  };

  xdg.configFile."gtk-4.0/gtk.css".enable = lib.mkForce false;
}
