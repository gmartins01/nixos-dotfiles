{ pkgs, lib, ... }:

{
  imports = [
  ];

  environment.systemPackages = with pkgs; [
    neovim
    wget
    killall
    eza
    ffmpeg
    unzip
    zip
    unrar
    nfs-utils
    nixpkgs-fmt
    pkgs.python3
    pkgs.python312Packages.pip
  ];
  

}