{ config, pkgs, lib, ... }: {
  programs.git = {
    enable = true;
    lfs.enable = true;

    # Set these per-user for a personal configuration.
    userName = lib.mkDefault "Your Name";
    userEmail = lib.mkDefault "you@example.com";

    extraConfig = {
      init.defaultBranch = "main";
      pull.rebase = false;
    };
  };
}
