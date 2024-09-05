{ pkgs, lib, ... }:

{
  hardware.openrazer.enable = true;
  hardware.openrazer.users = ["gmartins"];

  environment.systemPackages = with pkgs; [
    polychromatic
  ];

}