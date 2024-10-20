{ config,lib, pkgs, ... }:

{

  options = {
    plasma.enable = lib.mkEnableOption "Enable Plasma";
  };

  config = lib.mkIf config.plasma.enable {
    programs.plasma = {
      enable = true;

      workspace = {
        lookAndFeel = "org.kde.breezedark.desktop";
        colorScheme = "Layan";
        cursor = {
          theme = "Breeze";
          size = 24;
        };
        iconTheme = "Papirus-Dark";
      };

      shortcuts = {
        "services/org.kde.konsole.desktop"."_launch" = ["Meta+Return" "Ctrl+Alt+T"];
        "services/plasma-manager-commands.desktop"."launch-konsole" = "Meta+Return";
        "kwin"."Window Close" = ["Meta+C" "Alt+F4,Alt+F4,Close Window"];
        "plasmashell"."show-on-mouse-pos" = "Meta+V";
        "services/org.kde.krunner.desktop"."RunClipboard" = ["Alt+Shift+F2" ];
        "services/org.kde.krunner.desktop"."_launch" = ["Alt+Space" "Meta+R"];

      };

      krunner = {
        position = "center";        
        historyBehavior = "enableSuggestions";
        
      };

      spectacle = {
        shortcuts = {
          captureActiveWindow = "Meta+Print";
          captureCurrentMonitor = "Print";
          captureEntireDesktop = "Shift+Print";
          captureRectangularRegion = "Meta+Shift+Print";
          captureWindowUnderCursor = "Meta+Ctrl+Print";
          launch = "Meta+Shift+S";
          launchWithoutCapturing = "Meta+Alt+S";
          recordRegion = "Meta+Shift+R";
          recordScreen = "Meta+Alt+R";
          recordWindow = "Meta+Ctrl+R";
        };
      };
      
      windows = {
        allowWindowsToRememberPositions = true;
      };

      /*panels = [
        {
          location = "bottom";
          floating = true;
          hiding = "none";
          screen = 0;
          widgets = [
            {
              kickoff = {
                sortAlphabetically = true;
                icon = "nix-snowflake";
              };
            }

            {
              iconTasks = {
                launchers = [
                  "applications:org.kde.dolphin.desktop"
                  "applications:org.keepassxc.KeePassXC.desktop"
                  "applications:firefox.desktop"
                  "applications:code.desktop"
                  "applications:org.kde.konsole.desktop"
                ];
              };
            }

            "org.kde.plasma.marginsseparator"
            
            {
              systemTray.items = {
                shown = [
                  "org.kde.plasma.networkmanagement"
                  "org.kde.plasma.volume"
                
                ];

                hidden = [  
                  "org.kde.plasma.clipboard"
                  "org.kde.plasma.battery"
                  "org.kde.plasma.brighness"
                  "org.kde.plasma.notifications"
                  "org.kde.plasma.printmanager"
                  "org.kde.plasma.removabledevices"
                  "org.kde.plasma.mediacontroller"
                  "org.kde.plasma.kdeconnect"
                  "org.kde.kscreen"
                  "org.kde.plasma.devicenotifier"
                  "org.kde.plasma.manage-inputmethod"
                  "org.kde.plasma.lockkeystatus"
                ];

              };
            }

            {
              digitalClock = {
                cale  ndar.firstDayOfWeek = "monday";
                time.format = "24h";
              };
            }
          ];
          
        }
      ];*/

    };
  };

}