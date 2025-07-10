local jdtls = require("jdtls")

local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
local workspace_dir = "/home/firoz/Dev/personal/" .. project_name

local lombok_path = "/home/firoz/.local/share/nvim/mason/packages/jdtls/lombok.jar"

local on_attach = function(_, bufnr)
  local opts = { noremap = true, silent = true, buffer = bufnr }

  -- Common LSP keymaps
  vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
  vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
  vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
  vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
  vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
  vim.keymap.set("n", "<leader>fm", function() vim.lsp.buf.format { async = true } end, opts)

  -- JDTLS specific keymaps
  vim.keymap.set("n", "<leader>oi", jdtls.organize_imports, opts)
  vim.keymap.set("n", "<leader>ev", jdtls.extract_variable, opts)
  vim.keymap.set("v", "<leader>em", function() jdtls.extract_method(true) end, opts)

  -- More jdtls features
  jdtls.setup_dap({ hotcodereplace = "auto" }) -- Enable Debug Adapter Protocol if needed
end

local config = {
  cmd = {
    "java",
    "-javaagent:" .. lombok_path,
    "-Xbootclasspath/a:" .. lombok_path,
    "-Declipse.application=org.eclipse.jdt.ls.core.id1",
    "-Dosgi.bundles.defaultStartLevel=4",
    "-Declipse.product=org.eclipse.jdt.ls.core.product",
    "-Dlog.protocol=true",
    "-Dlog.level=ALL",
    "-Xmx1g",
    "--add-modules=ALL-SYSTEM",
    "--add-opens", "java.base/java.util=ALL-UNNAMED",
    "--add-opens", "java.base/java.lang=ALL-UNNAMED",
    "-jar", "/home/firoz/.local/share/nvim/mason/packages/jdtls/plugins/org.eclipse.equinox.launcher_1.7.0.v20250331-1702.jar",
    "-configuration", "/home/firoz/.local/share/nvim/mason/packages/jdtls/config_linux",
    "-data", workspace_dir,
  },

  root_dir = require("jdtls.setup").find_root({ ".git", "mvnw", "gradlew" }),

  settings = {
    java = {},
  },

  init_options = {
    bundles = {},
  },

  on_attach = on_attach,
}

jdtls.start_or_attach(config)
