local mark = require("harpoon.mark")
local ui = require("harpoon.ui")

vim.keymap.set("n", "<leader>a", mark.add_file, {desc = "Harpoon add file"})
vim.keymap.set("n", "<C-e>", ui.toggle_quick_menu)

vim.keymap.set("n", "<C-b>", function() ui.nav_file(1) end)
vim.keymap.set("n", "<C-n>", function() ui.nav_file(2) end)
-- <C-m> is indistinguishable from <CR> in most terminals
vim.keymap.set("n", "<leader>3", function() ui.nav_file(3) end, {desc = "Harpoon file 3"})
vim.keymap.set("n", "<C-,>", function() ui.nav_file(4) end)
