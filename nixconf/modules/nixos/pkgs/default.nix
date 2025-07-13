{
  config,
  inputs,
  pkgs,
  ...
}: {
  imports = [
    ./shell
    ./desktop
  ];

  environment.systemPackages = with pkgs; [
    networkmanagerapplet
    pavucontrol

    home-manager

    neovim
    lua54Packages.luarocks-nix
    lua

    x265
    intel-vaapi-driver
  ];

  programs.java.enable = true;

  programs.neovim.enable = true;
  programs.neovim.defaultEditor = true;

  programs.nix-ld = {
    enable = true;
    libraries = with pkgs; [
      stdenv.cc.cc
      brotli
      glib
      /*
        libGL
      libva
      openssl
      glib
      libusb1
      dbus-glib
      */
    ];
  };
}
