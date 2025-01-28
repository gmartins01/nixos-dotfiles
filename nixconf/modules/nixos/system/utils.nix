{ pkgs, lib, ... }:

{

  # Keyring and polkit
  services.gnome.gnome-keyring.enable = true;
  security.pam.services.sddm.enableGnomeKeyring = true;
  systemd = {
    user.services.polkit-gnome-authentication-agent-1 = {
      description = "polkit-gnome-authentication-agent-1";
      wantedBy = ["graphical-session.target"];
      wants = ["graphical-session.target"];
      after = ["graphical-session.target"];
      serviceConfig = {
        Type = "simple";
        ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
        Restart = "on-failure";
        RestartSec = 1;
        TimeoutStopSec = 10;
      };
    };
  };

  # Mount, trash, and other functionalities
  services.gvfs.enable = true;

  # Thumbnail support for images
  services.tumbler.enable = true;

  #security.pam.services.sddm.enableKwallet = true;
  #security.pam.services.sddm = {
  #  enableKwallet = true;
  #  text = ''
  #    auth include login
  #  '';
  #};
  #security.pam.services.kwallet = {
  #  name = "kwallet";
  #  enableKwallet = true;
  #};

  #security.pam.services.root99.enableKwallet = true;

  # To fix copy from xwayland apps
  services.clipboard-sync.enable = true;
}
