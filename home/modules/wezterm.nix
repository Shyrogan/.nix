{ inputs, pkgs, lib, config, ... }:
let
  cfg = config.programs.wezterm;
in{
  programs.wezterm = lib.mkIf cfg.enable {
    package = inputs.wezterm.packages.${pkgs.system}.default;
    extraConfig = ''
      return { font = wezterm.font {
          family = "JetBrainsMono Nerd Font Mono",
          weight = "DemiBold",
        },
        enable_tab_bar = false,
        window_close_confirmation = 'NeverPrompt'
      }
    '';
  };
}
