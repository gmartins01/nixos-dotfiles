{ config, inputs, pkgs, ... }:

{
  imports = [
    ./shell
    ./desktop
  ];

  environment.systemPackages = with pkgs; [
    networkmanagerapplet
    pavucontrol

    home-manager

    neovim
    lua54Packages.luarocks-nix
    lua
  ];

  programs.nix-ld = {
    enable = true;
    libraries = with pkgs; [
      stdenv.cc.cc
    ];
  };
}
