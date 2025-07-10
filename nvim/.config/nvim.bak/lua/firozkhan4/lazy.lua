local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  require('firozkhan4.plugins.miniicons'),
  require("firozkhan4.plugins.jdtls"),
  require("firozkhan4.plugins.conform"),
  require("firozkhan4.plugins.mason"),
  require("firozkhan4.plugins.codeium"),
  require("firozkhan4.plugins.colortheme"),
  require("firozkhan4.plugins.emmet"),
  require("firozkhan4.plugins.autocmp"),
  require("firozkhan4.plugins.treesitter"),
  require("firozkhan4.plugins.bufferline"),
  require("firozkhan4.plugins.autopair"),
  require("firozkhan4.plugins.telescope"),
})
