{pkgs, ...}: {
  enabled = false;
  package = pkgs.vimPlugins.claude-code-nvim;
  setupModule = "claude-code";
  lazy = false;
}
