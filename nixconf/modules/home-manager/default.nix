{
  pkgs,
  lib,
  ...
}: {
  imports = [
    ./git
    ./features/ags
    ./features/hyprland
    ./features/stylix
    ./programs
    # ./features/gtk.nix
     # ./features/qt.nix
    ./features/quickshell.nix
    #./plasma
  ];

  #plasma.enable = lib.mkDefault true;
}
