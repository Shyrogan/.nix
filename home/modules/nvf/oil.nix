{pkgs, ...}: {
  lazy.plugins = {
    oil.nvim = {
      package = pkgs.vimplugin-oil.nvim;
      lazy = false;
    };
  };
}
