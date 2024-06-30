return {
    -- Color scheme
    {
        "catppuccin/nvim",
        name = "catppuccin",
        priority = 1000,
    },
    -- Fuzzy finder
    {
        "nvim-telescope/telescope.nvim",
        branch = "0.1.x",
        dependencies = { "nvim-lua/plenary.nvim" },
    },
    -- Movement between files
    {
        "ThePrimeagen/harpoon",
        branch = "harpoon2",
        dependencies = { "nvim-lua/plenary.nvim", "nvim-telescope/telescope.nvim" },
    },
    -- Syntax highlighting
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function()
            require("nvim-treesitter.configs").setup({
                ensure_install = {
                    "c",
                    "cpp",
                    "lua",
                    "vim",
                    "vimdoc",
                    "python",
                },
                sync_install = false,
                highlight = { enable = true },
                indent = { enable = true },
            })
        end,
    },
    -- File tree
    {
        "nvim-tree/nvim-tree.lua",
        version = "*",
        lazy = false,
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            require("nvim-tree").setup({
                disable_netrw = true,
                hijack_netrw = true,
                respect_buf_cwd = true,
                sync_root_with_cwd = true,
                update_focused_file = { enable = true },
                view = {
                    relativenumber = true,
                    float = {
                        enable = true,
                        open_win_config = function()
                            local screen_w = vim.opt.columns:get()
                            local screen_h = vim.opt.lines:get() - vim.opt.cmdheight:get()
                            local window_w = screen_w * 0.5
                            local window_h = screen_h * 0.5
                            local window_w_int = math.floor(window_w)
                            local window_h_int = math.floor(window_h)
                            local center_x = (screen_w - window_w) / 2
                            local center_y = ((vim.opt.lines:get() - window_h) / 2 - vim.opt.cmdheight:get())
                            return {
                                border = "rounded",
                                relative = "editor",
                                row = center_y,
                                col = center_x,
                                width = window_w_int,
                                height = window_h_int,
                            }
                        end,
                    },
                    width = function () return math.floor(vim.opt.columns:get() * 0.5) end,
                },
            })
        end,
    },
    -- Status line
    {
        "nvim-lualine/lualine.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            require("lualine").setup({
                options = {
                    theme = "auto",
                    icons_enable = true,
                    component_separators = "",
                    section_separations = { left = "", right = "" },
                    disabled_filetypes = {
                        statusline = {},
                        winbar = {},
                    },
                    ignore_focus = {},
                    always_divide_middle = true,
                    globalstatus = true,
                    refresh = {
                        statusline = 1000,
                        tabline = 1000,
                        winbar = 1000,
                    },
                },
                section = {
                    lualine_a = { "mode" },
                    lualine_b = { "branch", "diff", "diagnostics" },
                    lualine_c = { { "filename", path = 1 } },
                    lualine_x = { "encoding", "fileformat", "filetype" },
                    lualine_y = { "progress", "location" },
                    lualine_z = {},
                },
                inactive_sections = {
                    lualine_a = {},
                    lualine_b = {},
                    lualine_c = { "filename" },
                    lualine_x = { "location" },
                    lualine_y = {},
                    lualine_z = {},
                },
                tabline = {},
                winbar = {},
                inactive_winbar = {},
                extensions = {},
            })
        end,
    },
    -- Tmux compatability
    { "christoomey/vim-tmux-navigator" },
    -- LSP
    {
        "williamboman/mason.nvim",
        lazy = false,
        config = function()
            require("mason").setup({})
        end,
    },
    {
        "VonHeikemen/lsp-zero.nvim",
        lazy = false,
        config = function()
            local lsp_zero = require("lsp-zero").preset({})
            lsp_zero.extend_lspconfig()
        end,
        dependences = {
            "neovim/nvim-lspconfig",
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
            "hrsh7th/nvim-cmp",
            "hrsh7th/cmp-nvim-lsp",
            "L3MON4D3/LuaSnip",
        },
    },
    {
        "neovim/nvim-lspconfig",
        lazy = false,
    },
    {
        "williamboman/mason-lspconfig.nvim",
        lazy = false,
        config = function()
            local lsp_zero = require("lsp-zero").preset({})
            lsp_zero.extend_lspconfig()

            local handlers = {
                function(server_name)
                    require("lspconfig")[server_name].setup({})
                end,
            }
            require("mason-lspconfig").setup({
                handlers = handlers,
            })
        end,
        dependencies = { "neovim/nvim-lspconfig" },
    },
    -- Autocompletion
    { "hrsh7th/nvim-cmp" },
    { "hrsh7th/cmp-nvim-lsp" },
    { "L3MON4D3/LuaSnip" },
    -- Undo tree
    { "mbbill/undotree" },
    -- Git integration
    { "tpope/vim-fugitive" },
    -- Python pep8 indentation
    { "vimjas/vim-python-pep8-indent" },
    -- For file structure
    { "preservim/tagbar" },
}
