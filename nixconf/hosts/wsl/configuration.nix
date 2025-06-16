{
  config,
  lib,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    # include NixOS-WSL modules
    #<nixos-wsl/modules>
    inputs.nixos-wsl.nixosModules.default
  ];

  wsl.enable = true;
  wsl.defaultUser = "gmartins";
  wsl.docker-desktop.enable = true;
  users.users.gmartins.extraGroups = ["docker"];
  virtualisation.docker.enable = true;
  virtualisation.docker.rootless.enable = true;

  environment.systemPackages = with pkgs; [
    git
    wget

    fd

    tmux

    neovim
    lua54Packages.luarocks-nix
    lua

    ripgrep
    gcc
    gnumake

    killall

    ffmpeg
    unzip
    zip

    go
    (python3.withPackages (ps:
      with ps; [
        pip
      ]))
    nodejs_22

    inputs.home-manager.packages.${pkgs.system}.default
  ];

  nix.settings.experimental-features = ["nix-command" "flakes"];

  programs.java.enable = true;

  programs.nix-ld = {
    enable = true;
    libraries = with pkgs; [
      stdenv.cc.cc
    ];
  };

  nix.gc = {
    automatic = true;
    randomizedDelaySec = "14m";
    options = "--delete-older-than 10d";
  };
  nix.settings.auto-optimise-store = true;

  system.stateVersion = "24.11";
}
