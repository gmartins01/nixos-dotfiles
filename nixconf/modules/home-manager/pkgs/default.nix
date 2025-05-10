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
    pkgs.gimp3

    pkgs.proton-pass

    pkgs.ghostty
    pkgs.yazi # terminal file explorer
    pkgs.tmux
    pkgs.btop
  ];
}
