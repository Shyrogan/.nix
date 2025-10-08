{ config, pkgs, ... }:

{
  programs.tmux = {
    terminal = "screen-256color";
    historyLimit = 100000;
    keyMode = "vi";
    mouse = true;

    # Custom tmux configuration with bubble status bar using Stylix colors
    extraConfig = ''
      # Set escape time to 0 for immediate escape key response
      set-option -g escape-time 0

      # Set status bar position to bottom
      set-option -g status-position bottom

      # Status bar styling with bubble decorations using Stylix colors
      set-option -g status-style "bg=default,fg=#${config.lib.stylix.colors.base05}"
      set-option -g status-left-length 100
      set-option -g status-right-length 100

      # Left status with NixOS logo and bubble decoration using Stylix colors
      set-option -g status-left "#[fg=#${config.lib.stylix.colors.base0D}]#[bg=#${config.lib.stylix.colors.base0D},fg=#${config.lib.stylix.colors.base00},bold]  #S #[bg=default,fg=#${config.lib.stylix.colors.base0D}]#[bg=default] "

      # Window status format with bubbles using Stylix colors
      set-option -g window-status-format "#[fg=#${config.lib.stylix.colors.base05}]#[bg=#${config.lib.stylix.colors.base05},fg=#${config.lib.stylix.colors.base00}] #I  #W #[bg=default,fg=#${config.lib.stylix.colors.base05}]"
      set-option -g window-status-current-format "#[fg=#${config.lib.stylix.colors.base05}]#[bg=#${config.lib.stylix.colors.base05},fg=#${config.lib.stylix.colors.base00},bold] #I  #W #[bg=default,fg=#${config.lib.stylix.colors.base05}]"

      # Right status with bubble decorations using Stylix colors (date and time only)
      set-option -g status-right "#[bg=default] #[fg=#${config.lib.stylix.colors.base05}]#[bg=#${config.lib.stylix.colors.base05},fg=#${config.lib.stylix.colors.base00}] %Y-%m-%d #[bg=default,fg=#${config.lib.stylix.colors.base05}]#[bg=default] #[fg=#${config.lib.stylix.colors.base0D}]#[bg=#${config.lib.stylix.colors.base0D},fg=#${config.lib.stylix.colors.base00}] %H:%M #[bg=default,fg=#${config.lib.stylix.colors.base0D}]#[bg=default] "

      # Window separator
      set-option -g window-status-separator ""

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

      # Key bindings
      # Prefix key set to ² (superscript 2)
      set-option -g prefix ²
      unbind C-b
      bind ² send-prefix

      # Vim-style navigation with Alt+HJKL
      bind -n M-h select-window -p  # Previous window
      bind -n M-j select-pane -D       # Pane down
      bind -n M-k select-pane -U       # Pane up
      bind -n M-l select-window -n  # Next window

      # Resize panes with Alt+Shift+HJKL
      bind -n M-H resize-pane -L 5
      bind -n M-J resize-pane -D 5
      bind -n M-K resize-pane -U 5
      bind -n M-L resize-pane -R 5

      # Split panes with more intuitive keys
      bind | split-window -h -c "#{pane_current_path}"
      bind - split-window -v -c "#{pane_current_path}"

      # Reload config
      bind r source-file ~/.config/tmux/tmux.conf \; display "Config reloaded!"

      # Enable focus events for vim compatibility
      set-option -g focus-events on

      # Fix colors and enable true color support
      set-option -g default-terminal "screen-256color"
      set-option -ga terminal-overrides ",*256col*:Tc"

      # Floating window
      set -g @floax-bind '-n M-p'
    '';

    # Additional plugins can be added here
    plugins = with pkgs.tmuxPlugins; [
      # sensible  # Basic tmux settings everyone can agree on
      # resurrect # Persist tmux sessions after computer restart
      # continuum # Continuous saving of tmux environment
      tmux-floax
    ];
  };

  # Optional: Create a shell alias for easy tmux session management
  home.shellAliases = {
    ta = "tmux attach-session -t";
    tn = "tmux new-session -s";
    tl = "tmux list-sessions";
  };
}
