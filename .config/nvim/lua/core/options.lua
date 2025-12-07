local opt = vim.opt

opt.number = true
opt.relativenumber = true
opt.mouse = "a"
opt.clipboard = "unnamedplus"
opt.termguicolors = true

opt.tabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.autoindent = true

opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = true
opt.incsearch = true

opt.swapfile = false
opt.backup = false
opt.writebackup = false

opt.updatetime = 300
opt.timeoutlen = 300

opt.cursorline = true
opt.wrap = false
opt.showmode = false

opt.list = true
opt.listchars = { tab = "»·", trail = "·", nbsp = "␣" }

opt.encoding = "utf-8"
opt.fileencoding = "utf-8"

vim.opt.scrolloff = 8