{ pkgs, lib, inputs, ... }:

{
  imports = [
    ./monitors.nix
    ./general.nix
    ./input.nix
    ./keybinds.nix
    ./rules.nix
  ];

  services.hypridle = {
    enable = true;
    package = inputs.hypridle.packages.${pkgs.system}.hypridle;
   
  };
  
  wayland.windowManager.hyprland = {
    enable = true;
    package = null;
    portalPackage = null;
    
    systemd.variables = ["--all"];

    xwayland.enable = true;
    /*plugins = [
      inputs.hyprland-plugins.packages.${pkgs.stdenv.hostPlatform.system}.csgo-vulkan-fix
    ];*/

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


     /* "plugin:csgo-vulkan-fix" = {
        res_w = 1920;
        res_h = 1080;

        # NOT a regex! This is a string and has to exactly match initial_class
        class = "cs2";

        # Whether to fix the mouse position. A select few apps might be wonky with this.
        fix_mouse = true;
      };*/


    };

  };

}
