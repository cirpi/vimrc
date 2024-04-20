local o = vim.opt
local cmd = vim.cmd
local g = vim.g



o.number = true
o.relativenumber = true
o.expandtab = true
o.termguicolors = true
o.wrap = false
o.tabstop = 4
o.shiftwidth = 4
o.backup = false
o.writebackup = false
o.signcolumn = 'yes'
o.foldmethod = 'expr'
o.foldexpr = 'nvim_treesitter#foldexpr()'
o.filetype = 'on'
o.ignorecase = true
--o.list = true
--o.listchars = "space:\\u2022,tab:\\u21dc\\u2053\\u21dd,eol:\\u2937,"
--o.listchars = "space:\\u2022,tab:\\u21dc\\u2053\\u21dd,"

cmd('colorscheme gruvbox')



-- make nvim and os clipboard play nicely with each other
o.clipboard = 'unnamedplus'
o.undofile = true

-- remember 30 items in cmd history
o.history = 30

o.shell = '/usr/bin/bash'

g.ocaml_revised = 1
g.ocaml_noend_error = 1






-- Number of screen lines to keep at the top and bottom of the cursor
o.scrolloff = 10
