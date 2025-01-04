{ pkgs, ... }:

let
  plat = "linux-x64";

  vscodeLatest = pkgs.vscode.overrideAttrs (oldAttrs: rec {
    version = "latest";

    src = pkgs.fetchurl {
      name = "VSCode_${version}_${plat}.tar.gz";
      url = "https://update.code.visualstudio.com/${version}/${plat}/stable";
      sha256 = "sha256-JoEEAIn68UO+03JG8rC8B4f200LYeLHsSzc3s4gzwIg=";

    };

  });
in
{
  environment.systemPackages = with pkgs; [
    vscodeLatest
  ];
}
