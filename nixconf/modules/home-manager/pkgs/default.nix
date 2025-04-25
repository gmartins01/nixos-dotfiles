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
    pkgs.tmux

    pkgs.yazi # terminal file explorer
    pkgs.proton-pass
  ];
}
