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
    vlc
  ];
  
  programs.firefox.enable = true;

}