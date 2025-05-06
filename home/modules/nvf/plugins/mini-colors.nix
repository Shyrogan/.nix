{pkgs, ...}: {
  enabled = true;
  package = pkgs.vimPlugins.mini-colors;
  after = ''
    local colors = require("mini.colors")

    colors
      .get_colorscheme()
      :add_transparency({
        general = true,
        float = true,
        statuscolumn = true,
        statusline = true,
        tabline = true,
        winbar = true,
      })
      :apply()
  '';
  lazy = false;
}
