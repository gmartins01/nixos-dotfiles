{
  config,
  pkgs,
  lib,
  ...
}: {
  # Bootloader.
  boot.loader.systemd-boot.enable = false;
  boot.supportedFilesystems = ["ntfs"];

  boot.loader.grub.enable = true;
  boot.loader.grub.device = "nodev";
  boot.loader.grub.useOSProber = true;
  boot.loader.grub.efiSupport = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot";
  boot.loader.grub.theme = pkgs.catppuccin-grub;
  boot.kernelParams = ["amdgpu.ppfeaturemask=0xffffffff"]; # Corectrl
  boot.kernelPackages = pkgs.linuxPackages_cachyos;
  #boot.kernelPackages = pkgs.linuxPackages_latest;
  /*
    boot.extraModulePackages = [
    (amdgpu-kernel-module.overrideAttrs (_: {
      patches = [./amdgpu-revert.patch];
    }))
  ];
  */
  #boot.extraModprobeConfig = ''
  #  options snd_hda_intel power_save=0
  #'';
}
