return   {
    "windwp/nvim-autopairs",
    config = function()
        require("nvim-autopairs").setup({
            disable_filetype = { "TelescopePrompt", "vim" }, -- Disable in specific filetypes
            check_ts = true, -- Enable Treesitter integration
        })
    end,
    dependencies = {
        "nvim-treesitter/nvim-treesitter", -- Optional: For Treesitter integration
    },
}
