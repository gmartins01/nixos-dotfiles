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

    unsmall.neovim
    lua54Packages.luarocks-nix
    lua
    tree-sitter

    x265
    intel-vaapi-driver
  ];

  #programs.java.enable = true;

  # programs.neovim.enable = true;
  # programs.neovim.defaultEditor = true;
  # programs.neovim.package = pkgs.unsmall.neovim;

  programs.nix-ld = {
    enable = true;
    libraries = with pkgs; [
      stdenv.cc.cc
      brotli
      glib
      unixODBC
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
