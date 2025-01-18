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
  ];

  programs.firefox.enable = true;

}
