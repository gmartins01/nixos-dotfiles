{ pkgs, ... }:

let
  plat = "linux-x64";

  vscodeLatest = pkgs.vscode.overrideAttrs (oldAttrs: rec {
    version = "latest";

    src = pkgs.fetchurl {
      name = "VSCode_${version}_${plat}.tar.gz";
      url = "https://update.code.visualstudio.com/${version}/${plat}/stable";
      sha256 = "sha256-OjSw6QqzUY0sUmeibCQPO7ddgnT/HiVbDceL3W6T3Ps=";

    };

  });
in
{
  environment.systemPackages = with pkgs; [
    vscodeLatest
  ];
}
