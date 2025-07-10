{
  inputs,
  pkgs,
  ...
}: {
  nixpkgs.config = {
    allowUnfree = true;
  };

  home.packages = [
    inputs.zen-browser.packages.${pkgs.system}.default
    pkgs.postman
    pkgs.gimp

    pkgs.proton-pass

    pkgs.yazi # terminal file explorer
    pkgs.tmux
    pkgs.btop

    pkgs.wezterm

    pkgs.gparted

    pkgs.bibata-cursors
  ];

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
    config = {
      global = {
        hide_env_diff = true;
      };
    };
  };
}
