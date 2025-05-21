{
  config,
  pkgs,
  inputs,
  lib,
  ...
}: {
  imports = [
    ../../modules/home-manager/shell/starship.nix
    ../../modules/home-manager/shell/zsh.nix
  ];

  home.username = "gmartins";
  home.homeDirectory = "/home/gmartins";

  home.packages = with pkgs; [
  ];

  home.file = {
    "SDKs/Java/21".source = pkgs.jdk21;
    "SDKs/Java/17".source = pkgs.jdk17;
    "SDKs/Java/8".source = pkgs.jdk8;
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  starship.enable = true;

  zsh = {
    enable = true;
    host = "wsl";
  };

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
    config = {
      global = {
        hide_env_diff = true;
      };
    };
  };

  home.stateVersion = "24.11";
}
