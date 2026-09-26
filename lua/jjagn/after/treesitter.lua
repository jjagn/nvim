require('nvim-treesitter').setup {
install_dir = vim.fn.stdpath('data') .. '/site'
}
  -- A list of parser names, or "all" (the five listed parsers should always be installed)
require('nvim-treesitter').install { "c", "lua", "vim", "vimdoc", "query", "rust", "python" }

-- nvim-treesitter `main` doesn't enable highlighting itself
vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'c', 'lua', 'vim', 'vimdoc', 'query', 'rust', 'python' },
  callback = function() pcall(vim.treesitter.start) end,
})
