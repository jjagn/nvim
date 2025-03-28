local wk = require("which-key")

-- Function to format Rust files using rustfmt
local function format_rust_file()
    if vim.bo.filetype == 'rust' then
        local cursor_pos = vim.api.nvim_win_get_cursor(0)
        vim.cmd('%!rustfmt')
        vim.api.nvim_win_set_cursor(0, cursor_pos)
    end
end


-- Which-key groups and mappings
wk.add({
    -- Project Navigation Group
    { "<leader>p", group = "Project" },
    { "<leader>pv", vim.cmd.Ex, desc = "Open file explorer" },
    -- Replace/Search Group
    { "<leader>r", group = "Replace" },
    { "<leader>g", group = "Git" },
    { "<leader>v", group = "LSP" },
    { "<leader>r", ":%s/", desc = "Global search and replace", mode = "n" },
    { "<leader>R", ":s/", desc = "Line-specific search and replace", mode = "n" },
    { "<leader>r", '"hy:%s/<C-r>h//g<left><left>', desc = "Global search and replace with visual selection", mode = "v" },
    { "<leader>R", '"hy:s/<C-r>h//g<left><left>', desc = "Line-specific search and replace with visual selection", mode = "v" },
    -- Formatting Group
    { "<leader>f", group = "Format" },
    { "<leader>f", format_rust_file, desc = "Format current Rust file" }
})

vim.g.mapleader = " "

-- Open file explorer (Netrw) in the current directory
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex, { desc = "Open file explorer" })

-- Disable arrow keys in normal mode to encourage hjkl navigation
vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>', { desc = "Prevent using left arrow key" })
vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>', { desc = "Prevent using right arrow key" })
vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>', { desc = "Prevent using up arrow key" })
vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>', { desc = "Prevent using down arrow key" })

-- Move selected lines up or down in visual mode while maintaining indentation
-- J moves selected block down, K moves selected block up
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selected block down" })
vim.keymap.set("v", "K", ":m '>-2<CR>gv=gv", { desc = "Move selected block up" })

-- Keep cursor in the same position when joining lines
vim.keymap.set("n", "J", "mzJ'z", { desc = "Join lines without moving cursor" })

-- Center screen when scrolling half-page up or down
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Scroll down and center screen" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Scroll up and center screen" })

-- Keep search terms centered when navigating through matches
vim.keymap.set("n", "n", "nzzzv", { desc = "Next search match centered" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Previous search match centered" })

-- Clear search highlighting with Escape key
vim.keymap.set("n", "<esc>", ":noh<cr>", { desc = "Clear search highlights" })

-- Mac-like word deletion in insert mode using Option + Backspace
vim.keymap.set("i", "<M-BS>", "<C-W>", { desc = "Delete previous word" })

-- Highlight yanked (copied) text briefly
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- Global search and replace
-- <leader>r replaces in entire file
-- <leader>R replaces in current line
vim.keymap.set("n", "<leader>r", ":%s/", { desc = "Global search and replace" })
vim.keymap.set("n", "<leader>R", ":s/", { desc = "Line-specific search and replace" })

-- Visual mode search and replace using current visual selection
vim.keymap.set("v", "<leader>r", '"hy:%s/<C-r>h//g<left><left>', { desc = "Global search and replace with visual selection" })
vim.keymap.set("v", "<leader>R", '"hy:s/<C-r>h//g<left><left>', { desc = "Line-specific search and replace with visual selection" })

-- Manually format Rust file with <leader>f
vim.keymap.set('n', '<leader>f', format_rust_file, {
    noremap = true,
    silent = true,
    desc = "Format current Rust file"
})

-- Automatically format Rust files on save
vim.api.nvim_create_autocmd('BufWritePre', {
    pattern = '*.rs',  -- Apply only to Rust files
    callback = function()
        format_rust_file()
    end,
    desc = "Auto-format Rust files on save"
})
