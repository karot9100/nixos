{ config, pkgs, lib, ... }:

{

  options.mymodules.bash.enable = lib.mkEnableOption "bash";

  config = lib.mkIf config.mymodules.bash.enable {

    programs.bash = {
      enable = true;
      promptInit = ''
        if [ "$TERM" != "dumb" ]; then
          PS1='\[\e[1;34m\]\u\[\e[0;38;5;240m\]@\[\e[0;35m\]\h\[\e[0;38;5;240m\] · \[\e[1;32m\]\w\[\e[0;38;5;240m\] · \[\e[0;33m\]\t\[\e[0m\]\n\[\e[1;31m\]❯ \[\e[0m\]'
        fi
      '';

        interactiveShellInit = ''
        export TERM=xterm-256color
        eval $(${pkgs.coreutils}/bin/dircolors -b)

        # Arrow up/down searches history based on what you've already typed
        bind '"\e[A": history-search-backward'
        bind '"\e[B": history-search-forward'

        # Bigger history
        HISTSIZE=10000
        HISTFILESIZE=20000
        HISTCONTROL=ignoredups:erasedups

        cd /etc/nixos
      '';

      shellAliases = {
        ls = "ls --color=tty";
        rebuild = "sudo nixos-rebuild switch";
        upgrade = "sudo nixos-rebuild switch --upgrade";
        clean = "sudo nix-collect-garbage -d";
        youtube = "cd ~/Downloads && yt-dlp -x --audio-format mp3 --audio-quality 0 --embed-thumbnail --embed-metadata";
        myconfig = ''find /etc/nixos -name "*.nix" | sort | xargs -I{} sh -c 'echo "=== {} ===" && cat {}' '';

      };

    };

  };

}
