local harpoon = require("harpoon")

-- REQUIRED
harpoon:setup()
-- END_REQUIRED

-- Telescope config for UI
local conf = require('telescope.config').values
local function toggle_telescope(harpoon_files)
    local finder = function()
        local paths = {}
        for _, item in ipairs(harpoon_files.items) do
            table.insert(paths, item.value)
        end

        return require("telescope.finders").new_table({
            results = paths,
        })
    end

    require("telescope.pickers").new({}, {
        prompt_title = "Harpoon",
        finder = finder(),
        previewer = conf.file_previewer({}),
        sorted = require("telescope.config").values.generic_sorter({}),
        layout_config = {
            height = 0.8,
            width = 0.8,
            prompt_position = "bottom",
            preview_cutoff = 120,
        },
        attach_mappings = function(prompt_bufnr, map)
            map("i", "<C-d>", function()
                local state = require("telescope.actions.state")
                local selected_entry = state.get_selected_entry()
                local current_picker = state.get_current_picker(prompt_bufnr)

                table.remove(harpoon_files.itmes, selected_entry.index)
                current_picker:refresh(finder())
            end)
            return true
        end,
    }):find()
end

vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end)
vim.keymap.set("n", "<C-e>",
    function() toggle_telescope(harpoon:list()) end,
    { desc = "Open Harpoon window" }
)

-- Toggle prev and next buffers within Harpoon list
vim.keymap.set("n", "<C-S-P>", function() harpoon:list():prev() end)
vim.keymap.set("n", "<C-S-N>", function() harpoon:list():next() end)
