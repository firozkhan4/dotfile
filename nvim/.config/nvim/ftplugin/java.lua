local jdtls = require("jdtls")

local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")

local workspace_dir = vim.fn.getcwd() .. "/.jdtls"
vim.fn.mkdir(workspace_dir, "p") -- Ensure it exists

local root_markers = { ".git", "mvnw", "gradlew", "pom.xml", "build.gradle" }
local root_dir = require("jdtls.setup").find_root(root_markers) or vim.fn.getcwd()

print("JDTLS root dir: " .. root_dir)

-- Updated Lombok path (verify this exists)
local lombok_path = "/home/firoz/.local/share/nvim/mason/packages/jdtls/lombok.jar"

-- First verify the lombok.jar exists
if vim.fn.filereadable(lombok_path) == 0 then
  vim.notify("Lombok jar not found at: " .. lombok_path, vim.log.levels.WARN)
end

local on_attach = function(client, bufnr)
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

  -- Enable DAP and Lombok support
  jdtls.setup_dap({ hotcodereplace = "auto" })
  jdtls.setup.add_commands() -- Adds all jdtls commands

  -- Enable completion that works with Lombok
  client.server_capabilities.completionProvider = {
    resolveProvider = true,
    triggerCharacters = { ".", "@" }
  }
end

local config = {
  cmd = {
    "/opt/jdk-21.0.7-full/bin/java",
    "-javaagent:" .. lombok_path,
    "-Xbootclasspath/a:" .. lombok_path,
    "-Declipse.application=org.eclipse.jdt.ls.core.id1",
    "-Dosgi.bundles.defaultStartLevel=4",
    "-Declipse.product=org.eclipse.jdt.ls.core.product",
    "-Dlog.protocol=true",
    "-Dlog.level=ALL",
    "-Xmx2g", -- Increased memory
    "--add-modules=ALL-SYSTEM",
    "--add-opens", "java.base/java.util=ALL-UNNAMED",
    "--add-opens", "java.base/java.lang=ALL-UNNAMED",
    "-jar", vim.fn.glob("/home/firoz/.local/share/nvim/mason/packages/jdtls/plugins/org.eclipse.equinox.launcher_*.jar"),
    "-configuration", "/home/firoz/.local/share/nvim/mason/packages/jdtls/config_linux",
    "-data", workspace_dir,
  },

  root_dir = root_dir,

  settings = {
    java = {
      signatureHelp = { enabled = true },
      contentProvider = { preferred = "fernflower" },
      completion = {
        favoriteStaticMembers = {
          "org.junit.Assert.*",
          "org.junit.jupiter.api.Assertions.*",
          "org.mockito.Mockito.*"
        },
        filteredTypes = {
          "com.sun.*",
          "io.micrometer.shaded.*",
          "java.awt.*",
          "jdk.*",
          "sun.*",
        },
      },
      sources = {
        organizeImports = {
          starThreshold = 9999,
          staticStarThreshold = 9999,
        },
      },
      codeGeneration = {
        toString = {
          template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}"
        },
        useBlocks = true,
      },
      configuration = {
        runtimes = {
          {
            name = "JavaSE-21",
            path = "/opt/jdk-21.0.7-full"
          },
        }
      }
    },
  },

  init_options = {
    -- Add any bundles you need here
    bundles = {},
    extendedClientCapabilities = jdtls.extendedClientCapabilities,
  },

  on_attach = on_attach,
  capabilities = require('cmp_nvim_lsp').default_capabilities(), -- If using nvim-cmp
}

-- Enable Lombok-specific settings
config.init_options.extendedClientCapabilities = config.init_options.extendedClientCapabilities or {}
config.init_options.extendedClientCapabilities.resolveAdditionalTextEditsSupport = true

-- Start JDTLS
jdtls.start_or_attach(config)

-- Optional: Setup formatters
local function setup_formatters()
  require("conform").setup({
    formatters_by_ft = {
      java = { "google-java-format" },
    },
  })
end

setup_formatters()
