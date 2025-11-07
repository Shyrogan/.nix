{config, ...}: {
  home.shellAliases = {
    g = "git";
    lg = "lazygit";
  };

  # https://nixos.asia/en/git
  programs = {
    git = {
      enable = true;
      settings = {
        inherit (config.me) email;
        name = config.me.fullname;
      };

      ignores = ["*~" "*.swp"];
    };
    lazygit.enable = true;
  };
}
