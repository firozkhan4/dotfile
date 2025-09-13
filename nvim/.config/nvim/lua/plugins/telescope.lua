return {
  'nvim-telescope/telescope.nvim',
  tag = '0.1.8',
  dependencies = { 'nvim-lua/plenary.nvim' },
  config = function()
    require('telescope').setup {
      defaults = {
        file_ignore_patterns = { "node_modules", "%.class" },
        vimgrep_arguments = {
          'rg',
          '--color=never',
          '--no-heading',
          '--with-filename',
          '--line-number',
          '--column',
          '--smart-case',
          '--hidden'
        }
      },
    }

    local builtin = require('telescope.builtin')
    vim.keymap.set('n', '<leader>fg', builtin.git_files, { desc = 'Telescope find git files' })
    vim.keymap.set('n', '<leader>fe', function()
      require('telescope.builtin').find_files({ hidden = true, default_text = ".env" })
    end, { desc = "Find .env file" })
    vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
    vim.keymap.set('n', '<leader>fs', builtin.live_grep, { desc = 'Telescope live grep' })
    vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
    vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })
    vim.keymap.set('n', '<leader>fc', function()
      builtin.find_files({ cwd = "~/.config/nvim" })
    end, { desc = 'Find Neovim config files' })
    vim.keymap.set('n', '<leader>fr', builtin.oldfiles, { desc = 'Find recent files' })
    vim.keymap.set('n', '<leader>fk', builtin.keymaps, { desc = 'Find keymaps' })
  end
}
