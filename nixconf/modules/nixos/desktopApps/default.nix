{ pkgs, lib, ... }:

{
  imports = [
    ./vscode.nix
  ];

  environment.systemPackages = with pkgs; [
    vesktop
    discord
    keepassxc
    jetbrains.idea-ultimate
    xwaylandvideobridge
    corectrl
    vlc
    mediawriter
    kdePackages.kalk
    megasync
    handbrake
    easyeffects
    #vscode
    stremio

    xsettingsd
    xorg.xrdb

    nautilus

    # Dolphin file manager
    kdePackages.dolphin
    kdePackages.kdegraphics-thumbnailers
    kdePackages.qtimageformats
    kdePackages.ffmpegthumbs
    kdePackages.qtsvg
    kdePackages.kservice # to fix opening files with default applications
    libexif

    # File archiver
    kdePackages.ark

    # Document viewer (PDFs)
    kdePackages.okular

    # Image viewer
    kdePackages.gwenview 
  ];

  programs.firefox.enable = true;

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
        };
      }
    ];
  };

  # Thunar file manager
  programs.thunar.enable = true;
  programs.xfconf.enable = true;
  programs.thunar.plugins = with pkgs.xfce; [
    thunar-archive-plugin
    thunar-volman
  ];

  # Open alacrity terminal in nautilus
  programs.nautilus-open-any-terminal = {
    enable = true;
    terminal = "alacritty";
  };
}
