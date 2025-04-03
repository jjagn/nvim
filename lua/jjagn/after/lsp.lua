local luasnip = require('luasnip')
local trouble = require('trouble')

local lspconfig_defaults = require('lspconfig').util.default_config
lspconfig_defaults.capabilities = vim.tbl_deep_extend(
  'force',
  lspconfig_defaults.capabilities,
  require('cmp_nvim_lsp').default_capabilities()
)
vim.api.nvim_create_autocmd('lspattach', {
  desc = 'lsp actions',
  callback = function(event)
  local opts = {buffer = bufnr, remap = false}
  vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, {buffer = bufnr, remap = false, desc = "go to definiton"})
  -- vim.keymap.set("n", "k", function() vim.lsp.buf.hover() end, opts)
  -- vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
  -- vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, {buffer = bufnr, remap = false, desc = "show diagnostics"})
  vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, {buffer = bufnr, remap = false, desc = "next diagnostic"})
  vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, {buffer = bufnr, remap = false, desc = "previous diagnostic"})
  vim.keymap.set("n", "<leader>va", function() vim.lsp.buf.code_action() end, {buffer = bufnr, remap = false, desc = "lsp code action"})
  -- vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
  vim.keymap.set("n", "<leader>vn", function() vim.lsp.buf.rename() end, {buffer = bufnr, remap = false, desc = "rename symbol"})
  vim.keymap.set("i", "<c-h>", function() vim.lsp.buf.signature_help() end, opts)
  vim.keymap.set("n", "<leader>h", function() vim.lsp.buf.signature_help() end, {buffer = bufnr, remap = false, desc = "lsp signature help"})
  vim.keymap.set("n", "<leader>vf", function() vim.lsp.buf.format() end, {buffer = bufnr, remap = false, desc = "format buffer"})
end})

require('mason').setup({})
require('mason-lspconfig').setup({
  ensure_installed = { 'clangd' },
  handlers = {
    function(server_name)
      require('lspconfig')[server_name].setup({})
    end,
  },
  automatic_installation = true,
})

require('lspconfig').clangd.setup {
  cmd = {
    "/Users/jacksoncrawford/repos/llvm-project/build/bin/clangd",
    "--background-index",
    "--query-driver=/home/jacksoncrawford/.platformio/packages/toolchain-xtensa-esp32/bin/xtensa-esp32-elf-gcc*,/home/jacksoncrawford/.platformio/packages/toolchain-xtensa-esp32/bin/xtensa-esp32-elf-g++*"
  },
  filetypes = { "c", "cpp" },
  capabilities = lspconfig_defaults.capabilities,
}

local cmp = require('cmp')

cmp.setup({

     experimental = {
	     ghost_text = true,
     },
    snippet = {
      expand = function(args)
        -- luasnip.lsp_expand(args.body) -- for `luasnip` users.
        vim.snippet.expand(args.body) -- for native neovim snippets (neovim v0.10+)
      end,
    },
    -- window = {
    --   -- completion = cmp.config.window.bordered(),
    --   -- documentation = cmp.config.window.bordered(),
    -- },

    mapping = cmp.mapping.preset.insert({
      ['<c-b>'] = cmp.mapping.scroll_docs(-4),
      ['<c-f>'] = cmp.mapping.scroll_docs(4),
      -- ['<tab>'] = cmp.mapping.complete(),
      -- ['<esc>'] = cmp.mapping.abort(),
      ['<cr>'] = cmp.mapping.confirm({ select = true }), -- accept currently selected item. set `select` to `false` to only confirm explicitly selected items.
    ['<tab>'] = cmp.mapping(function(fallback)
	if cmp.visible() then
	    if luasnip.expandable() then
		luasnip.expand()
	    else
		cmp.confirm({
			select = true,
		})
	    end
	else
	    fallback()
	end
    end),
    }),

    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      -- { name = 'luasnip' }, -- for luasnip users.
    }, {
      { name = 'buffer' },
    })
  })

  -- lsp.setup()
-- require('lspconfig.ui.windows').default_options.border = 'rounded'
-- require('lspconfig.ui.windows').default_options.wrap = true
-- require('lspconfig.ui.windows').default_options.max_width = 80

vim.diagnostic.config({
  virtual_text = {
    prefix = '■', -- or any character you prefer
    spacing = 4,
    source = "always",
    severity = nil,
    format = function(diagnostic)
      local message = diagnostic.message
      local trim_len = 120  -- adjust this number for desired line length
      if #message > trim_len then
        return string.sub(message, 1, trim_len) .. "..."
      end
      return message
    end,
    -- This shows all diagnostics for a line, not just the most severe one
    severity_sort = true,
  },
  float = {
    source = "always",
    border = "rounded",
    header = "",
    prefix = "",
    wrap = true,
  },
  signs = true,
  underline = true,
  update_in_insert = false,
})

-- Map a key to show all diagnostics for current line in a floating window
vim.keymap.set('n', '<leader>vl', function()
  vim.diagnostic.open_float({ scope = "line", wrap = true })
end, { desc = 'Show line diagnostics' })
