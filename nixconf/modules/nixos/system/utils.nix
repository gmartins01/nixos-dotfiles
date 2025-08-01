{ pkgs, lib, ... }:

{

  environment.systemPackages = with pkgs; [
    seahorse # Manage Keyring keys
  ];

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

  # security.polkit.extraConfig = ''
  #   polkit.addRule(function(action, subject) {
  #     if (
  #       action.id == "org.corectrl.helper.init" ||
  #       action.id == "org.corectrl.helperkiller.init"
  #     ) {
  #       return polkit.Result.YES;
  #     }
  #   });
  # '';


  # Thumbnail support for images
  services.tumbler.enable = true;

  # To fix copy from xwayland apps
  services.clipboard-sync.enable = false;

  security = {
    # allow wayland lockers to unlock the screen
    pam.services.hyprlock.text = "auth include login";
  };
}
