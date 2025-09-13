return {
  'mfussenegger/nvim-jdtls',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'mfussenegger/nvim-dap'
  },
  config = function()
    local jdtls = require("jdtls")

    -- Define root dir with fallback
    local root_markers = { ".git", "mvnw", "gradlew", "pom.xml", "build.gradle" }
    local root_dir = require("jdtls.setup").find_root(root_markers) or vim.fn.getcwd()
    print("JDTLS root dir: " .. root_dir)

    -- Setup config
    local config = {
      cmd = {
        "jdtls",
        "--jvm-arg=-javaagent:" .. vim.fn.expand("~/.local/share/nvim/mason/packages/jdtls/lombok.jar"),
      },
      root_dir = root_dir,
      settings = {
        java = {},
      },
      init_options = {
        bundles = {},
      },
    }

    -- Start only when editing Java files
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "java",
      callback = function()
        jdtls.start_or_attach(config)
      end,
    })
  end
}
