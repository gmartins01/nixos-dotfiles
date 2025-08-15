{
  config,
  inputs,
  pkgs,
  ...
}: {
  imports = [
    ./hyprland.nix
    ./awesome.nix
  ];

  environment.systemPackages = with pkgs; [
  ];

  programs.niri.enable = true;
}
