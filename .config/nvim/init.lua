----------------------------------------------------------------------------------------------------
--                                             Packer                                             --
----------------------------------------------------------------------------------------------------
local install_path = vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    vim.fn.execute("!git clone https://github.com/wbthomason/packer.nvim " .. install_path)
end

local packer_group = vim.api.nvim_create_augroup("Packer", { clear = true })
vim.api.nvim_create_autocmd(
    "BufWritePost",
    { command = "source <afile> | PackerCompile", group = packer_group, pattern = "init.lua" }
)

require("packer").startup(function(use)
    use("wbthomason/packer.nvim") -- Package manager
    use("vetsE/vim-bepo")
    use("numToStr/Comment.nvim") -- "gc" to comment visual regions/lines
    use({ "nvim-telescope/telescope.nvim", requires = { "nvim-lua/plenary.nvim" } })
    use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" })
    use("nvim-lualine/lualine.nvim") -- Fancier statusline
    use("lukas-reineke/indent-blankline.nvim")
    use({ "lewis6991/gitsigns.nvim", requires = { "nvim-lua/plenary.nvim" } })
    use("nvim-treesitter/nvim-treesitter")
    use("nvim-treesitter/nvim-treesitter-textobjects")
    use("jose-elias-alvarez/null-ls.nvim")
    use("williamboman/mason.nvim")
    use("williamboman/mason-lspconfig.nvim")
    use("neovim/nvim-lspconfig")
    use("hrsh7th/cmp-nvim-lsp")
    use("hrsh7th/cmp-buffer")
    use("hrsh7th/cmp-path")
    use("hrsh7th/cmp-cmdline")
    use("hrsh7th/nvim-cmp")
    use("saadparwaiz1/cmp_luasnip")
    use("L3MON4D3/LuaSnip")
    use("shaunsingh/solarized.nvim")
    use("folke/tokyonight.nvim")
    use("EdenEast/nightfox.nvim")
    use("kevinhwang91/rnvimr")
    use("danymat/neogen")
    use("machakann/vim-sandwich")
    use("mechatroner/rainbow_csv")
    use("rafamadriz/friendly-snippets")
    use("ishan9299/nvim-solarized-lua")
    use("lewis6991/spellsitter.nvim")
    use("glepnir/lspsaga.nvim")
    use("ray-x/lsp_signature.nvim")
    use("mfussenegger/nvim-lint")
end)

----------------------------------------------------------------------------------------------------
--                                         General config                                         --
----------------------------------------------------------------------------------------------------

-- Only one common status bar
vim.o.laststatus = 3

-- Allow to change buffer without saving
vim.o.hidden = true

-- Set highlight on search
vim.o.hlsearch = true

-- Make line numbers default
vim.wo.number = true

-- No redraw while executing macros
vim.o.lazyredraw = true

-- Show the matching bracket
vim.o.showmatch = true
vim.o.mat = 2

-- Copy to clipboard by default
vim.o.clipboard = "unnamedplus"

-- Just wrap
vim.o.lbr = true

-- Display annoying non-printable characters
vim.o.list = true
vim.opt.listchars = { nbsp = "¤", tab = "▸ " }

-- Enable mouse mode
vim.o.mouse = "a"

-- Indenting stuff
vim.o.tabstop = 4 -- Number of spaces that a <Tab> counts for.
vim.o.shiftwidth = 4 -- Number of spaces that a shift insert.
vim.o.expandtab = true -- Use the appropriate number of spaces to insert a <Tab>.
vim.o.autoindent = true -- Copy the indentation of the last line.
vim.o.smartindent = true -- Smarter indenting.
vim.o.smarttab = true -- Smarter tabbing.

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undodir = "/home/vetse/.cache/nvim/undodir"
vim.opt.undofile = true
vim.opt.history = 1000

-- Case insensitive searching UNLESS /C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Encoding
vim.o.encoding = "utf-8"
vim.o.fileencoding = "utf-8"

-- Decrease update time
vim.o.updatetime = 250
vim.wo.signcolumn = "yes"

-- Set completeopt to have a better completion experience
vim.o.completeopt = "menuone,noselect"

----------------------------------------------------------------------------------------------------
--                                            Mapping                                             --
----------------------------------------------------------------------------------------------------

