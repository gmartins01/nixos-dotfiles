{
  lib,
  pkgs,
  inputs,
  config,
  ...
}: {
  imports = [
    ./vscode.nix
    ./nautilus.nix
    ./dconf.nix
    ./docker.nix
  ];

  environment.systemPackages = with pkgs; [
    alacritty
    kitty

    vesktop
    discord
    keepassxc
    #jetbrains.idea-ultimate
    #xwaylandvideobridge
    #corectrl
    vlc
    mediawriter
    gnome-calculator
    handbrake
    easyeffects
    #vscode
    stremio
    obs-studio

    xsettingsd
    xorg.xrdb

    #kdePackages.ark # File archiver
    file-roller

    kdePackages.okular # Document viewer (PDFs)

    kdePackages.gwenview # Image viewer

    ffmpegthumbnailer # Video thumbnails

    gnome-software # Software store (flatpaks)

    gnome-disk-utility # Disk utility

    qbittorrent

    obsidian # Notes

    onlyoffice-desktopeditors
  ];

  programs.firefox.enable = true;
}
