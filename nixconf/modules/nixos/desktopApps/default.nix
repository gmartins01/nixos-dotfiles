{ pkgs, lib, ... }:

{
  imports = [
  ];

  environment.systemPackages = with pkgs; [
    vesktop
    discord
    keepassxc
    vscode
    xwaylandvideobridge
    corectrl
    ffmpeg
    unzip
    zip
  ];
  
  programs.firefox.enable = true;

  services.flatpak.enable = true;
}