-- Disable that fucking command history
vim.keymap.set({"n", "v"}, "q:", "<Nop>", {silent = true})

-- Remap space as leader key
vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Open/close ranger
vim.keymap.set({ "n", "v" }, "<leader>o", ":RnvimrToggle<CR>", { silent = true })

-- More convenient C-o/C-i
vim.keymap.set("n", "<leader>e", "<C-o>", { silent = true })
vim.keymap.set("n", "<leader>i", "<C-i>", { silent = true })

-- Quick underline
vim.keymap.set("n", "<leader>-", "yypVr-<CR>", { silent = true })
vim.keymap.set("n", "<leader>=", "yypVr=<CR>", { silent = true })

-- Buffer navigation
vim.keymap.set("n", "<leader><leader>", ":b#<CR>", { silent = true })
vim.keymap.set("n", "<leader>t", ":bp<CR>", { silent = true })
vim.keymap.set("n", "<leader>s", ":bn<CR>", { silent = true })

-- Signature help
-- vim.keymap.set("n", "<leader>h", require("lspsaga.signaturehelp").signature_help, { silent = true, noremap = true })

-- Clear search matches
vim.keymap.set("n", "<leader><CR>", ":noh<CR>", { silent = true })

-- Format
vim.keymap.set("n", "<leader>f", vim.lsp.buf.format, { silent = true })
-------------------------------------------------------------------------------------------------
--                                      Plugin config                                          --
-------------------------------------------------------------------------------------------------

--------------------
-- Signature help --
--------------------

require("lsp_signature").setup({ floating_window = false, hint_prefix = "→ " })

----------
-- SAGA --
----------
local saga = require("lspsaga")
saga.init_lsp_saga({
    border_style = "rounded",
    show_diagnostic_source = true,
    code_action_lightbulb = {
        enable = false,
        sign = true,
        sign_priority = 100,
        virtual_text = true,
    },
})

---------------------
-- LSP server install
---------------------
require("mason").setup()
require("mason-lspconfig").setup()

------------
-- rnvimr --
------------

vim.g.rnvimr_enable_ex = 1
vim.g.rnvimr_enable_picker = 1

-------------
-- Comment --
-------------

-- Enable Comment.nvim
require("Comment").setup()

--------------
-- Snippets --
--------------

-- luasnip setup
local luasnip = require("luasnip")
require("luasnip/loaders/from_vscode").lazy_load()

------------
-- Neogen --
------------

require("neogen").setup({ enabled = true })

-----------------------
-- Highlight on yank --
-----------------------

local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
    callback = function()
        vim.highlight.on_yank()
    end,
    group = highlight_group,
    pattern = "*",
})

--------------
-- Gitsigns --
--------------

require("gitsigns").setup({
    signs = {
        add = { text = "+" },
        change = { text = "~" },
        delete = { text = "x" },
        topdelete = { text = "‾" },
        changedelete = { text = "~" },
    },
    update_debounce = 100,
    max_file_length = 40000,
})

--------------
-- Spelling --
--------------

require("spellsitter").setup()

-- vim.api.nvim_exec(
--     [[
--     augroup FormatAutogroup
--       autocmd!
--       autocmd BufWritePost *.py FormatWrite
--       autocmd BufWritePost *.sh FormatWrite
--       autocmd BufWritePost *.json FormatWrite
--     augroup END
-- ]],
--     true
-- )

---------------------
-- Auto-completion --
---------------------

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)

-- nvim-cmp setup
local has_words_before = function()
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local cmp = require("cmp")
cmp.setup({
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },
    preselect = true,
    completion = {
        autocomplete = false,
        completeopt = "menu,menuone,noinsert",
    },
    window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
        ["<C-d>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<CR>"] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
        }),
        ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif has_words_before() then
                cmp.complete()
            else
                fallback()
            end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, { "i", "s" }),
    }),
    sources = {
        { name = "path" },
        { name = "nvim_lsp" },
        { name = "luasnip" },
        -- { name = "buffer" },
    },
})



---------------
-- Telescope --
---------------

require("telescope").setup({
    defaults = {
        mappings = {
            i = {
                ["<C-u>"] = false,
                ["<C-d>"] = false,
            },
        },
    },
})

