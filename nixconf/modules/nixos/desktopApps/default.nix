{ pkgs, lib, ... }:

{
  imports = [
    ./vscode.nix
    ./nautilus.nix
  ];

  environment.systemPackages = with pkgs; [
    alacritty
    
    vesktop
    discord
    keepassxc
    jetbrains.idea-ultimate
    #xwaylandvideobridge
    corectrl
    vlc
    mediawriter
    gnome-calculator
    megasync
    handbrake
    easyeffects
    #vscode
    stremio

    xsettingsd
    xorg.xrdb

    # Dolphin file manager
    kdePackages.dolphin
    kdePackages.kdegraphics-thumbnailers
    kdePackages.qtimageformats
    kdePackages.ffmpegthumbs
    kdePackages.qtsvg
    kdePackages.kservice # to fix opening files with default applications
    libexif

    kdePackages.ark # File archiver

    kdePackages.okular # Document viewer (PDFs)

    kdePackages.gwenview # Image viewer

    ffmpegthumbnailer # Video thumbnails

    komikku # Comics reader

    qbittorrent

    obsidian # Notes
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

}
