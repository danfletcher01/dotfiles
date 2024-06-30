require("nvim-treesitter.configs").setup({
    -- A list of parser names
    ensure_installed = {
        "c",
        "cpp",
        "json",
        "lua",
        "python",
        "vim",
        "vimdoc",
        "yaml",
    },
    ignore_install = {
        "gitcommit",
    },

    -- Install parsers synchronously (only applied to 'ensure installed')
    sync_install = false,

    -- Automatically install missing parsers when entering buffer
    auto_install = true,

    highlight = {
        enable = true,
    },
})
