{ config, inputs, pkgs, ... }:

{
  imports = [
    ./shell
    ./desktop
  ];

  environment.systemPackages = with pkgs; [
    networkmanagerapplet
  ];
  
}
