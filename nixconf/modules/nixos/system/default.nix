{ config, pkgs, ... }:

{
  imports = [
    ./bluetooth.nix
    ./audio.nix
    ./razer.nix
    ./utils.nix
  ];

}

