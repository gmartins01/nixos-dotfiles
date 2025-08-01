# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}: {
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  boot.initrd.availableKernelModules = ["xhci_pci" "ahci" "nvme" "usb_storage" "usbhid" "sd_mod"];
  boot.initrd.kernelModules = ["amdgpu"];
  boot.kernelModules = ["kvm-intel" "tun" "wireguard"];
  boot.extraModulePackages = [];
  boot.supportedFilesystems = ["ntfs"];

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/87ac9cbc-f145-4dd5-89c5-f9070618eed5";
    fsType = "btrfs";
    options = ["subvol=@"];
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/2719-7A48";
    fsType = "vfat";
    options = ["fmask=0077" "dmask=0077"];
  };

  fileSystems."/run/media/gmartins/Media" = {
    device = "/dev/disk/by-uuid/08C7B85A2E313D5C";
    fsType = "ntfs-3g";
    options = ["rw" "uid=1000" "gid=1000" "nofail"];
  };
  fileSystems."/run/media/gmartins/Files" = {
    device = "/dev/disk/by-uuid/1EDA5A58DA5A2BF1";
    fsType = "ntfs-3g";
    options = ["rw" "uid=1000" "gid=1000" "nofail"];
  };
  fileSystems."/run/media/gmartins/Windows" = {
    device = "/dev/disk/by-uuid/E0A6ADAFA6AD871E";
    fsType = "ntfs-3g";
    options = ["rw" "uid=1000" "gid=1000" "nofail"];
  };
  fileSystems."/mnt/Games" = {
    device = "/dev/disk/by-uuid/65D2524E26C8D66D";
    fsType = "ntfs-3g";
    options = ["rw" "uid=1000" "gid=1000" "nofail"];
  };

  swapDevices = [
    {device = "/dev/disk/by-uuid/1ec49d50-356c-403d-aa71-cc970a1df2a5";}
  ];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.enp5s0.useDHCP = lib.mkDefault true;
  # networking.interfaces.wlo1.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
