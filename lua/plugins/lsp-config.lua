local mason_lsp_config = {
	"mason-org/mason-lspconfig.nvim",
	dependencies = {
		{ "mason-org/mason.nvim", opts = {} },
		"neovim/nvim-lspconfig",
	},
	config = function(_, opts)
		require("mason").setup()
		require("mason-lspconfig").setup(opts)
	end,
	opts = {
		ensure_installed = { "lua_ls", "clangd" },
	},
}

local lua_opts = {
	settings = {
		Lua = {
			diagnostics = {
				globals = { "vim" },
			},
			format = {
				enable = false,
			},
		},
	},
}
local clangd_opts = {
  cmd = {
    "clangd",
    "--background-index",
    "--function-arg-placeholders=0", -- Disable auto-inserting argument placeholders into function calls
  },
}
local nvim_lsp_config = {
	"neovim/nvim-lspconfig",
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
	},
	config = function()
		-- Diagnostic message formatter: strip cwd (project root) from paths
		local function format_diagnostic(diagnostic)
			local msg = diagnostic.message
			local cwd = vim.fn.getcwd()
			if cwd and #cwd > 1 then
				msg = msg:gsub(vim.pesc(cwd) .. "/", "")
			end
			return msg
		end

		-- Diagnostic display configuration
		vim.diagnostic.config({
			virtual_text = {
				prefix = "●",
				source = "always", -- Show source (e.g. clangd, null-ls)
				format = format_diagnostic,
			},
			float = {
				source = "always", -- Show source in popup
				border = "rounded",
				format = format_diagnostic,
			},
			signs = true,
			underline = true,
		})

		-- Set capabilities for all LSP servers
		local capabilities = require("cmp_nvim_lsp").default_capabilities()
		vim.lsp.config("*", {
			capabilities = capabilities,
		})
		-- Initialize the LSP server
		vim.lsp.config("lua_ls", lua_opts)
		vim.lsp.config("clangd", clangd_opts)
		-- Register the Attach function
		-- This function only run when a lsp server attached to current file
		vim.api.nvim_create_autocmd("LspAttach", {
			callback = function(args)
				local opts = { buffer = args.buf }
				-- Key map with LSP server
				vim.keymap.set("n", "sd", vim.lsp.buf.hover, opts)
				vim.keymap.set("n", "se", vim.diagnostic.open_float, opts) -- show error
				vim.keymap.set("n", "sr", vim.lsp.buf.hover, opts)
				vim.keymap.set("n", "gp", vim.lsp.buf.declaration, opts)
				vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
				vim.keymap.set("n", "<Leader>ca", vim.lsp.buf.code_action, opts)
				-- Key map with cli tools (none-ls server)
				vim.keymap.set("n", "fm", function()
					vim.lsp.buf.format({ async = true })
				end, opts)
			end,
		})
		-- Run the LSP server
		vim.lsp.enable("lua_ls")
		vim.lsp.enable("clangd")
	end,
}

local lsp_signature = {
	"ray-x/lsp_signature.nvim",
	event = "InsertEnter",
	opts = {
		bind = true,
		floating_window = true, -- Enable mini floating window
		doc_lines = 0, -- Show only 1-line signature, disable verbose doc comments
		floating_window_above_cur_line = false, -- Prioritize displaying below the current line
		hint_enable = true, -- Keep penguin icon inline
		hint_prefix = "🐧 ",
		hint_inline = function()
			return "inline"
		end,
		handler_opts = {
			border = "rounded",
		},
	},
	config = function(_, opts)
		-- Keep only the penguin icon at the cursor position (omit duplicate type and name since the 1-line floating window below shows full signature)
		local orig_set_extmark = vim.api.nvim_buf_set_extmark
		vim.api.nvim_buf_set_extmark = function(buffer, ns, line, col, ext_opts)
			local sig_ns = vim.api.nvim_get_namespaces()["lsp_signature_vt"]
			if sig_ns and ns == sig_ns and ext_opts and ext_opts.virt_text then
				ext_opts.virt_text = { { "🐧 ", "String" } }
			end
			return orig_set_extmark(buffer, ns, line, col, ext_opts)
		end

		require("lsp_signature").setup(opts)
	end,
}
return {
	mason_lsp_config,
	nvim_lsp_config,
	lsp_signature,
}
