{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./syncthing.nix
    ./flatpak.nix
  ];

  services.xserver.excludePackages = [pkgs.xterm];

  services = {
    # needed for GNOME services outside of GNOME Desktop
    dbus.packages = with pkgs; [
      gcr
      gnome-settings-daemon
    ];

    # Mount, trash, and other functionalities
    gvfs.enable = true;
  };
}

