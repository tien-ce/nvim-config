local neotree = 
{
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies =
  {
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    "nvim-tree/nvim-web-devicons", -- optional, but recommended
  },
  lazy = false, -- neo-tree will lazily load itself
  config = function(_,opts)
    -- 1. Initialize neo-tree
    require("neo-tree").setup(opts)
    -- 2. Set up global key maps
    vim.keymap.set("n", "<C-n>", ":Neotree toggle<CR>", { desc = "Toogle Neo-tree", silent = true }) -- Ctrl + N for toggle neo tree
  end,
  opts = 
  {
  }
}
return neotree
