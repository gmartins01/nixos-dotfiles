{
  config,
  pkgs,
  inputs,
  outputs,
  ...
}: let
  amdgpu-kernel-module = pkgs.callPackage ./amd-patch.nix {
    # Make sure the module targets the same kernel as your system is using.
    kernel = config.boot.kernelPackages.kernel;
  };
in {
  imports = [
    ./hardware-configuration.nix
  ];

  services.udev.extraRules = ''
    KERNEL=="i2c-[0-9]*", GROUP="i2c", MODE="0660"
  '';

  hardware.i2c.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Lisbon";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_GB.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "pt_PT.UTF-8";
    LC_IDENTIFICATION = "pt_PT.UTF-8";
    LC_MEASUREMENT = "pt_PT.UTF-8";
    LC_MONETARY = "pt_PT.UTF-8";
    LC_NAME = "pt_PT.UTF-8";
    LC_NUMERIC = "pt_PT.UTF-8";
    LC_PAPER = "pt_PT.UTF-8";
    LC_TELEPHONE = "pt_PT.UTF-8";
    LC_TIME = "pt_PT.UTF-8";
  };

  # Enable the X11 windowing system.
  # You can disable this if you're only using the Wayland session.
  services.xserver.enable = true;

  # Login Manager
  environment.systemPackages = [
    (
      pkgs.catppuccin-sddm.override {
        flavor = "mocha";
        font = "Noto Sans";
        fontSize = "9";
        #background = "${./wallpaper.png}";
        loginBackground = true;
      }
    )
  ];

  services.displayManager.sddm = {
    enable = true;
    theme = "catppuccin-mocha";
    package = pkgs.kdePackages.sddm;
    wayland.enable = true;
    autoNumlock = true;
    settings = {
      Theme = {
        CursorTheme = "Bibata-Modern-Ice";
      };
    };
  };

  # services.displayManager.sddm.enable = true;
  # services.desktopManager.plasma6.enable = true;
  #
  # environment.plasma6.excludePackages = with pkgs.kdePackages; [
  #   plasma-browser-integration
  #   konsole
  #   dolphin
  # ];

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "pt";
    variant = "";
  };

  fonts = {
    enableDefaultPackages = true;

    packages = with pkgs; [
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-emoji
      unifont
      material-icons
      material-symbols
      fira-code
      #roboton
      nerd-fonts.jetbrains-mono
      nerd-fonts.caskaydia-cove
    ];
  };

  # Configure console keymap
  console.keyMap = "pt-latin1";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.gmartins = {
    isNormalUser = true;
    description = "Gonçalo Martins";
    extraGroups = ["networkmanager" "wheel" "i2c"];
    #packages = with pkgs; [
    #kdePackages.kate
    #  thunderbird
    #];
  };

  nix.settings.experimental-features = ["nix-command" "flakes"];

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  nixpkgs.overlays = [
    outputs.overlays.stable-packages
    outputs.overlays.additions
    (final: prev: {
      jdk8 = prev.jdk8.overrideAttrs {
        separateDebugInfo = false;
        __structuredAttrs = false;
      };
    })
  ];

  # Automatic updates
  system.autoUpgrade.enable = true;
  system.autoUpgrade.dates = "weekly";

  # Automatic cleanup of old generations
  nix.gc = {
    automatic = true;
    randomizedDelaySec = "14m";
    #dates = "weekly";
    options = "--delete-older-than 10d";
  };
  nix.settings.auto-optimise-store = true;

  nix.settings = {
    substituters = ["https://hyprland.cachix.org"];
    trusted-public-keys = ["hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="];
  };

  system.stateVersion = "24.05";
}
