{
  inputs,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default
    postman
    stable.gimp

    proton-vpn
    proton-pass

    wezterm

    gparted

    spotify

    xdg-desktop-portal-gnome

    stremio-linux-shell

    brave

    portfolio

    komikku
  ];
}
