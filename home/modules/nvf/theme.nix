{
  withColors = colors: {
    enable = true;
    name = "base16";
    transparent = true;
    #base16-colors = {
    #  inherit (colors) base00 base01 base02 base03 base04 base07 base08;
    #  inherit (colors) base09 base0A base0B base0C base0D base0E base0F;
    #  # Quite a shitty color for font by default
    #  base05 = colors.base06;
    #  base06 = colors.base05;
    #};
  };
}
