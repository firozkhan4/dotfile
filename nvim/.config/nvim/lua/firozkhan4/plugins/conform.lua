return {
  "stevearc/conform.nvim",
  event = { "BufReadPre", "BufNewFile", "BufWritePre" },
  config = function()
    require("conform").setup({
      formatters_by_ft = {
        xml = { "xmlformatter" },      -- Or "xmllint", "xmlstarlet"
      },
    })
  end,
}
