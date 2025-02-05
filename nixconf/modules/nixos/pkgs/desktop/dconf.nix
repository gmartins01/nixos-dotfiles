{ lib, ... }:

{

  programs.dconf = {
    enable = true;

    profiles.user.databases = [
      {
        # remove close buttons
        # To reset: dconf reset /org/gnome/desktop/wm/preferences/button-layout
        settings = with lib.gvariant; {
          "org/gnome/desktop/wm/preferences" = {
             button-layout = "''";
          };
          "com/github/stunkymonkey/nautilus-open-any-terminal".terminal = "alacritty";
        };
      }
    ];
  };

}
