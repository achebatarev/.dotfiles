vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.wrap = true

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.hlsearch = true
vim.opt.incsearch = true


vim.opt.termguicolors = true

vim.opt.scrolloff = 10
-- vim.opt.signcolumn = "no"
vim.opt.isfname:append("@-@")
vim.opt.signcolumn = "yes"
vim.opt.updatetime = 50

-- vim.opt.colorcolumn = "80"

vim.opt.clipboard = "unnamedplus"
vim.opt.mouse = "a"
vim.opt.cursorline = true
vim.opt.ma = true
vim.opt.tildeop = true



vim.g.mapleader = " "

vim.api.nvim_create_autocmd("TextYankPost", {
group = vim.api.nvim_create_augroup("highlight-yank", {clear = true}),
callback = function ()
   vim.highlight.on_yank()
end,
})
