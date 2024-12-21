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
            local configs = require("nvim-treesitter.configs")
            configs.setup({
                ensure_install = {
                    "c",
                    "cpp",
                    "lua",
                    "vim",
                    "vimdoc",
                    "python",
                    "haskell",
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
            local configs = require("nvim-tree")
            configs.setup({
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
            require("mason").setup({
                providers = { "mason.providers.client" },
                registries = { "github:mason-org/mason-registry@latest" },
                log_level = vim.log.levels.DEBUG,
            })
        end,
    },
    {
        "neovim/nvim-lspconfig",
        lazy = false,
    },
    {
        "williamboman/mason-lspconfig.nvim",
        lazy = false,
        config = function()
            local handlers = {
                function(server_name)
                    require("lspconfig")[server_name].setup({})
                end,
                -- After can provide targeted overrides for specific servers
            }
            require("mason-lspconfig").setup({
                handlers=handlers,
            })
        end,
        dependencies = { "neovim/nvim-lspconfig" },
    },
    {
        "VonHeikemen/lsp-zero.nvim",
        dependences = {
            "neovim/nvim-lspconfig",
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
            "hrsh7th/nvim-cmp",
            "hrsh7th/cmp-nvim-lsp",
            "L3MON4D3/LuaSnip",
        },
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
    {
        "stsewd/isort.nvim",
        build = ":UpdateRemotePlugins",
        init = function()
            vim.api.nvim_create_autocmd({ "BufWritePre" }, {
                pattern = "*.py",
                command = "Isort --line-lenght 100 --combine-as --profile black --use-parenthese --atomic --multi-line 3",
        })
        end,
    },
    {
        "averms/black-nvim",
        build = ":UpdateRemotePlugins",
        init = function()
            vim.api.nvim_create_autocmd({ "BufWritePre" }, {
                pattern = "*.py",
                command = "call Black()",
            })
        end,
    },

    -- For file structure
    { "preservim/tagbar" },

    -- Asynchronously run programs
    { "neomake/neomake" },


    -- Linting
    {
        "mfussenegger/nvim-lint",
        event = {
            "BufReadPre",
            "BufNewFile",
        },
        config = function()
            local lint = require("lint")
            lint.linters_by_ft = {
                python = { "pylint" },
            }

            local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })
            vim.api.nvim_create_autocmd({ "BufWritePost" }, {
                group = lint_augroup,
                callback = function() lint.try_lint() end,
            })

            vim.keymap.set("n", "<leader>l", function()
                lint.try_lint()
            end, { desc = "Trigger linting for current file" })
        end,
    },

    -- Haskell
    { "itchyny/vim-haskell-indent", lazy=false },
    { "alx741/vim-hindent" },
    { "neovimhaskell/haskell-vim", lazy=false },
}
