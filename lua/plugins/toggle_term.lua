return {
  "akinsho/toggleterm.nvim",
  version = "*",
  config = function()
    require("toggleterm").setup({
      size = 15,
      open_mapping = '<C-x>', -- Shortcut to toggle terminal (customize as needed)
      hide_numbers = true,
      shade_terminals = true,
      shading_factor = 2,
      start_in_insert = true,
      insert_mappings = true,
      terminal_mappings = true,
      persist_size = true,
      direction = "horizontal", -- Open as a horizontal split at the bottom
      close_on_exit = true,
      shell = vim.o.shell,
    })
  end,
}
