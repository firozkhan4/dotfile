local status, ts_ls = pcall(require, "ts_ls")
if not status then
  return
end

local config = {
  cmd = { "typescript-language-server", "--stdio" },
  filetypes = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx" },
}

require("ts_ls").start_or_attach(config)
