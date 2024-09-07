{ pkgs, lib, config,... }:

{

  options = {
    zsh.enable = lib.mkEnableOption "Enable zsh shell";
  };

  config = lib.mkIf config.zsh.enable {
    programs.zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;

      history = {
        size = 10000;
        path = "${config.xdg.dataHome}/zsh/history";
      };

    };
  };

}
