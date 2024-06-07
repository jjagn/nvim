require("jjagn.lazy")
require("jjagn.remap")
require("jjagn.after")
require("jjagn.neovide")

vim.o.background = "dark"
vim.cmd([[colorscheme gruvbox]])
vim.o.guifont = "BerkeleyMono Nerd Font:h14"

require("mason").setup()
require("lualine").setup(
	{options = {
		theme = 'gruvbox',
		icons_enabled = false
	}
})
require("Comment").setup()

vim.opt.guicursor = {
  'n-v-c:block-Cursor/lCursor-blinkwait100-blinkon700-blinkoff700',
  'i-ci:ver25-Cursor/lCursor-blinkwait100-blinkon700-blinkoff700',
  'r:hor50-Cursor/lCursor-blinkwait100-blinkon700-blinkoff700'
}

vim.opt.number = true
vim.opt.relativenumber = true

-- Don't show the mode, since it's already in the status line
vim.opt.showmode = false

-- Sync clipboard between OS and Neovim.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.opt.clipboard = 'unnamedplus'

-- Enable break indent
vim.opt.breakindent = true

-- Save undo history
vim.opt.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Keep signcolumn on by default
vim.opt.signcolumn = 'yes'

-- Decrease update time
vim.opt.updatetime = 250

-- Decrease mapped sequence wait time
-- Displays which-key popup sooner
vim.opt.timeoutlen = 300

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Preview substitutions live, as you type!
vim.opt.inccommand = 'split'

-- Show which line your cursor is on
vim.opt.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 10