-- Enable telescope fzf native
require("telescope").load_extension("fzf")

-- Add leader shortcuts
vim.keymap.set("n", "<leader>ff", function()
    require("telescope.builtin").find_files({ previewer = false })
end)
vim.keymap.set("n", "<leader>fb", require("telescope.builtin").current_buffer_fuzzy_find)
vim.keymap.set("n", "<leader>fh", require("telescope.builtin").help_tags)
vim.keymap.set("n", "<leader>ft", require("telescope.builtin").tags)
vim.keymap.set("n", "<leader>b", require("telescope.builtin").buffers)
vim.keymap.set("n", "<leader>r", require("telescope.builtin").live_grep)
vim.keymap.set("n", "<leader>?", require("telescope.builtin").oldfiles)

----------------
-- Treesitter --
----------------

-- Parsers must be installed manually via :TSInstall
require("nvim-treesitter.configs").setup({
    highlight = {
        enable = true, -- false will disable the whole extension
    },
    incremental_selection = {
        enable = true,
        keymaps = {
            init_selection = "gnn",
            node_incremental = "grn",
            scope_incremental = "grc",
            node_decremental = "grm",
        },
    },
    indent = {
        enable = false,
    },
    textobjects = {
        select = {
            enable = true,
            lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
            keymaps = {
                -- You can use the capture groups defined in textobjects.scm
                ["aF"] = "@function.outer",
                ["iF"] = "@function.inner",
                ["ac"] = "@class.outer",
                ["ic"] = "@class.inner",
                ["ab"] = "@block.inner",
                ["ib"] = "@block.inner",
            },
        },
        move = {
            enable = true,
            set_jumps = true, -- whether to set jumps in the jumplist
            goto_next_start = {
                ["]m"] = "@function.outer",
                ["]]"] = "@class.outer",
            },
            goto_next_end = {
                ["]M"] = "@function.outer",
                ["]["] = "@class.outer",
            },
            goto_previous_start = {
                ["[m"] = "@function.outer",
                ["[["] = "@class.outer",
            },
            goto_previous_end = {
                ["[M"] = "@function.outer",
                ["[]"] = "@class.outer",
            },
        },
    },
})

----------------------------------------------------------------------------------------------------
--                                           LSP setup                                            --
----------------------------------------------------------------------------------------------------

-- LSP setup
local lspconfig = require("lspconfig")
local on_attach = function(_, bufnr)
    local opts = { buffer = bufnr }
    vim.keymap.set("n", "<leader>d", vim.lsp.buf.definition, opts)
    -- vim.keymap.set("n", "<leader>k", vim.lsp.buf.hover, opts)
    vim.keymap.set("n", "<leader>k", require("lspsaga.hover").render_hover_doc, opts)
    vim.keymap.set("n", "<leader>I", vim.lsp.buf.implementation, opts)
    vim.keymap.set("n", "<C-k>", require("lspsaga.hover").render_hover_doc, opts)
    vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, opts)
    vim.keymap.set("n", "<leader>n", vim.lsp.buf.rename, opts)
    vim.keymap.set("n", "<leader>a", vim.lsp.buf.code_action, opts)
    vim.keymap.set("n", "<leader>S", require("telescope.builtin").lsp_document_symbols, opts)
    vim.api.nvim_buf_create_user_command(bufnr, "Format", vim.lsp.buf.formatting, {})
end
-- Diagnostic setup
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
    virtual_text = false,
    signs = true,
    underline = true,
    update_in_insert = false,
})
vim.diagnostic.config({ virtual_text = false})

vim.keymap.set("n", "<leader>é", function()
    vim.diagnostic.open_float(0, { scope = "line", border = "rounded" })
end, { silent = true })
vim.keymap.set("n", "<F10>", function()
    vim.diagnostic.goto_next({ enable_popup = false })
end, { silent = true })
vim.keymap.set("n", "<S-F10>", function()
    vim.diagnostic.goto_prev({ enable_popup = false })
end, { silent = true })

