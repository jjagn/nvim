local file_ignore_patterns = {
			"build/",
			"target/",
			"package%-lock%.json",
		}

require('telescope').setup { defaults = { file_ignore_patterns = { "target/" }}}
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>pf', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>pg', builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>pb', builtin.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>ph', builtin.help_tags, { desc = 'Telescope help tags' })
vim.keymap.set('n', '<leader>pp', builtin.oldfiles, { desc = 'Telescope recent files' })
vim.keymap.set('n', '<leader>pc', builtin.command_history, { desc = 'Telescope command_history' })
vim.keymap.set('n', '<leader>ps', builtin.current_buffer_fuzzy_find, { desc = 'Telescope fuzzy find in buffer'})
vim.keymap.set('n', '<leader>vd', builtin.diagnostics, { desc = 'Telescope LSP diagnostics'})
vim.keymap.set('n', '<leader>gl', builtin.git_commits, { desc = 'Telescope git commits'})
vim.keymap.set('n', '<leader>gs', builtin.git_status, { desc = 'Telescope git status'})
vim.keymap.set('n', '<leader>vr', builtin.lsp_references, { desc = 'Telescope LSP references'})


local actions = require("telescope.actions")
local open_with_trouble = require("trouble.sources.telescope").open

-- Use this to add more results without clearing the trouble list
local add_to_trouble = require("trouble.sources.telescope").add

local telescope = require("telescope")

telescope.setup({
  defaults = {
    mappings = {
      i = { ["<c-t>"] = open_with_trouble },
      n = { ["<c-t>"] = open_with_trouble },
    },
  },
})
