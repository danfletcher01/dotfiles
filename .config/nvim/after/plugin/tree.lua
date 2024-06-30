vim.api.nvim_set_keymap("n", "<space>pv", ":NvimTreeToggle<CR>", { noremap = true })

local api = require("nvim-tree.api")
vim.keymap.set("n", "<CR>", api.node.open.no_window_picker)
