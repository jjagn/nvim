local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
{
  "folke/which-key.nvim",
  event = "VeryLazy",
  init = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 300
  end,
  opts = {}
},
{
  "christoomey/vim-tmux-navigator",
  lazy = false,
},
{
"nvim-telescope/telescope.nvim",
	dependencies = { 'nvim-lua/plenary.nvim' }
},
{ "ellisonleao/gruvbox.nvim", priority = 1000, config = true, opts = ...},
{{"nvim-treesitter/nvim-treesitter", build = ":TSUpdate"}},
"theprimeagen/harpoon",
"mbbill/undotree",
"tpope/vim-fugitive",
'williamboman/mason.nvim',
'williamboman/mason-lspconfig.nvim',
-- {'VonHeikemen/lsp-zero.nvim', branch = 'v3.x'},
{'neovim/nvim-lspconfig'},
{'hrsh7th/cmp-nvim-lsp'},
{'hrsh7th/nvim-cmp'},
{'L3MON4D3/LuaSnip'},
{ 'j-hui/fidget.nvim', opts = {} },
{ 'folke/neodev.nvim', opts = {} },
{
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' }
},
{
    'numToStr/Comment.nvim',
    lazy = false,
}
})
