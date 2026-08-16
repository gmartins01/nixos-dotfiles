{
  inputs,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    yazi # terminal file explorer
    tmux
    btop

    matugen

    smartmontools
    ddrescue
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
