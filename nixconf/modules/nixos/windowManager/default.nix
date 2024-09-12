{ config, pkgs, ... }:

{
  services.xserver = {
    windowManager.awesome = {
      enable = true;
      package = pkgs.awesome.overrideAttrs (old: {
        src = pkgs.fetchFromGitHub {
          owner = "awesomeWM";
          repo = "awesome";
          rev = "5da5d36";
          sha256 = "sha256-TvpUSep0Ee2/mSQogiSIuG/Uy9h+Vvvup6QrvV6V6sQ=";
        };
      });
    };
  };

}
