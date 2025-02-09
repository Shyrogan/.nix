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
    ./hyprland.nix
    ./niri.nix
    ./nixvim.nix
    ./nushell.nix
    ./wezterm.nix
    ./zellij.nix
  ];
}
