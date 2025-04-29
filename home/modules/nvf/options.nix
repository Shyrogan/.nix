{
  # Set tabs to 2 spaces
  tabstop = 2;
  softtabstop = 2;
  showtabline = 0;
  laststatus = 0;
  expandtab = true;

  # Enable auto indenting and set it to spaces
  smartindent = true;
  shiftwidth = 2;

  # Enable smart indenting (see https://stackoverflow.com/questions/1204149/smart-wrap-in-vim)
  breakindent = true;

  # Enable incremental searching
  hlsearch = true;
  incsearch = true;

  # Enable ignorecase + smartcase for better searching
  ignorecase = true;
  smartcase = true; # Don't ignore case with capitals
  grepprg = "rg --vimgrep";
  grepformat = "%f:%l:%c:%m";

  # Decrease updatetime
  updatetime = 50; # faster completion (4000ms default)

  # Enable text wrap
  wrap = true;

  list = true; # Show invisible characters (tabs, eol, ...)
  listchars = "eol:↲,tab:··,lead:·,space: ,trail:•,extends:→,precedes:←,nbsp:␣";
}
