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

    libsForQt5.gwenview # image viewer

    nautilus

    # Dolphin file manager
    kdePackages.dolphin
    kdePackages.kdegraphics-thumbnailers
    kdePackages.qtimageformats
    kdePackages.ffmpegthumbs
    kdePackages.qtsvg
    kdePackages.kservice # to fix opening files with default applications
    libexif

  ];

  programs.firefox.enable = true;


  programs.dconf.enable = true;
  
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
