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
  ];
  
  programs.firefox.enable = true;

}