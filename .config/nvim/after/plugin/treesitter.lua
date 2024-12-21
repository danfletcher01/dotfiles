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
        -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
        -- Set this to `true` if you depend on `syntax` being enabled (like for indentation).
        -- Using this option may slow down your editor, and you may see some duplicat ehighlights.
        -- Instead of true it can also be a list of languages
        addition_vim_regex_highlighting = false,
    },
})

require("nvim-treesitter.install").prefer_git = true
