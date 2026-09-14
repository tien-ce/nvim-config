local mason_none_ls = {
  "jay-babu/mason-null-ls.nvim",
  dependencies = {
      "williamboman/mason.nvim",
      "nvimtools/none-ls.nvim",
  },
  config = function()
    require("mason-null-ls").setup({
      ensure_installed = {
        "stylua", -- Formatter for Lua
        "clang-format", -- Formatter for C/C++
        "prettier", -- Formatter for java
        "black", -- Formatter for python
        "ruff", -- Linter for python
      },
      automatic_installation = false,
    })
  end,
}

local none_ls = {
  "nvimtools/none-ls.nvim",
  config = function()
    local null_ls = require("null-ls")
    -- Set up
    null_ls.setup({
      sources = {
        null_ls.builtins.formatting.stylua,
        null_ls.builtins.formatting.clang_format,
        null_ls.builtins.formatting.prettier,
        null_ls.builtins.formatting.black,
        null_ls.builtins.diagnostics.cppcheck, -- Needs to be manually downloaded via OS package manager rather than mason
        -- null_ls.builtins.diagnostics.ruff: null-ls no longer supports ruff (use LSP instead)
      },
    })
    -- Set keymap
  end
}

return {
  mason_none_ls,
  none_ls,
}
