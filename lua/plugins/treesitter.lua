local treesitter = {
  'nvim-treesitter/nvim-treesitter',
  branch = 'main',
  lazy = false,
  build = ':TSUpdate',
  dependencies = {
    'nvim-treesitter/nvim-treesitter-textobjects',
  },
  config = function()
    require('nvim-treesitter.configs').setup({
      ensure_installed = {
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
        "c",
        "cpp",
      },
      highlight = { enable = true },
      indent = { enable = true },
      textobjects = {
        move = {
          enable = true,
          set_jumps = false, -- Not Adds positions to the jumplist (use Ctrl+o / Ctrl+i to jump back/forth)
          goto_next_start = {
            ["<leader>j"] = "@function.outer",
          },
          goto_previous_start = {
            ["<leader>k"] = "@function.outer",
          },
        },
      },
    })
  end,
}

return treesitter
