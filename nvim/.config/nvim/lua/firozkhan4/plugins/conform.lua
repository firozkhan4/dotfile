return {
  "stevearc/conform.nvim",
  opts = function()
    -- Protect against overriding conform.nvim config in LazyVim
    local plugin = require("lazy.core.config").plugins["conform.nvim"]
    if plugin.config ~= nil and plugin.config.setup then
      LazyVim.error({
        "Don't set `plugin.config` for `conform.nvim`.\n",
        "This will break **LazyVim** formatting.\n",
        "Please refer to the docs at https://www.lazyvim.org/plugins/formatting",
      }, { title = "LazyVim" })
    end

    ---@type conform.setupOpts
    local opts = {
      default_format_opts = {
        timeout_ms = 3000,
        async = false,       -- Don't change unless you know what you're doing
        quiet = false,       -- Controls error message verbosity
        lsp_format = "fallback", -- Prefer lsp if available
      },

      -- Formatter list per filetype
      formatters_by_ft = {
        lua = { "stylua" },
        fish = { "fish_indent" },
        sh = { "shfmt" },
        -- Add more filetypes here as needed
        -- javascript = { "prettier" },
        -- json = { "prettier" },
      },

      -- Custom formatter configuration
      formatters = {
        injected = { options = { ignore_errors = true } },

        -- Uncomment and configure these as needed:
        -- dprint = {
        --   condition = function(ctx)
        --     return vim.fs.find({ "dprint.json" }, { path = ctx.filename, upward = true })[1]
        --   end,
        -- },

        -- shfmt = {
        --   prepend_args = { "-i", "2", "-ci" },
        -- },
      },
    }

    return opts
  end,
}
