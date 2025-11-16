-- options are automatically loaded before lazy.nvim startup
-- default options that are always set: https://github.com/lazyvim/lazyvim/blob/main/lua/lazyvim/config/options.lua
-- add any additional options here

-- lsp server to use for python.
-- set to "basedpyright" to use basedpyright instead of pyright.
vim.g.lazyvim_python_lsp = "pyright"
-- set to "ruff_lsp" to use the old lsp implementation version.
vim.g.lazyvim_python_ruff = "ruff"
vim.opt.signcolumn = "no" --линии после нумерации строк
vim.opt.scrolloff = 999
