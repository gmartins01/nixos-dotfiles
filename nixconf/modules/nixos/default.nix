{ config, pkgs, ... }:

{
  imports = [
    ./shellPkgs
    ./desktopApps
    ./system
  ];

}