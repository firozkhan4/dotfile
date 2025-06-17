return {
  "williamboman/mason.nvim",
  opts = {
    ensure_installed = { "lua_ls", "rust_analyzer", "ts_ls", "eslint" },
    ui = {
      icons = {
        package_installed = "✓",
        package_pending = "➜",
        package_uninstalled = "✗"
      }
    }
  },
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
    "neovim/nvim-lspconfig",
  },
  config = function()
    require("mason").setup()

    local mason_lspconfig = require("mason-lspconfig")

    mason_lspconfig.setup({
      ensure_installed = { "lua_ls", "rust_analyzer", "ts_ls", "eslint" },
      automatic_installation = true,
    })

    vim.lsp.config("lua_ls", {})
    vim.lsp.config("rust_analyzer", {})

    local lspconfig = require("lspconfig")

    -- mason_lspconfig.setup_handlers({
    --   -- Default handler for every installed server
    --   function(server_name)
    --     lspconfig[server_name].setup({})
    --   end,
    --
    --   -- Custom config for eslint
    --   ["eslint"] = function()
    --     lspconfig.eslint.setup({
    --       on_attach = function(client, bufnr)
    --         vim.api.nvim_create_autocmd("BufWritePre", {
    --           buffer = bufnr,
    --           command = "EslintFixAll",
    --         })
    --       end,
    --     })
    --   end,
    -- })

    -- Global LSP keymaps
    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("UserLspConfig", {}),
      callback = function(ev)
        local opts = { buffer = ev.buf }
        vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
        vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
        vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
        vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)
        vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
        vim.keymap.set("n", "<leader>so", require("telescope.builtin").lsp_document_symbols, opts)
        vim.keymap.set("n", "<leader>sw", require("telescope.builtin").lsp_dynamic_workspace_symbols, opts)
      end,
    })
  end
}
