local treesitter = {
  'nvim-treesitter/nvim-treesitter',
  branch = 'main',
  lazy = false,
  build = ':TSUpdate',
  config = function()
    local ts = require('nvim-treesitter')
    ts.setup()
    ts.install({
      "lua",
      "vim",
      "vimdoc",
      "query",
      "markdown",
      "markdown_inline",
      "javascript",
      "typescript",
      "python",
      "html",
      "css",
    })

    -- Enable Neovim 0.12 native Treesitter highlighting
    vim.api.nvim_create_autocmd('FileType', {
      callback = function()
        pcall(vim.treesitter.start)
      end,
    })
  end,
}

return treesitter
