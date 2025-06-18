return {
  "mason-org/mason-lspconfig.nvim",
  opts = {},
  dependencies = {
    {
      "mason-org/mason.nvim",
      opts = {
        ui = {
          icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗"
          }
        }
      }
    },
    "neovim/nvim-lspconfig",
    "mfussenegger/nvim-dap",
    "jay-babu/mason-nvim-dap.nvim",
  },
  config = function()
    require("mason").setup()
    require("mason-lspconfig").setup({
      ensure_installed = { "lua_ls", "rust_analyzer" },
      automatic_installation = true
    })
    require('mason-nvim-dap').setup({
      ensure_installed = { 'stylua', 'jq', "ts_ls" },
      handlers = {
        function(config)
          -- all sources with no handler get passed here

          -- Keep original functionality
          require('mason-nvim-dap').default_setup(config)
        end,
        python = function(config)
          config.adapters = {
            type = "executable",
            command = "/usr/bin/python3",
            args = {
              "-m",
              "debugpy.adapter",
            },
          }
          require('mason-nvim-dap').default_setup(config) -- don't forget this!
        end,
      },
    })

  end
}
