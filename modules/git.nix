{ config, pkgs, ... }: {
  programs.git = {
    enable = true;
    lfs.enable = true;
    userName = "Ali Rostami";
    userEmail = "rostami.ali@gmail.com";
    extraConfig = {
      init.defaultBranch = "main";
      pull.rebase = false;
    };
  };
}
