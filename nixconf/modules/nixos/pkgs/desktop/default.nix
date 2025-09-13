{
  lib,
  pkgs,
  inputs,
  config,
  pkgs-stable,
  ...
}: {
  imports = [
    #./vscode.nix
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
    #handbrake
    easyeffects
    vscode
    # stable.stremio
    obs-studio

    xsettingsd
    xorg.xrdb

    #kdePackages.ark # File archiver
    file-roller

    kdePackages.okular # Document viewer (PDFs)

    kdePackages.gwenview # Image viewer
    loupe

    ffmpegthumbnailer # Video thumbnails

    gnome-software # Software store (flatpaks)

    gnome-disk-utility # Disk utility

    qbittorrent

    obsidian # Notes

    onlyoffice-desktopeditors

    gpu-screen-recorder-gtk # GUI app
  ];

  programs.firefox.enable = true;

  programs.gpu-screen-recorder.enable = true;
}
