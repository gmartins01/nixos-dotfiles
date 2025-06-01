{
  pkgs,
  inputs,
  config,
  ...
}: {
  programs.ags = {
    enable = true;

    extraPackages = with pkgs; [
      gtksourceview
      webkitgtk
      accountsservice
      inputs.ags.packages.${pkgs.system}.hyprland
    ];
  };
}
