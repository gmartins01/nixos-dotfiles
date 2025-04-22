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

  /*
  security.enableWrappers = true;

  security.wrappers.openvpn = {
    enable = true;
    source = "${pkgs.openvpn}/bin/openvpn";
    owner = "root";
    group = "root";
    permissions = "u+rx,g+rx";
    capabilities = "cap_net_admin,cap_net_raw+eip";
  };
  */

  environment.systemPackages = with pkgs; [
    networkmanagerapplet
    wireguard-ui
    protonvpn-gui

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
