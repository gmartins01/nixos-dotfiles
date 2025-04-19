{
  config,
  pkgs,
  ...
}: {
  networking.hostName = "nixos";
  networking.firewall.allowedTCPPorts = [8384 9999];

  # Enable networking
  networking = {
    resolvconf.enable = true;
    networkmanager = {
      enable = true;
      wifi.powersave = false;
    };
  };
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

    protonvpn-gui

    #openresolv
    #openvpn
    #networkmanager-openvpn

    #wireguard-tools
    #wg-netmanager
  ];
}
