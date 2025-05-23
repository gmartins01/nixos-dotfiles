{
  config,
  pkgs,
  lib,
  ...
}: {
  networking.hostName = "nixos";
  networking.firewall.allowedTCPPorts = [8384 9999 51820];

  # Enable networking
  networking = {
    resolvconf.enable = true;
    networkmanager = {
      enable = true;
      wifi.powersave = false;
    };
  };

  networking.wireguard.enable = true;
  networking.firewall.checkReversePath = false; # required for WG

  environment.systemPackages = with pkgs; [
    networkmanagerapplet
    networkmanager
    wireguard-ui
    #protonvpn-gui

    openvpn
    networkmanager

    wireguard-tools
    wg-netmanager
  ];

  # enable NAT
  networking.nat.enable = true;
  networking.nat.externalInterface = "eth0";
  networking.nat.internalInterfaces = ["wg0"];
  boot.kernel.sysctl = {
    "net.core.default_qdisc" = "fq_codel";
    "net.ipv4.tcp_congestion_control" = "bbr";
    "net.ipv6.tcp_congestion_control" = "bbr";
  };
}
