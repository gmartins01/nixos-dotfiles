{
  pkgs,
  inputs,
  lib,
  ...
}: let
  quickshell = inputs.quickshell.packages.${pkgs.stdenv.hostPlatform.system}.default;
in {
  imports = [
    inputs.niri.homeModules.niri
    inputs.dankMaterialShell.homeModules.dank-material-shell
    inputs.dankMaterialShell.homeModules.dankMaterialShell.niri
    inputs.dsearch.homeModules.default
  ];

  programs.dank-material-shell = {
    enable = true;
    quickshell.package = quickshell;
    # niri = {
    #   enableKeybinds = true; # Automatic keybinding configuration
    #   enableSpawn = true; # Auto-start DMS with niri
    # };
  };

  programs.dsearch.enable = true;

  home.packages = with pkgs; [
    # quickshell
    adw-gtk3
    bibata-cursors
    pkgs.xdg-user-dirs
    pkgs.kdePackages.qt5compat
    pkgs.kdePackages.qtdeclarative
    pkgs.cliphist
    pkgs.nwg-look
    pkgs.hyprpicker
    pkgs.zenity
    #pkgs.wallust
  ];

  home.sessionVariables.QML2_IMPORT_PATH = lib.concatStringsSep ":" [
    #   "${quickshell}/lib/qt-6/qml"
    #   "${pkgs.kdePackages.qtdeclarative}/lib/qt-6/qml"
    #   "${pkgs.kdePackages.qt5compat}/lib/qt-6/qml"
    #   "${quickshell}/lib/qml"
    #   "${pkgs.kdePackages.qtstyleplugin-kvantum}/lib/qt-6/qml"
    #   "${pkgs.libsForQt5.qtstyleplugin-kvantum}/lib/qt-6/qml"
    "${pkgs.kdePackages.qtpositioning}/lib/qt-6/qml"
    "${pkgs.libsForQt5.qt5.qtpositioning}/lib/qt-6/qml"
  ];
}
