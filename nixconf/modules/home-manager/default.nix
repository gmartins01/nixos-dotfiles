{ pkgs, lib, ... }:

{
  imports = [
    ./git
    ./shell/fish.nix
    ./shell/starship.nix
    ./shell/zsh.nix
  ];

  fish.enable = lib.mkDefault true;
  zsh.enable = lib.mkDefault true;
  starship.enable = lib.mkDefault true;

}