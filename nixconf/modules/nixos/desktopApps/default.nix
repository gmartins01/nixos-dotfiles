{ pkgs, lib, ... }:

{
  imports = [
    
  ];

  environment.systemPackages = with pkgs; [
    vesktop
    discord
    keepassxc
    vscode
    jetbrains.idea-ultimate
    xwaylandvideobridge
    corectrl
    vlc
  ];
  
  programs.firefox.enable = true;

}