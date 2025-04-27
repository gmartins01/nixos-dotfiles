{
  pkgs,
  lib,
  config,
  ...
}: {
  wayland.windowManager.hyprland = {
    settings = {
      windowrule = [
        # "Smart gaps" / "No gaps when only"
        "bordersize 0, floating:0, onworkspace:f[1]"
        "rounding 0, floating:0, onworkspace:f[1]"

        # Ignore maximize requests from apps. You'll probably like this.
        "suppressevent maximize, class:.*"

        # Fix some dragging issues with XWayland
        "nofocus,class:^$,title:^$,xwayland:1,floating:1,fullscreen:0,pinned:0"

        # Apps
        "float,class:^(org.kde.okular)$"
        "float,class:^(firefox)$,title:^(Library)$" # Float the Library window in Firefox (Bookmars, history, etc)
        "float,class:^(org.gnome.Calculator)$"
        "float,class:^(thunar)$,title:^(File Operation Progress)$"
        "float,class:^(nemo)$,title:^(.*Properties.*)$"
        "float,class:^(fr.handbrake.ghb)$"
        "size 400 600,class:^(protonvpn-app)$,title:^(Proton VPN)$"

        # Clipboard
        "float, class:(clipse)"
        "size 622 652, class:(clipse)"

        #Steam
        "float,class:^(steam)$,title:^(Friends List)$"
        "size 350 600,class:^(steam)$,title:^(Friends List)$"

        # Games
        "tile,class:^(PokeMMO)$"
        "maximize,class:^(PokeMMO)$"
      ];
    };
  };
}