-- Lua
lspconfig.sumneko_lua.setup({
    on_attach = on_attach,
    settings = {
        Lua = {
            runtime = { version = "LuaJIT" },
            diagnostics = { globals = { "vim" } },
            workspace = { library = vim.api.nvim_get_runtime_file("", true) },
            telemetry = { enable = false },
        },
    },
})

-- clang
local clang_cap = {unpack(capabilities)}
clang_cap.offsetEncoding = "utf-8"
lspconfig.clangd.setup({ on_attach = on_attach, capabilities = clang_cap })

-- bash
lspconfig.bashls.setup({ on_attach = on_attach, capabilities = capabilities })

-- eslint 
lspconfig.eslint.setup({ on_attach = on_attach, capabilities = capabilities })

-- json
lspconfig.jsonls.setup({ on_attach = on_attach, capabilities = capabilities })

-- cmake
lspconfig.cmake.setup({ capabilities = capabilities })

-- rust
lspconfig.rust_analyzer.setup({ on_attach = on_attach, capabilities = capabilities })

-- python
lspconfig.jedi_language_server.setup({
    on_attach = on_attach,
    capabilities = capabilities,
})
lspconfig.pylsp.setup({
    settings = {
        pylsp = {
            plugins = {
                pylint = { enabled = true },
                pyflakes = { enabled = false },
                pycodestyle = { enabled = false },
                mypy = { enabled = false },
            },
        },
    },
})

require('lint').linters_by_ft = {
  python = {'mypy',}
}
vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost" }, {
  callback = function()
    require("lint").try_lint()
  end,
})

---------------------
-- Auto-formatting --
---------------------

require("null-ls").setup({
    on_attach = on_attach,
    capabilities = capabilities,
    sources = {
        require("null-ls").builtins.formatting.black,
        require("null-ls").builtins.formatting.isort,
        require("null-ls").builtins.formatting.clang_format.with({ extra_args = {"--style=file:/home/vetse/.clang-format"}}),
        require("null-ls").builtins.formatting.stylua,
    },
})

----------------------------------------------------------------------------------------------------
--                                         Look and feel                                          --
----------------------------------------------------------------------------------------------------

-- Set colorscheme
vim.o.termguicolors = true
vim.cmd([[colorscheme solarized-high]])

-- Set statusbar
require("lualine").setup({
    options = {
        icons_enabled = true,
        component_separators = "|",
        section_separators = "",
        theme = "solarized_dark",
    },
    sections = {
        lualine_a = { "mode" },
        lualine_b = {},
        lualine_c = { { "filename", path = 1 } },
        lualine_x = { "encoding", "fileformat", "filetype" },
        lualine_y = { "progress" },
        lualine_z = { "location" },
    },
})

-- Display the cursor line
vim.o.cursorline = true

-- Show partial command
vim.o.showcmd = true

-- No fucking bells
vim.o.errorbells = false
vim.o.visualbell = false

-- Diagnostic signs
vim.fn.sign_define("DiagnosticSignError", { text = "✗", texthl = "DiagnosticSignError" })
vim.fn.sign_define("DiagnosticSignWarn", { text = "▲", texthl = "DiagnosticSignWarn" })
vim.fn.sign_define("DiagnosticSignInformation", { text = "", texthl = "DiagnosticSignInfo" })
vim.fn.sign_define("DiagnosticSignHint", { text = "", texthl = "DiagnosticSignHint" })

----------------------
-- Indent blankline --
----------------------

vim.cmd([[highlight! IndentBlanklineIndent1 guifg=#303b30 gui=nocombine]])
vim.cmd([[highlight! IndentBlanklineIndent2 guifg=#303b30 gui=nocombine]])
vim.cmd([[highlight! IndentBlanklineIndent3 guifg=#303b30 gui=nocombine]])
vim.cmd([[highlight! IndentBlanklineIndent4 guifg=#303b30 gui=nocombine]])
vim.cmd([[highlight! IndentBlanklineIndent5 guifg=#303b30 gui=nocombine]])
vim.cmd([[highlight! IndentBlanklineIndent6 guifg=#303b30 gui=nocombine]])

require("indent_blankline").setup({
    char = "|",
    show_trailing_blankline_indent = false,
    char_highlight_list = { "IndentBlanklineIndent1", "IndentBlanklineIndent2" },
})
