return {
  "stevearc/conform.nvim",
  opts = {},
  config = function()
    require("conform").setup({
      formatters_by_ft = {
        lua = { "stylua" },
        python = { "black" },
        java = { "google_java_format" },
        go = { "gofmt" },
        xml = { "xmlformatter" },
        html = { "prettier" },
        css = { "prettier" },
        json = { "prettier" },
        markdown = { "prettier" },
        yaml = { "prettier" },
        yml = { "prettier" },
        rust = { "rustfmt" },
      },
    })
  end
}
