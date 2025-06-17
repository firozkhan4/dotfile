return {
  "github/copilot.vim",
  config = function()
    vim.g.copilot_no_tab_map = true  -- Prevent Copilot from overriding <Tab>
    vim.g.copilot_assume_mapped = true  -- Assume mappings are set
    vim.g.copilot_filetypes = {
      ["*"] = true,  -- Enable Copilot for all filetypes
    }

    vim.api.nvim_set_keymap("i", "<C-l>", 'copilot#Accept("<CR>")', { expr = true, silent = true })
  end
}
