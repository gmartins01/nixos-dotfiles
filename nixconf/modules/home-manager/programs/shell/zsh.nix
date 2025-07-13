{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    zsh.enable = lib.mkEnableOption "Enable zsh shell";
    zsh.host = lib.mkOption {
      type = lib.types.str;
      default = "desktop";
      description = "Host name";
    };
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
        rebuild = "sudo nixos-rebuild switch --flake ~/nixconf#${config.zsh.host}";
        upgrade = "sudo nixos-rebuild switch --upgrade --flake ~/nixconf#${config.zsh.host}";
        update = "nix flake update --flake ~/nixconf";
        editconfig = "nvim ~/nixconf -c 'lua vim.api.nvim_set_current_dir(\"$HOME/nixconf\")'";
        "hm-switch" = "home-manager switch --flake ~/nixconf#${config.home.username}@${config.zsh.host}";
        "full-rebuild" = "rebuild && hm-switch";

        config = "git --git-dir=/home/${config.home.username}/.cfg/ --work-tree=/home/${config.home.username}";

        la = "${pkgs.eza}/bin/eza -al --color=always --group-directories-first"; # ls -la
        ls = "${pkgs.eza}/bin/eza -a --color=always --group-directories-first"; # all files and dirs
        ll = "${pkgs.eza}/bin/eza -l --color=always --group-directories-first"; # long format
        lt = "${pkgs.eza}/bin/eza -aT --color=always --group-directories-first"; # tree listing
        "l." = "${pkgs.eza}/bin/eza -a | egrep '^\.'"; # dot files

        jctl = "journalctl -p 3 -xb";

        "hm-status" = "journalctl --unit home-manager-${config.home.username}.service -n 100 -r"; # To see home-manager logs
      };

      initContent = ''
        bindkey "^[[1;5D" backward-word
        bindkey "^[[1;5C" forward-word
        bindkey "^[[3~" delete-char

        eval "$(direnv hook zsh)"

      '';
      # This command let's me execute arbitrary binaries downloaded through channels such as mason.
      #export NIX_LD=$(nix eval --impure --raw --expr 'let pkgs = import <nixpkgs> {}; NIX_LD = pkgs.lib.fileContents "${pkgs.stdenv.cc}/nix-support/dynamic-linker"; in NIX_LD')
    };
  };
}
