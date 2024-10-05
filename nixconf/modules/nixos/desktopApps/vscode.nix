{ pkgs, ... }:

let
  plat = "linux-x64";

  vscodeLatest = pkgs.vscode.overrideAttrs (oldAttrs: rec {
    version = "1.94.0";

    src = pkgs.fetchurl {
      name = "VSCode_${version}_${plat}.tar.gz";
      url = "https://update.code.visualstudio.com/${version}/${plat}/stable";
      sha256 = "sha256-yqS2J8R3LdjF/BLhlAi9llAR65lJagvHL4qMZEnVvKk="; 
       
    };
    
  });
in
{
  environment.systemPackages = with pkgs; [
    vscodeLatest
  ];
}
