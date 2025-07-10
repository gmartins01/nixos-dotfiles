{
  pkgs,
  lib,
  inputs,
  config,
  ...
}: let
  cursor = config.home.pointerCursor.name;
  cursorPackage = pkgs.bibata-hyprcursor;
in {
  imports = [
    ./modules/monitors.nix
    ./modules/general.nix
    ./modules/input.nix
    ./modules/keybinds.nix
    ./modules/rules.nix
    ./hypridle.nix
    ./hyprlock.nix
    #./hyprpaper.nix
    ./plugins
  ];

  xdg.dataFile."icons/${cursor}-Hyprcursor".source = "${cursorPackage}/share/icons/${cursor}-Hyprcursor";

  wayland.windowManager.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;

    systemd = {
      enable = false;
      variables = ["--all"];
      extraCommands = [
        "systemctl --user stop graphical-session.target"
        "systemctl --user start hyprland-session.target"
      ];
    };

    xwayland.enable = true;

    settings = {
      exec-once = [
        "hyprpanel"
        "hyprpaper"
        "systemctl --user restart xdg-desktop-portal-hyprland"
        "systemctl start --user polkit-gnome-authentication-agent-1"
        "nm-applet --indicator & disown"
        "clipboard-sync &"
        #"clipse -listen"
        "copyq --start-server"
        #"polychromatic-tray-applet"
        # "corectrl &"
        "dconf write /org/gnome/desktop/interface/cursor-theme \"'${cursor}'\""
        "gsettings set org.gnome.desktop.interface cursor-size ${toString config.home.pointerCursor.size}"
        "gsettings set org.gnome.desktop.interface icon-theme ${config.stylix.iconTheme.dark}"
      ];

      env = [
        "XCURSOR_SIZE,${toString config.home.pointerCursor.size}"
        "XCURSOR_THEME,${cursor}"
        "HYPRCURSOR_THEME,${cursor}-Hyprcursor"
        "HYPRCURSOR_SIZE,${toString config.home.pointerCursor.size}"
        "CLUTTER_BACKEND,wayland"
        "GDK_BACKEND,wayland,x11"
        "QT_AUTO_SCREEN_SCALE_FACTOR,1"
        "QT_QPA_PLATFORM,wayland"
        "QT_SCALE_FACTOR,1"
        "QT_WAYLAND_DISABLE_WINDOWDECORATION,1"
        "XDG_CURRENT_DESKTOP,Hyprland"
        "XDG_SESSION_DESKTOP,Hyprland"
        "XDG_SESSION_TYPE,wayland"
      ];

      debug = {
        full_cm_proto = true; # For gamescope
      };
    };
  };

  hyprland.plugins = {
    enable = true;

    csgoVulkanFix.enable = false;
    dynamicCursors.enable = true;
    hyprbars.enable = false;
  };
}
