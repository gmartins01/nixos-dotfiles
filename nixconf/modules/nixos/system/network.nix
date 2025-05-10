{
  config,
  pkgs,
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

  networking.networkmanager.wifi.backend = "iwd";
  
 /* networking.wireless.iwd.enable = true;

  networking.wireless.iwd.settings = {
    # veja “man iwd.config” para as seções e chaves válidas
    General = {
      DisableScanning = true; # desativa o scan de background
      AutoEnable = true; # reconecta redes conhecidas
    };
    # por exemplo, ativa IPv6 e auto-connect
    Network = {
      EnableIPv6 = true;
    };
    Settings = {
      AutoConnect = true;
    };
  };*/
  networking.wireguard.enable = true;
  networking.firewall.checkReversePath = false; # required for WG

  environment.systemPackages = with pkgs; [
    networkmanagerapplet
    wireguard-ui
    #protonvpn-gui

    #openresolv
    openvpn
    #networkmanager-openvpn
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
