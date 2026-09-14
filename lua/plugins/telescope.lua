local telescope = {
    'nvim-telescope/telescope.nvim', version = '*',
    dependencies = {
        'nvim-lua/plenary.nvim',
        -- optional but recommended
        { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    },
    config = function()
      -- Require the builtin module
      local builtin = require("telescope.builtin")

      -- Set up keymaps
      vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Find Files" })
      vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Live Grep" })
      vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Buffers" })
      vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Help Tags" }) 
    end
}

local telescope_ui_ex = {
  'nvim-telescope/telescope-ui-select.nvim',
  config = function()
    require("telescope").setup {
      extensions = {
        ["ui-select"] = {
          require("telescope.themes").get_dropdown {}
        }
      }
    }
    -- Active UI select into telescope
    require("telescope").load_extension("ui-select")
  end
}

return {
  telescope,
  telescope_ui_ex,
}
