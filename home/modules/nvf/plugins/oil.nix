{pkgs, ...}: {
  enabled = true;
  package = pkgs.vimPlugins.oil-nvim;
  setupModule = "oil";
  setupOpts = {
    default_file_explorer = true;
  };
  keys = [
    {
      mode = "n";
      key = "<leader>o";
      action = "<CMD>Oil<CR>";
    }
  ];
  lazy = false;
}
