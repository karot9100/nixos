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
      

        debug-boot() {
          echo "=== Boot timing ==="
          systemd-analyze
          echo -e "\n=== Top 15 slowest services ==="
          systemd-analyze blame | head -15
          echo -e "\n=== Critical chain ==="
          systemd-analyze critical-chain
          echo -e "\n=== Failed units ==="
          systemctl --failed --no-pager
          echo -e "\n=== Errors from current boot ==="
          journalctl -b 0 -p err --no-pager
          echo -e "\n=== NVIDIA/DRM messages ==="
          journalctl -b 0 -k --no-pager | grep -iE "nvidia|drm|nouveau|modeset"
          echo -e "\n=== Display manager ==="
          journalctl -b 0 -u display-manager.service --no-pager
          echo -e "\n=== User session (Hyprland) ==="
          journalctl --user -b 0 --no-pager | tail -50
          echo -e "\n=== Last 30 lines of current boot ==="
          journalctl -b 0 --no-pager | tail -30
        }
        debug-boot-previous() {
          echo "=== Errors from previous boot ==="
          journalctl -b -1 -p err --no-pager
          echo -e "\n=== NVIDIA/DRM messages ==="
          journalctl -b -1 -k --no-pager | grep -iE "nvidia|drm|nouveau|modeset"
          echo -e "\n=== Display manager ==="
          journalctl -b -1 -u display-manager.service --no-pager
          echo -e "\n=== User session (Hyprland) ==="
          journalctl --user -b -1 --no-pager | tail -50
          echo -e "\n=== Last 30 lines of previous boot ==="
          journalctl -b -1 --no-pager | tail -30
        }
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
