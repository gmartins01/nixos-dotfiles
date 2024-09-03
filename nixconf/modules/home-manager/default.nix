{ pkgs, lib, ... }:

{
  imports = [
    ./git
    ./shell/fish.nix
    ./shell/starship.nix
  ];

  fish.enable = lib.mkDefault true;
  starship.enable = lib.mkDefault true;

}