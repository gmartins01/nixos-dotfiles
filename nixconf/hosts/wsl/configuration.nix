{ config, lib, pkgs, inputs, ... }:

{
  imports = [
    # include NixOS-WSL modules
    #<nixos-wsl/modules>
    inputs.nixos-wsl.nixosModules.default
  ];

  wsl.enable = true;
  wsl.defaultUser = "gmartins";

  environment.systemPackages = with pkgs; [
    git
    
    neovim
    lua54Packages.luarocks-nix
    lua

    ripgrep
    gcc
    gnumake

    killall
    eza
    ffmpeg
    unzip
    zip

    go
    (python3.withPackages (ps: with ps; [
      pip
    ]))
    nodejs_22
  ];

  programs.java.enable = true;

  programs.nix-ld = {
    enable = true;
    libraries = with pkgs; [
      stdenv.cc.cc
    ];
  };

  system.stateVersion = "24.11";
}
