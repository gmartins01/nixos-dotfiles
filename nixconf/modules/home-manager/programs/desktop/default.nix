{
  inputs,
  pkgs,
  ...
}: {
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

    pkgs.spotify
  ];
}
