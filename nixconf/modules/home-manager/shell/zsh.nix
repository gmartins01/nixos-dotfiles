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

      shellAliases = {
        
        rebuild="sudo nixos-rebuild switch --flake ~/nixconf#desktop";
        upgrade="sudo nixos-rebuild switch --upgrade --flake ~/nixconf#desktop";
        update="nix flake update --flake ~/nixconf";
        #editconfig="code ~/nixconf";
        editconfig="cd ~/nixconf && nvim .";
        "hm-switch"="home-manager switch --flake ~/nixconf#gmartins@desktop";
        "full-rebuild"="rebuild && hm-switch";

        config = "git --git-dir=/home/gmartins/.cfg/ --work-tree=/home/gmartins";
        
        la = "eza -al --color=always --group-directories-first"; # ls -la
        ls = "eza -a --color=always --group-directories-first";  # all files and dirs
        ll = "eza -l --color=always --group-directories-first";  # long format
        lt = "eza -aT --color=always --group-directories-first"; # tree listing
        "l." = "eza -a | egrep '^\.'"; # dot files

        jctl="journalctl -p 3 -xb";
        
        "hm-status" = "journalctl --unit home-manager-gmartins.service -n 100 -r"; # To see home-manager logs
      };

      initExtra = ''
        bindkey "^[[1;5D" backward-word
        bindkey "^[[1;5C" forward-word
        bindkey "^[[3~" delete-char
        
        export NIX_LD=$(nix eval --impure --raw --expr 'let pkgs = import <nixpkgs> {}; NIX_LD = pkgs.lib.fileContents "${pkgs.stdenv.cc}/nix-support/dynamic-linker"; in NIX_LD')
      '';# This command let's me execute arbitrary binaries downloaded through channels such as mason.
    };
  };

}
