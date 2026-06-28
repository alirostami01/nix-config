{ config, pkgs, ... }: {
  programs.zsh = {
    enable = true;
    autocd = true;
    dotDir = ".config/zsh";
    history = {
      size = 10000;
      path = "$HOME/.config/zsh/history";
    };
    oh-my-zsh = {
      enable = true;
      plugins = [ "git" "z" "sudo" "colored-man-pages" ];
    };
    zsh-autosuggestions.enable = true;
    zsh-syntax-highlighting.enable = true;
    initExtraFirst = ''
      export ZSH="$HOME/.config/zsh/.oh-my-zsh"
    '';
    initExtra = ''
      DISABLE_AUTO_TITLE="true"
      eval "$(oh-my-posh init zsh --config '~/.config/ohmyposh/themes/cobalt2.omp.json')"
      alias help="tldr"

      export NVM_DIR="$HOME/.nvm"
      [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
      [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

      FNM_PATH="$HOME/.local/share/fnm"
      if [ -d "$FNM_PATH" ]; then
        export PATH="$FNM_PATH:$PATH"
        eval "$(fnm env)"
      fi

      export PATH="$PATH:$HOME/.local/bin"
      export PATH="/opt/nvim-linux-x86_64/bin:$PATH"
      alias ls='eza -lh --icons'
      alias cat='batcat'
      alias bw='bandwhich'
      export PATH="$HOME/.local/bin:$HOME/.cargo/bin:$HOME/go/bin:$PATH"
      export PATH="$HOME/.opencode/bin:$PATH"

      source /usr/share/doc/fzf/examples/key-bindings.zsh 2>/dev/null || true
      source /usr/share/doc/fzf/examples/completion.zsh 2>/dev/null || true

      export FZF_CTRL_T_OPTS="
        --preview 'batcat -n --color=always {}'
        --bind 'ctrl-/:change-preview-window(down|hidden|)'
      "

      fzfnvim() {
        fzf --preview 'batcat -n --color=always {}' \
            --bind 'enter:execute(nvim {})'
      }

      export FZF_DEFAULT_OPTS="--height=85% --layout=reverse --border=rounded --margin=1,2"

      if [[ "$TERM" == "xterm-kitty" ]] && [[ -z "$ZELLIJ" ]]; then
        exec zellij
      fi
    '';
  };

  xdg.configFile."ohmyposh/themes/cobalt2.omp.json".source = ../themes/cobalt2.omp.json;
  xdg.configFile."ohmyposh/themes/zen.toml".source = ../themes/zen.toml;

  xdg.configFile."neofetch/config.conf".source = ../config/neofetch/config.conf;

  programs.bash = {
    enable = true;
    initExtra = ''
      . "$HOME/.cargo/env"
      setxkbmap -layout us,ir -option 'grp:alt_shift_toggle'
      export PATH="$PATH:/opt/nvim-linux-x86_64/bin"
      export PATH="$HOME/.local/bin:$PATH"
    '';
    profileExtra = ''
      export PATH=$PATH:/usr/local/go/bin
      . "$HOME/.cargo/env"
      export PATH="$HOME/.local/bin:$PATH"
    '';
  };

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
    enableBashIntegration = true;
  };
}
