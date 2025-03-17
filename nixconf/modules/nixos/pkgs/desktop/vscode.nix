{ pkgs, ... }:

let
  plat = "linux-x64";

  vscodeLatest = pkgs.vscode.overrideAttrs (oldAttrs: rec {
    version = "latest";

    src = pkgs.fetchurl {
      name = "VSCode_${version}_${plat}.tar.gz";
      url = "https://update.code.visualstudio.com/${version}/${plat}/stable";
      sha256 = "sha256-YRzzQOB2g2gOoucH5kU7yVyT51rEONpKbmZgp6S8sl4=";

    };

  });
in
{
  environment.systemPackages = with pkgs; [
    vscodeLatest
  ];
}
