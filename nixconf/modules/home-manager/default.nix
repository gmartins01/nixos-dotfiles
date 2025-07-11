{
  pkgs,
  lib,
  ...
}: {
  imports = [
    ./git
    ./shell/fish.nix
    ./shell/starship.nix
    ./shell/zsh.nix
    ./features/ags
    ./features/hyprland
    ./features/stylix
    ./pkgs
    ./features/gtk.nix
    #./plasma
  ];

  fish.enable = lib.mkDefault true;
  zsh.enable = lib.mkDefault true;
  starship.enable = lib.mkDefault true;
  #plasma.enable = lib.mkDefault true;
}
