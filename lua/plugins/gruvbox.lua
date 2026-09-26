local gruv_box = {
    "ellisonleao/gruvbox.nvim",
    priority = 1000 ,
    config = function(_,opts)
      require("gruvbox").setup(opts) -- Load the module (require) and set up follow the opts
      vim.cmd.colorscheme("gruvbox") -- Active the theme to gruvbox
    end,
    opts =
    {
    }
}

return gruv_box
