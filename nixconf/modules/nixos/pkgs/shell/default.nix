{ pkgs, lib, ... }:

{
  imports = [
  ];

  environment.systemPackages = with pkgs; [
    wget
    killall
    eza
    ffmpeg
    unzip
    zip
    p7zip
    unrar
    nfs-utils
    nixpkgs-fmt
    (python3.withPackages (ps: with ps; [
      pip
      requests
    ]))

    gcc

    fastfetch

    ripgrep
  ];


}
