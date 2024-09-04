{ config, pkgs, ... }:

{
  imports = [
    ./bluetooth.nix
    ./audio.nix
  ];

}