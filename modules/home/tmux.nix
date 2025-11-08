{
  config,
  lib,
  pkgs,
  ...
}: {
  programs.tmux = {
    terminal = "screen-256color";
    historyLimit = 100000;
    keyMode = "vi";
    mouse = true;

    plugins = with pkgs.tmuxPlugins; [
      sensible
      resurrect
      continuum
      tmux-floax
      tmux-thumbs
    ];

    extraConfig = ''
      set-option -g default-terminal 'screen-256color'
      set-option -g terminal-overrides ',xterm-256color:RGB'

      set-option -g prefix ²
      unbind C-b
      bind ² send-prefix

      set -g base-index 1
      set -g detach-on-destroy off
      set -g escape-time 0
      set -g history-limit 1000000
      set -g renumber-windows on
      set -g set-clipboard on
      set -g status-position top
      set -g status-pad-top 1
      set -g focus-events on
      set -g aggressive-resize on
      setw -g mode-keys vi
      setw -g automatic-rename on
      setw -g monitor-activity on

      bind -n M-h select-window -p
      bind -n M-j select-pane -D
      bind -n M-k select-pane -U
      bind -n M-l select-window -n

      bind -n M-H resize-pane -L 5
      bind -n M-J resize-pane -D 5
      bind -n M-K resize-pane -U 5
      bind -n M-L resize-pane -R 5

      bind | split-window -h -c "#{pane_current_path}"
      bind - split-window -v -c "#{pane_current_path}"

      bind r source-file ~/.config/tmux/tmux.conf \; display "Config reloaded!"

      set -g @floax-bind '-n M-f'
      set -g @floax-change-path 'false'

      set -g @sessionx-prefix off
      set -g @sessionx-bind 'M-o'
      set -g @sessionx-fzf-builtin-tmux 'on'
      set -g @sessionx-zoxide-mode 'on'

      ${lib.optionalString config.stylix.enable ''
        # Set status bar position to top
        set-option -g status-position top
        set -g status 1

        # Status bar styling with bubble decorations using Stylix colors
        set-option -g status-style "bg=default,fg=#${config.lib.stylix.colors.base05}"
        set-option -g status-left-length 100
        set-option -g status-right-length 100

        # Left status with NixOS logo and bubble decoration using Stylix colors
        set-option -g status-left "#[fg=#${config.lib.stylix.colors.base0D}]#[bg=#${config.lib.stylix.colors.base0D},fg=#${config.lib.stylix.colors.base00},bold]  #S #[bg=default,fg=#${config.lib.stylix.colors.base0D}]#[bg=default]  "

        # Window status format with bubbles using Stylix colors
        set-option -g window-status-format "#[fg=#${config.lib.stylix.colors.base05}]#[bg=#${config.lib.stylix.colors.base05},fg=#${config.lib.stylix.colors.base00}] #I  #W #[bg=default,fg=#${config.lib.stylix.colors.base05}]"
        set-option -g window-status-current-format "#[fg=#${config.lib.stylix.colors.base05}]#[bg=#${config.lib.stylix.colors.base05},fg=#${config.lib.stylix.colors.base00},bold] #I  #W #[bg=default,fg=#${config.lib.stylix.colors.base05}]"

        # Right status with bubble decorations using Stylix colors (date and time only)
        set-option -g status-right "#[bg=default] #[fg=#${config.lib.stylix.colors.base05}]#[bg=#${config.lib.stylix.colors.base05},fg=#${config.lib.stylix.colors.base00}] %Y-%m-%d #[bg=default,fg=#${config.lib.stylix.colors.base05}]#[bg=default]  #[fg=#${config.lib.stylix.colors.base0D}]#[bg=#${config.lib.stylix.colors.base0D},fg=#${config.lib.stylix.colors.base00}] %H:%M #[bg=default,fg=#${config.lib.stylix.colors.base0D}]#[bg=default] "

        # Window separator
        set-option -g window-status-separator " "

        # Pane border colors using Stylix colors
        set-option -g pane-border-style "fg=#${config.lib.stylix.colors.base02}"
        set-option -g pane-active-border-style "fg=#${config.lib.stylix.colors.base0D}"

        # Message styling using Stylix colors
        set-option -g message-style "bg=#${config.lib.stylix.colors.base08},fg=#${config.lib.stylix.colors.base00}"
        set-option -g message-command-style "bg=#${config.lib.stylix.colors.base09},fg=#${config.lib.stylix.colors.base00}"

        # Copy mode styling using Stylix colors
        set-option -g mode-style "bg=#${config.lib.stylix.colors.base0E},fg=#${config.lib.stylix.colors.base00}"

        # Additional bubble characters for different terminals
        # If the bubbles don't render properly, uncomment these alternatives:
        # set-option -g status-left "#[bg=#${config.lib.stylix.colors.base0D},fg=#${config.lib.stylix.colors.base00},bold] ● #S #[bg=default,fg=#${config.lib.stylix.colors.base0D}]●"
        # set-option -g window-status-format "#[bg=#${config.lib.stylix.colors.base02},fg=#${config.lib.stylix.colors.base05}] #I #W #[bg=default,fg=#${config.lib.stylix.colors.base02}]●"
        # set-option -g window-status-current-format "#[bg=#${config.lib.stylix.colors.base08},fg=#${config.lib.stylix.colors.base00},bold] #I #W #[bg=default,fg=#${config.lib.stylix.colors.base08}]●"
        # set-option -g status-right "#[bg=default,fg=#${config.lib.stylix.colors.base0B}]●#[bg=#${config.lib.stylix.colors.base0B},fg=#${config.lib.stylix.colors.base00}] %Y-%m-%d #[bg=#${config.lib.stylix.colors.base0B},fg=#${config.lib.stylix.colors.base09}]●#[bg=#${config.lib.stylix.colors.base09},fg=#${config.lib.stylix.colors.base00}] %H:%M #[bg=#${config.lib.stylix.colors.base09},fg=#${config.lib.stylix.colors.base0E}]●#[bg=#${config.lib.stylix.colors.base0E},fg=#${config.lib.stylix.colors.base00}] #h "
      ''}
    '';
  };

  home.shellAliases = {
    ta = "tmux attach-session -t";
    tn = "tmux new-session -s";
    tl = "tmux list-sessions";
  };
}
