{
  # While module in most config are configurations that also
  # enable a program, I want to keep the configuration modularized
  # and only configure a program if he is enabled.
  # See: wezterm
  imports = [
    ./ankama-launcher.nix
    ./dconf.nix
    ./fonts.nix
    ./hyprland.nix
    ./niri.nix
    ./nixvim.nix
    ./nushell.nix
    ./pharo.nix
    ./swts.nix
    ./zellij.nix
    ./wezterm.nix
  ];
}
