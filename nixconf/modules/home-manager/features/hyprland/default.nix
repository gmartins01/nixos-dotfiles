{ pkgs, lib, inputs, ... }:

{
  imports = [
    ./modules/monitors.nix
    ./modules/general.nix
    ./modules/input.nix
    ./modules/keybinds.nix
    ./modules/rules.nix
    ./hypridle.nix
    ./hyprlock.nix
    ./plugins
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    package = null;
    portalPackage = null;
    
    systemd.variables = ["--all"];

    xwayland.enable = true;

    settings = {
      exec-once = [
        "hyprpanel"
        "hyprpaper"
        "systemctl --user restart xdg-desktop-portal-hyprland"
        "systemctl start --user polkit-gnome-authentication-agent-1"
        "nm-applet --indicator & disown"
        "clipboard-sync &"
        "clipse -listen"
        "polychromatic-tray-applet"
        "corectrl &"
      ];

      env = [
        "XCURSOR_SIZE, 24"
        "HYPRCURSOR_SIZE, 24"
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
    };

  };

  hyprland.plugins = {
    enable = false; 
    
    csgoVulkanFix.enable = false;
    dynamicCursors.enable = true;
  };

}
