{
  # While module in most config are configurations that also
  # enable a program, I want to keep the configuration modularized
  # and only configure a program if he is enabled.
  # See: wezterm
  imports = [
    ./dconf.nix
    ./fonts.nix
    ./niri.nix
    ./nushell.nix
    ./wezterm.nix
  ];
}
