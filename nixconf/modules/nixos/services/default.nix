{ config, pkgs, ... }:

{
  imports = [
    ./syncthing.nix
    ./flatpak.nix
  ];

  services.xserver.excludePackages = [ pkgs.xterm ];

}