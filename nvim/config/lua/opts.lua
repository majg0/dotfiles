local opt = vim.opt

-- context
opt.number = true 
opt.relativenumber = true

-- filetypes
opt.encoding = 'utf8'

-- search
opt.ignorecase = true
opt.smartcase = true

-- whitespace
opt.expandtab = true
opt.shiftwidth = 2
opt.softtabstop = 2
opt.tabstop = 2
opt.list = true
opt.listchars:append "space:⋅"
opt.listchars:append "eol:↴"
opt.listchars:append "nbsp:_"

