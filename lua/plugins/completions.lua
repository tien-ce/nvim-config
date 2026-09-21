local lua_snip = {
  "L3MON4D3/LuaSnip",
  dependencies = {
    "saadparwaiz1/cmp_luasnip", -- get snippet list from lua snip, convert to format cmp can understand
    "rafamadriz/friendly-snippets", -- Provide snippet content (for loop,..)
  },
}

local nvim_cmp = {
  "hrsh7th/nvim-cmp",
  dependencies = {
    "hrsh7th/cmp-nvim-lsp", -- source for lsp completion items
  },
  config = function()
    local cmp = require("cmp")
    require("luasnip.loaders.from_vscode").lazy_load()
    cmp.setup({
      snippet = {
        -- REQUIRED - you must specify a snippet engine
        expand = function(args)
          require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
        end,
      },
      window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
      },
      mapping = cmp.mapping.preset.insert({
        ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        --["<C-Space>"] = cmp.mapping.complete(), -- open completion, C-n already is bultin in neovim
        ["<C-e>"] = cmp.mapping.abort(), -- Abort the completion
        ["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
        ["<Tab>"] = cmp.mapping.select_next_item(), -- Select next item in completion popup, or fallback to indent
        ["<S-Tab>"] = cmp.mapping.select_prev_item(), -- Select previous item in completion popup, or fallback
      }),
      sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "luasnip" }, -- For luasnip users.
      }, {
        { name = "buffer" },
      }),
    })
  end,
}

return {
  lua_snip,
  nvim_cmp,
}
