{
  inputs,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    inputs.zen-browser.packages.${pkgs.system}.default
    pkgs.postman
    pkgs.stable.gimp

    pkgs.proton-pass

    pkgs.wezterm

    pkgs.gparted

    pkgs.spotify
  ];
}
