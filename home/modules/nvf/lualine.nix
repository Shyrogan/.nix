{
  enable = false;
  sectionSeparator = {
    left = "";
    right = "";
  };
  activeSection = {
    a = [
      ''
        {
          "mode",
          icons_enabled = true,
          separator = {
            left = '',
            right = ''
          },
          right_padding = 2,
        }
      ''
      ''
        {
          "",
          draw_empty = true,
          separator = { left = '', right = '', right_padding = 2 }
        }
      ''
    ];
    y = [
      ''
        {
          "",
          draw_empty = true,
          separator = { left = '', right = '' }
        }
      ''
      ''
        {
          'searchcount',
          maxcount = 999,
          timeout = 120,
          separator = {left = ''}
        }
      ''
      ''
        {
          "branch",
          icon = ' •',
          separator = {left = ''}
        }
      ''
    ];
    z = [
      ''
        {
          "",
          draw_empty = true,
          separator = { left = '', right = '', left_padding = 2 }
        }
      ''
      ''
        {
          "progress",
          separator = {left = '', right = ''}
        }
      ''
      ''
        {"location"}
      ''
      ''
        {
          "fileformat",
          color = {fg='black'},
          symbols = {
            unix = '', -- e712
            dos = '',  -- e70f
            mac = '',  -- e711
          },
          separator = {left = '', right = ''}
        }
      ''
    ];
  };
  refresh = {
    statusline = 100;
    tabline = 100;
    winbar = 100;
  };
}
