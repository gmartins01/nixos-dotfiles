{ config, pkgs, ... }:

{
  imports = [
    ./syncthing.nix
  ];

  services.flatpak.enable = true;
}