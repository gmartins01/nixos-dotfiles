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

  networking.wireguard.enable = true;
  networking.firewall.checkReversePath = false; # required for WG

  environment.systemPackages = with pkgs; [
    networkmanagerapplet
    wireguard-ui
    #protonvpn-gui

    #openresolv
    openvpn
    #networkmanager-openvpn

    wireguard-tools
    wg-netmanager
  ];


  # enable NAT
  networking.nat.enable = true;
  networking.nat.externalInterface = "eth0";
  networking.nat.internalInterfaces = [ "wg0" ];

}
