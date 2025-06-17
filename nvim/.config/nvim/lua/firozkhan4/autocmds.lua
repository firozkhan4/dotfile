vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = { "*.js", "*.ts", "*.jsx", "*.tsx", "*.json", "*.css", "*.scss", "*.md" },
    callback = function()
        vim.lsp.buf.format({ async = true })
    end,
})

