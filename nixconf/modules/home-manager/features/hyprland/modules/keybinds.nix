{ pkgs, lib, config, inputs, ... }:

{

  home.file.".config/hypr/scripts/screenshot.sh" = {
    source = ./../scripts/screenshot.sh;
    executable = true;
  };

  wayland.windowManager.hyprland = {
    settings = {
      "$mainMod" = "SUPER";
      "$shiftMod" = "SUPER SHIFT";
      "$terminal" = "${pkgs.kitty}/bin/kitty";
      "$fileManager" = "${pkgs.nautilus}/bin/nautilus";
      "$menu" = "${pkgs.fuzzel}/bin/fuzzel";

      binds = {
        allow_workspace_cycles = true;
        workspace_back_and_forth = true;
      };

      bindm = [
        # mouse movements
        "$mainMod, mouse:272, movewindow"
        "$mainMod, mouse:273, resizewindow"
      ];

      bind = [
        # Basic keybinds
        "$mainMod, Return, exec, $terminal"
        "$mainMod, C, killactive"
        "$mainMod SHIFT, Q, exit"
        "$mainMod, E, exec, $fileManager"
        "$mainMod, F, togglefloating"
        "$mainMod, M, fullscreen, 1"
        "$shiftMod, M, fullscreen"
        "$mainMod, R, exec, $menu"
        "$shiftMod, P, pseudo"
        "$mainMod, J, togglesplit"

        # Focus movement
        "$mainMod, left, movefocus, l"
        "$mainMod, right, movefocus, r"
        "$mainMod, up, movefocus, u"
        "$mainMod, down, movefocus, d"

        # Workspace controls
        "$mainMod, 1, workspace, 1"
        "$mainMod, 2, workspace, 2"
        "$mainMod, 3, workspace, 3"
        "$mainMod, 4, workspace, 4"
        "$mainMod, 5, workspace, 5"
        "$mainMod, 6, workspace, 6"
        "$mainMod, 7, workspace, 7"
        "$mainMod, 8, workspace, 8"
        "$mainMod, 9, workspace, 9"
        "$mainMod, 0, workspace, 10"

        # Window to workspace
        "$mainMod SHIFT, 1, movetoworkspace, 1"
        "$mainMod SHIFT, 2, movetoworkspace, 2"
        "$mainMod SHIFT, 3, movetoworkspace, 3"
        "$mainMod SHIFT, 4, movetoworkspace, 4"
        "$mainMod SHIFT, 5, movetoworkspace, 5"
        "$mainMod SHIFT, 6, movetoworkspace, 6"
        "$mainMod SHIFT, 7, movetoworkspace, 7"
        "$mainMod SHIFT, 8, movetoworkspace, 8"
        "$mainMod SHIFT, 9, movetoworkspace, 9"
        "$mainMod SHIFT, 0, movetoworkspace, 10"

        "$mainMod, P, pin"

        # Special workspace
        "$mainMod, S, togglespecialworkspace, magic"
        "$mainMod, escape, workspace, previous"

        # Mouse controls
        "$mainMod, mouse_down, workspace, e+1"
        "$mainMod, mouse_up, workspace, e-1"

        # Multimedia keys
        ", XF86AudioRaiseVolume, exec, ${pkgs.pamixer}/bin/pamixer -i 5"
        ", XF86AudioLowerVolume, exec, ${pkgs.pamixer}/bin/pamixer -d 5"
        ", XF86AudioMute, exec, ${pkgs.pamixer}/bin/pamixer --toggle-mute"
        ", XF86AudioMicMute, exec, ${pkgs.pamixer}/bin/pamixer --default-source -t"
        ", XF86MonBrightnessUp, exec, ${pkgs.brightnessctl}/bin/brightnessctl s 10%+"
        ", XF86MonBrightnessDown, exec, ${pkgs.brightnessctl}/bin/brightnessctl s 10%-"

        "SHIFT, XF86AudioRaiseVolume, exec, ${pkgs.pamixer}/bin/pamixer --default-source -i 5"
        "SHIFT, XF86AudioLowerVolume, exec, ${pkgs.pamixer}/bin/pamixer --default-source -d 5"
        "SHIFT, XF86AudioMute, exec, ${pkgs.pamixer}/bin/pamixer --default-source -t"

        # Player controls
        ", XF86AudioNext, exec, ${pkgs.playerctl}/bin/playerctl next"
        ", XF86AudioPause, exec, ${pkgs.playerctl}/bin/playerctl play-pause"
        ", XF86AudioPlay, exec, ${pkgs.playerctl}/bin/playerctl play-pause"
        ", XF86AudioPrev, exec, ${pkgs.playerctl}/bin/playerctl previous"

        # Utilities
        "$mainMod, V, exec, ${pkgs.kitty}/bin/kitty --class clipse -e ${pkgs.clipse}/bin/clipse"
        "ALT, Tab, cyclenext"
        "$shiftMod, E, exec, BEMOJI_PICKER_CMD='fuzzel -d' ${pkgs.bemoji}/bin/bemoji"

        # Screenshots
        "$mainMod, PRINT, exec, ${config.home.homeDirectory}/.config/hypr/scripts/screenshot.sh -m window"
        ", PRINT, exec, ${config.home.homeDirectory}/.config/hypr/scripts/screenshot.sh -m screen"
        "$shiftMod, PRINT, exec, ${config.home.homeDirectory}/.config/hypr/scripts/screenshot.sh -m region"

        # Monitor cycling
        "$mainMod, Tab, focusmonitor, +1"
        "$shiftMod, Tab, focusmonitor, -1"


        # Global keybinds
        "SUPER, F10, pass, class:^(com\.obsproject\.Studio)$"     
      ];
    };
  };
}