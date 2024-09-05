{ config, pkgs, ... }:

{
  imports = [
    ./bluetooth.nix
    ./audio.nix
    ./razer.nix
    ./syncthing.nix
  ];

}
