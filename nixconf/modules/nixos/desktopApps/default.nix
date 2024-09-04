{ pkgs, lib, ... }:

{
  imports = [
  ];

  environment.systemPackages = with pkgs; [
    vesktop
    keepassxc
    vscode
    xwaylandvideobridge
    corectrl
  ];
  
  programs.firefox.enable = true;

  services.flatpak.enable = true;
}