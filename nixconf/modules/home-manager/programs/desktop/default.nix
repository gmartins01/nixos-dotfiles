{
  inputs,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    inputs.zen-browser.packages.${pkgs.system}.default
    postman
    stable.gimp

    proton-pass

    wezterm

    gparted

    spotify

    xdg-desktop-portal-gnome
  ];
}
