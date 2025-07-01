{pkgs, ...}: {
  enabled = true;
  package = pkgs.vimPlugins.claude-code-nvim;
  setupModule = "claude-code";
  lazy = false;
  setupOpts = {
    window = {
      split_ratio = 0.3;
      position = "botright";
      enter_insert = true;
      hide_numbers = true;
      hide_signcolumn = true;
    };
    refresh = {
      enable = true;
      updatetime = 100;
      timer_interval = 1000;
      show_notifications = true;
    };
    git = {
      use_git_root = true;
    };
    shell = {
      separator = "; ";
      pushd_cmd = "pushd";
      popd_cmd = "popd";
    };
    command = "claude";
    command_variants = {
      continue = "--continue";
      resume = "--resume";
      verbose = "--verbose";
    };
    keymaps = {
      toggle = {
        normal = "<C-,>";
        terminal = "<C-,>";
        variants = {
          continue = "<leader>cC";
          verbose = "<leader>cV";
        };
      };
      window_navigation = true;
      scrolling = true;
    };
  };
}
