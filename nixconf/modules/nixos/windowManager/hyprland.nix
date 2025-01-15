{ inputs, config, pkgs, lib, ... }: {
  programs.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
  };

  environment.systemPackages = with pkgs; [
    hyprpanel
    hyprpaper
    wl-clipboard
    wl-clip-persist
    clipse

    qt6Packages.qt6ct
    qt6.qtwayland
    qt5.qtwayland

    libsForQt5.kservice # to fix opening files with default applications
  ];

  services.gnome.gnome-keyring.enable = true;
  security.pam.services.sddm.enableGnomeKeyring = true;
  environment.sessionVariables = { NIXOS_OZONE_WL = "1"; };
}
