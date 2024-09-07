{ pkgs, lib, ... }:

{
  imports = [
  ];

  environment.systemPackages = with pkgs; [
    neovim
    wget
    killall
    eza
    unzip
    unrar
  ];
  

}