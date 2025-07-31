{
  pkgs,
  inputs,
  config,
  ...
}: {
  programs.ags = {
    enable = false;

    extraPackages = with pkgs; [
      gtksourceview
      # webkitgtk
      accountsservice
      inputs.ags.packages.${pkgs.system}.hyprland
      inputs.ags.packages.${pkgs.system}.notifd
      inputs.ags.packages.${pkgs.system}.tray
      inputs.ags.packages.${pkgs.system}.apps
      inputs.ags.packages.${pkgs.system}.battery
      inputs.ags.packages.${pkgs.system}.bluetooth
      inputs.ags.packages.${pkgs.system}.mpris
      inputs.ags.packages.${pkgs.system}.cava
      inputs.ags.packages.${pkgs.system}.network
      inputs.ags.packages.${pkgs.system}.powerprofiles
      inputs.ags.packages.${pkgs.system}.wireplumber
    ];
  };
}
