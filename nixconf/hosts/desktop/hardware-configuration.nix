# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "nvme" "usb_storage" "usbhid" "sd_mod" ];
  boot.initrd.kernelModules = [ "amdgpu"];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];
  boot.supportedFilesystems = [ "ntfs" ];
  
  fileSystems."/" =
    { device = "/dev/disk/by-uuid/1cb6c441-d32a-497f-a6f8-4a92d3e00f11";
      fsType = "ext4";
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/F07B-DEE2";
      fsType = "vfat";
      options = [ "fmask=0077" "dmask=0077" ];
    };
  fileSystems."/run/media/gmartins/Backup" =
    { device = "/dev/disk/by-uuid/24AF66E86D22A2B0";
      fsType = "ntfs-3g";
      options = ["rw" "uid=1000" "gid=1000"];
    };
    fileSystems."/run/media/gmartins/Files" =
    { device = "/dev/disk/by-uuid/1EDA5A58DA5A2BF1";
      fsType = "ntfs-3g";
      options = ["rw" "uid=1000" "gid=1000"];
    };

  swapDevices =
    [ { device = "/dev/disk/by-uuid/a5cf0929-1923-4274-9028-af2e58175da5"; }
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
