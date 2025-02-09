{ config, lib, inputs, pkgs, ... }: with lib; let
  cfg = config.programs.zellij;
  inherit (inputs) zjstatus;
in {
  options.programs.zellij.nuShellIntegration = mkEnableOption "Enable zellij for nu";
  config.xdg.configFile."zellij/config.kdl" = mkIf cfg.enable {
    text = builtins.readFile ../../assets/config/zellij.kdl ++ ''
      layout {
          default_tab_template {
              children
              pane size=1 borderless=true {
                  plugin location="${zjstatus.packages.${pkgs.system}.default}" {
                      format_left   "{mode} #[fg=#89B4FA,bold]{session}"
                      format_center "{tabs}"
                      format_right  "{command_git_branch} {datetime}"
                      format_space  ""

                      border_enabled  "false"
                      border_char     "─"
                      border_format   "#[fg=#6C7086]{char}"
                      border_position "top"

                      hide_frame_for_single_pane "true"

                      mode_normal  "#[bg=blue] "
                      mode_tmux    "#[bg=#ffc387] "

                      tab_normal   "#[fg=#6C7086] {name} "
                      tab_active   "#[fg=#9399B2,bold,italic] {name} "

                      command_git_branch_command     "git rev-parse --abbrev-ref HEAD"
                      command_git_branch_format      "#[fg=blue] {stdout} "
                      command_git_branch_interval    "10"
                      command_git_branch_rendermode  "static"

                      datetime        "#[fg=#6C7086,bold] {format} "
                      datetime_format "%A, %d %b %Y %H:%M"
                      datetime_timezone "Europe/Berlin"
                  }
              }
          }
      }
    '';
  };
  config.programs.nushell = mkIf cfg.nuShellIntegration {
    extraConfig = ''
      def start_zellij [] {
        if 'ZELLIJ' not-in ($env | columns) {
          if 'ZELLIJ_AUTO_ATTACH' in ($env | columns) and $env.ZELLIJ_AUTO_ATTACH == 'true' {
            zellij attach -c
          } else {
            zellij
          }

          if 'ZELLIJ_AUTO_EXIT' in ($env | columns) and $env.ZELLIJ_AUTO_EXIT == 'true' {
            exit
          }
        }
      }

      start_zellij
    '';
  };
}
