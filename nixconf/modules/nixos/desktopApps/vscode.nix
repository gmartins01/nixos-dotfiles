{ pkgs, ... }:

let
  plat = "linux-x64";

  vscodeLatest = pkgs.vscode.overrideAttrs (oldAttrs: rec {
    version = "latest";

    src = pkgs.fetchurl {
      name = "VSCode_${version}_${plat}.tar.gz";
      url = "https://update.code.visualstudio.com/${version}/${plat}/stable";
      sha256 = "sha256-81M11Zt8NfKQvLgJ56Mjz/IXtm5qQJMrdpfdzD24dh0="; 
       
    };
    
  });
in
{
  environment.systemPackages = with pkgs; [
    vscodeLatest
  ];
}
