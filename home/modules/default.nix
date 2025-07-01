{
  # While module in most config are configurations that also
  # enable a program, I want to keep the configuration modularized
  # and only configure a program if he is enabled.
  imports = [
    ./agenix.nix
    ./ankama-launcher.nix
    ./dconf.nix
    ./fonts.nix
    ./ghostty.nix
    ./helix.nix
    ./hyprland.nix
    ./lazygit.nix
    ./niri.nix
    #./nixvim.nix
    ./nvf
    ./nushell.nix
    ./wezterm.nix
    ./zellij.nix
  ];
}
