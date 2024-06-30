local harpoon = require("harpoon")

-- REQUIRED
harpoon:setup()
-- END_REQUIRED

-- Telescope config for UI
local conf = require('telescope.config').values
local function toggle_telescope(files)
    local file_paths = {}
    for _, item in ipairs(files.items) do
        table.insert(file_paths, item.value)
    end

    require("telescope.picker").new({}, {
        prompt_tile = "Harpoon",
        finder = require("telescope.finder").new_table({
            results = file_paths,
        }),
        previewer = conf.file_previewer({}),
        sorter = conf.generic_sorter({}),
    }):find()
end

vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end)
vim.keymap.set(
    "n",
    "<C-e>",
    function() toggle_telescope(harpoon:list()) end,
    { desc = "Open Harpoon window" }
)

-- Toggle prev and next buffers within Harpoon list
vim.keymap.set("n", "<C-S-P>", function() harpoon:list():prev() end)
vim.keymap.set("n", "<C-S-N>", function() harpoon:list():next() end)
