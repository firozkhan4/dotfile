-- Set leader key to Space
vim.g.mapleader = " "

local opt= { noremap = true, silent = true }

local keymap = vim.keymap
local cmd = vim.cmd

keymap.set('n', '<C-a>', 'gg<S-v>G')
-- Open Ex mode
keymap.set("n", "<leader>ls", cmd.Ex, opt)

keymap.set('v', "J", ":m '>+1<CR>gv=gv")
keymap.set('v', "K", ":m '<-2<CR>gv=gv")

-- Split the window horizontally
keymap.set("n", "<leader>sh", function()
  cmd("split")
end, { noremap = true, silent = true })

-- Split the window vertically
keymap.set("n", "<leader>sv", function()
  cmd("vsplit")
end, { noremap = true, silent = true })

-- Close the current window
keymap.set("n", "<leader>xx", function()
  cmd("bd!")
end, { noremap = true, silent = true })

-- Delete buffer
keymap.set("n", "bd", cmd.bd, { noremap = true, silent = true })

-- Switch to the next buffer
keymap.set("n", "<Tab>", ":bnext<CR>", { noremap = true, silent = true })

-- Switch to the previous buffer
keymap.set("n", "<S-Tab>", ":bprevious<CR>", { noremap = true, silent = true })

keymap.set("n", "nn", function()
  local pwd = vim.api.nvim_buf_get_name(0)
  local path = vim.fn.input("", pwd)
  local dir = vim.fn.fnamemodify(path, ":p:h")

  if vim.fn.isdirectory(dir) == 0 then
    vim.fn.mkdir(dir, "p")
  end

  cmd("e " .. path)
end, opt)

-- Switch between buffer
keymap.set("n", "<C-l>", "<C-w>w", opt)
keymap.set("n", '<C-h>', '<C-w>h', opt)


vim.keymap.set("n", "<leader>f", function() 
	vim.lsp.buf.format() 
end, opt)

keymap.set("n", "<leader>rt", function()
  vim.cmd("set relativenumber!")
end)

