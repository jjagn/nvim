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

vim.keymap.set("n", "<leader>gc", ":Git commit -m \"\"<left>", {noremap = true})
vim.keymap.set("n", "<leader>ga", ":Git add .<CR>")
vim.keymap.set("n", "<leader>gp", ":Git push<CR>")
vim.keymap.set("n", "<leader>gd", ":Git diff<CR>")
