{ config, inputs, pkgs, ... }:

{
  imports = [
    ./shell
    ./desktop
  ];

  environment.systemPackages = with pkgs; [
    neovim
    networkmanagerapplet
    pavucontrol
  ];
  
}
