local jdtls = require('jdtls')
local root_dir = require('jdtls.setup').find_root({ '.git', 'mvnw', 'gradlew', 'pom.xml', 'build.gradle' })

-- Define on_attach function to set keymaps when LSP attaches
local function on_attach(_, bufnr)
  local opts = { noremap = true, silent = true, buffer = bufnr }

  -- LSP standard keymaps
  vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
  vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
  vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
  vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
  vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
  vim.keymap.set("n", "<leader>f", function()
    vim.lsp.buf.format { async = true }
  end, opts)

  -- JDTLS specific
  vim.keymap.set("n", "<leader>oi", jdtls.organize_imports, opts)
  vim.keymap.set("n", "<leader>ev", jdtls.extract_variable, opts)
  vim.keymap.set("v", "<leader>em", "<Esc><Cmd>lua require'jdtls'.extract_method(true)<CR>", opts)
end

if root_dir then
  jdtls.start_or_attach({
    cmd = { 'jdtls' },
    root_dir = root_dir,
    on_attach = on_attach, -- 👈 keymaps set here
  })
else
  vim.notify("jdtls: No root_dir found", vim.log.levels.WARN)
end
