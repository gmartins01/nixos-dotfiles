{ config, inputs, pkgs, ... }:

{
  imports = [
    ./shellPkgs
    ./desktopApps
    ./system
    ./services
    ./windowManager
    ./styles
  ];

}
