{ config, pkgs, ... }:

{
  imports = [
    ./shellPkgs
    ./desktopApps
    ./system
    ./services
    ./windowManager
  ];

}