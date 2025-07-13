{
  inputs,
  pkgs,
  lib,
  ...
}: {
  imports = [
    ./fish.nix
    ./zsh.nix
    ./starship.nix
  ];

  fish.enable = lib.mkDefault true;
  zsh.enable = lib.mkDefault true;
  starship.enable = lib.mkDefault true;
}
