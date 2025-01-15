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
    (python3.withPackages (ps: with ps; [
      pip
      requests
    ]))
  ];


}
