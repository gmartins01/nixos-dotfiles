{
  pkgs,
  inputs,
  lib,
  ...
}: let
  quickshell = inputs.quickshell.packages.${pkgs.system}.default;
in {
  home.packages = [quickshell pkgs.xdg-user-dirs pkgs.kdePackages.kdialog pkgs.kdePackages.qt5compat pkgs.kdePackages.qtdeclarative pkgs.cliphist];

  home.sessionVariables.QML2_IMPORT_PATH = lib.concatStringsSep ":" [
    "${quickshell}/lib/qt-6/qml"
    "${pkgs.kdePackages.qtdeclarative}/lib/qt-6/qml"
    "${pkgs.kdePackages.qt5compat}/lib/qt-6/qml"
    "${quickshell}/lib/qml"
    "${pkgs.kdePackages.qtstyleplugin-kvantum}/lib/qt-6/qml"
    "${pkgs.libsForQt5.qtstyleplugin-kvantum}/lib/qt-6/qml"
    "${pkgs.kdePackages.qtpositioning}/lib/qt-6/qml"
    "${pkgs.libsForQt5.qt5.qtpositioning}/lib/qt-6/qml"
  ];
}
