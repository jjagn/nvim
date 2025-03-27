vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- TIP: Disable arrow keys in normal mode
vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- allow moving lines using J and K when in visual mode
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '>-2<CR>gv=gv")

-- keep cursor in the same place when appending lines with J
vim.keymap.set("n", "J", "mzJ'z")

-- keep cursor in the middle of the screen when jumping up and down using ctrl D and ctrl U
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- keep search terms in the middle
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- clear search highlight with esc
vim.keymap.set("n", "<esc>", ":noh<cr>")

-- change ctrl+w (delete preceding word) to option + backspace (default for mac)
vim.keymap.set("i", "<M-BS>", "<C-W>")

vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

vim.keymap.set("n", "<leader>r", ":%s/")
vim.keymap.set("n", "<leader>R", ":s/")

vim.keymap.set("v",  "<leader>r", '"hy:%s/<C-r>h//g<left><left>')
vim.keymap.set("v",  "<leader>R", '"hy:s/<C-r>h//g<left><left>')

-- Function to format Rust files using rustfmt
local function format_rust_file()
    if vim.bo.filetype == 'rust' then
        local cursor_pos = vim.api.nvim_win_get_cursor(0)
        vim.cmd('%!rustfmt')
        vim.api.nvim_win_set_cursor(0, cursor_pos)
        print('Rust file formatted with rustfmt')
    else
        print('Not a Rust file')
    end
end

vim.keymap.set('n', '<leader>f', format_rust_file, {
    noremap = true,  -- Prevent remapping
    silent = true    -- Suppress command output messages
})

vim.api.nvim_create_autocmd('BufWritePre', {
    pattern = '*.rs',  -- Apply only to Rust files
    callback = function()
        format_rust_file()
    end
})
