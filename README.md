# nvim-learn

A modern, high-performance Neovim configuration built for **Neovim 0.12+**, featuring native LSP standards, Treesitter highlighting, auto-completion, static analysis, and debugging workflows.

---

## Directory Structure

```text
~/.config/nvim-learn/
├── init.lua                   # Main entry point; loads config.lazy and vim-options
├── lazy-lock.json             # Pinned lockfile for lazy.nvim plugin dependencies
├── GEMINI.md                  # Persistent memory and operational guidelines for AI assistants
├── README.md                  # Project overview and structure documentation
└── lua/
    ├── vim-options.lua        # General editor options (tabstop, shiftwidth) & keymaps
    ├── config/
    │   └── lazy.lua           # Lazy.nvim bootstrap & plugin loader
    └── plugins/
        ├── completions.lua    # nvim-cmp, LuaSnip, snippets & LSP completion source
        ├── debugger.lua       # nvim-dap, nvim-dap-ui & GDB adapter integration
        ├── gruvbox.lua        # Gruvbox colorscheme configuration
        ├── lsp-config.lua     # Native LSP configs, Mason, Diagnostics & lsp_signature
        ├── lualine.lua        # Statusline configuration with devicons & gruvbox theme
        ├── markdown_priview.lua # Markdown preview in browser via markdown-preview.nvim
        ├── neo-tree.lua       # File explorer sidebar (<C-n>)
        ├── none-ls.lua        # Formatting & linting (stylua, clang-format, cppcheck)
        ├── telescope.lua      # Fuzzy finder, fzf-native, and ui-select
        ├── toggle_term.lua    # Integrated floating/horizontal terminal (<C-x>)
        ├── treesitter.lua     # Tree-sitter parsers & native Neovim 0.12 highlighting
        └── which-key.lua      # Keybinding helper popup
```

---

## Module Overview

### 1. Core Entry & Options
* **`init.lua`**: Bootstraps the configuration by requiring `config.lazy` and `vim-options`.
* **`lua/vim-options.lua`**:
  * Indentation: 2 spaces (`expandtab`, `tabstop=2`, `softtabstop=2`, `shiftwidth=2`).
  * Normal mode transition: `<C-Space>` and `<C-@>` map to `<Esc>`.
  * Insert mode navigation & editing: `<C-v>` (right), `<C-j>` (down), `<C-k>` (up), `<C-o>` (new line below), `<C-p>` (new line above), `<C-u>` (undo), `<C-z>` (redo).
  * Visual mode register execution: `@` executes macro across visual selection.

### 2. Plugin Management (`lua/config/lazy.lua`)
* Uses [`folke/lazy.nvim`](https://github.com/folke/lazy.nvim) with automatic bootstrapping.
* Loads all plugin specifications dynamically from the `lua/plugins/` directory.

### 3. LSP & Language Tools (`lua/plugins/lsp-config.lua` & `lua/plugins/none-ls.lua`)
* **Neovim 0.12+ Native Standards**:
  * Uses modern `vim.lsp.config("<server>", opts)` and `vim.lsp.enable("<server>")`.
  * Avoids deprecated `lspconfig.<server>.setup()` API.
* **Mason Integration**: Automatically installs and configures `lua_ls` and `clangd`.
  * `clangd`: Configured with `--function-arg-placeholders=0` to keep function call completions clean.
* **Signature Help (`lsp_signature.nvim`)**:
  * 1-line compact floating window below the cursor (`doc_lines = 0`) showing full function signature.
  * Inline virtual indicator: Displays only the penguin icon `🐧 ` at the cursor position without cluttering the buffer text.
* **Diagnostics (`vim.diagnostic`)**:
  * Displays inline virtual text prefixed with `●` and shows the error source (`clangd`, `null-ls`).
  * Automatic path shortening: Truncates absolute workspace paths to relative paths starting from the project root.
  * Shortcut: `se` in normal mode opens floating diagnostic details.
* **Formatting & Linting (`none-ls.lua`)**:
  * Managed via `mason-null-ls.nvim` and `none-ls.nvim`.
  * Formatters: `stylua` (Lua), `clang-format` (C/C++), `prettier` (Java/web), `black` (Python).
  * Linters: `cppcheck` (C/C++ diagnostics).

### 4. Completions & Snippets (`lua/plugins/completions.lua`)
* **Engine**: [`hrsh7th/nvim-cmp`](https://github.com/hrsh7th/nvim-cmp).
* **Sources**: `cmp-nvim-lsp` (LSP completions), `cmp_luasnip` (Snippets), `buffer` (Current buffer words).
* **Snippet Provider**: `LuaSnip` with `friendly-snippets`.

### 5. Syntax Highlighting (`lua/plugins/treesitter.lua`)
* Uses `nvim-treesitter` on the `main` branch.
* Syntax highlighting handled natively by Neovim 0.12 via `vim.treesitter.start`.

### 6. UI & Navigation
* **`neo-tree.lua`**: File tree sidebar toggled with `<C-n>`.
* **`telescope.lua`**: Fuzzy search for files (`<leader>ff`), live grep (`<leader>fg`), buffers (`<leader>fb`), help tags (`<leader>fh`).
* **`toggle_term.lua`**: Terminal integration toggled with `<C-x>`.
* **`lualine.lua`**: Gruvbox-styled statusline.
* **`which-key.lua`**: Displays available keybindings on `<leader>?`.

### 7. Debugging (`lua/plugins/debugger.lua`)
* Powered by `nvim-dap` and `nvim-dap-ui`.
* Configured with GDB adapter:
  * `<Leader>db`: Toggle breakpoint
  * `<Leader>dc`: Continue execution

---

## Keymaps Reference

| Mode | Shortcut | Action | Module |
| :--- | :--- | :--- | :--- |
| **Normal** | `<C-n>` | Toggle Neo-tree explorer | `neo-tree` |
| **Normal** | `<C-x>` | Toggle terminal (horizontal split) | `toggleterm` |
| **Normal** | `sd` / `sr` | Hover symbol documentation (`vim.lsp.buf.hover`) | LSP |
| **Normal** | `se` | Show diagnostic error popup (`vim.diagnostic.open_float`) | LSP |
| **Normal** | `gd` | Go to definition | LSP |
| **Normal** | `gp` | Go to declaration | LSP |
| **Normal** | `<Leader>ca` | LSP Code Actions | LSP |
| **Normal** | `fm` | Format buffer (`vim.lsp.buf.format`) | LSP / none-ls |
| **Normal** | `<leader>ff` | Find files | Telescope |
| **Normal** | `<leader>fg` | Live grep text across files | Telescope |
| **Normal** | `<leader>fb` | List open buffers | Telescope |
| **Normal** | `<leader>fh` | Search help documentation | Telescope |
| **Normal** | `<Leader>db` | Toggle debug breakpoint | DAP |
| **Normal** | `<Leader>dc` | Debug continue | DAP |
| **Insert** | `<C-Space>` / `<C-@>` | Exit insert mode to Normal mode | vim-options |
| **Insert** | `<CR>` | Confirm autocomplete selection | nvim-cmp |
| **Insert** | `<C-v>`, `<C-j>`, `<C-k>` | Navigate cursor Right, Down, Up | vim-options |
| **Visual** | `@` | Execute register across visual selection | vim-options |
