local opt = vim.opt

-- line numbers
opt.relativenumber = false 
opt.number = true

-- tabs & indentation
opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.autoindent = true
opt.wrap = false
opt.ignorecase = true
opt.smartcase = true
opt.cursorline = true
opt.termguicolors = true
opt.background = "dark"
opt.signcolumn = "yes"
opt.backspace = "indent,eol,start"
opt.clipboard:append("unnamedplus") -- use system clipboard as default register
opt.splitright = true
opt.splitbelow = true
opt.clipboard:append("unnamedplus")
opt.iskeyword:append("-")
