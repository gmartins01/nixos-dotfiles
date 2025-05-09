{pkgs, ...}: {
  virtualisation.docker = {
    enable = true;
    storageDriver = "btrfs";
    rootless = {
      enable = true;
      setSocketVariable = true;
    };
  };

  virtualisation.podman = {
    enable = true;
  };

  environment.systemPackages = with pkgs; [
    docker-compose
    podman-desktop
    distrobox
  ];
}
