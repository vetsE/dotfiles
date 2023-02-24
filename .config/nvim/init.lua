----------------------------------------------------------------------------------------------------
--                                             Plugin manager                                     --
----------------------------------------------------------------------------------------------------
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    "wbthomason/packer.nvim",
    "vetsE/bepo.nvim",
    "numToStr/Comment.nvim",
    { "nvim-telescope/telescope.nvim", dependencies = { "nvim-lua/plenary.nvim" } },
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    "nvim-lualine/lualine.nvim",
    "lukas-reineke/indent-blankline.nvim",
    { "lewis6991/gitsigns.nvim", dependencies = { "nvim-lua/plenary.nvim" } },
    "nvim-treesitter/nvim-treesitter",
    "nvim-treesitter/nvim-treesitter-textobjects",
    "jose-elias-alvarez/null-ls.nvim",
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "neovim/nvim-lspconfig",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-cmdline",
    "hrsh7th/nvim-cmp",
    "saadparwaiz1/cmp_luasnip",
    "L3MON4D3/LuaSnip",
    "shaunsingh/solarized.nvim",
    "folke/tokyonight.nvim",
    "EdenEast/nightfox.nvim",
    "kevinhwang91/rnvimr",
    "danymat/neogen",
    "mechatroner/rainbow_csv",
    "rafamadriz/friendly-snippets",
    "ishan9299/nvim-solarized-lua",
    "lewis6991/spellsitter.nvim",
    {
        "glepnir/lspsaga.nvim",
        event = "BufRead",
        dependencies = {
            { "nvim-tree/nvim-web-devicons" },
        },
    },
    -- "mfussenegger/nvim-lint",
    "AndrewRadev/switch.vim",
    "wsdjeg/vim-fetch",
    {
        "iamcco/markdown-preview.nvim",
        build = function()
            vim.fn["mkdp#util#install"]()
        end,
    },
    "ggandor/leap.nvim",
    "edluffy/hologram.nvim",
    "kylechui/nvim-surround",
    { "sindrets/diffview.nvim", dependencies = "nvim-lua/plenary.nvim" },
    "HallerPatrick/py_lsp.nvim",
    { "ellisonleao/glow.nvim", config = true, cmd = "Glow" },
    {
        "jackMort/ChatGPT.nvim",
        dependencies = {
            "MunifTanjim/nui.nvim",
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope.nvim",
        },
    },
}, {})

----------------------------------------------------------------------------------------------------
--                                         General config                                         --
----------------------------------------------------------------------------------------------------

vim.o.laststatus = 3
vim.o.hidden = true
vim.o.hlsearch = true
vim.wo.number = true
vim.o.lazyredraw = true
vim.o.showmatch = true
vim.o.mat = 2
vim.o.clipboard = "unnamedplus"
vim.o.lbr = true
vim.o.list = true
vim.opt.listchars = { nbsp = "¤", tab = "▸ " }
vim.o.mouse = "a"
vim.o.breakindent = true
vim.o.undodir = "/home/vetse/.cache/nvim/undodir"
vim.opt.undofile = true
vim.opt.history = 1000
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.encoding = "utf-8"
vim.o.fileencoding = "utf-8"
vim.o.updatetime = 250
vim.wo.signcolumn = "yes"
vim.o.completeopt = "menuone,noselect"

-------------------------------------------------------------------------------------------------
--                                            Mapping                                          --
-------------------------------------------------------------------------------------------------

require("bepo").setup()
vim.keymap.set({ "n", "v" }, "q:", "<Nop>", { silent = true })
vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })
vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.keymap.set({ "n", "v" }, "<leader>o", ":RnvimrToggle<CR>", { silent = true })
vim.keymap.set("n", "<leader>e", "<C-o>", { silent = true })
vim.keymap.set("n", "<leader>i", "<C-i>", { silent = true })
vim.keymap.set("n", "<leader>-", "yypVr-<CR>", { silent = true })
vim.keymap.set("n", "<leader>=", "yypVr=<CR>", { silent = true })
vim.keymap.set("n", "<leader>*", "yypVr*<CR>", { silent = true })
vim.keymap.set("n", "<leader><leader>", ":b#<CR>", { silent = true })
vim.keymap.set("n", "<leader>t", ":bp<CR>", { silent = true })
vim.keymap.set("n", "<leader>s", ":bn<CR>", { silent = true })
vim.keymap.set("n", "<leader><CR>", ":noh<CR>", { silent = true })
vim.keymap.set("n", "<leader>f", vim.lsp.buf.format, { silent = true })
vim.keymap.set("v", "<leader>f", vim.lsp.buf.range_formatting, { silent = true })
vim.keymap.set("n", "<leader>w", ":Switch<CR>", { silent = true })
vim.keymap.set("n", "<leader>h", ":ChatGPT<CR>", { silent = true })

-------------------------------------------------------------------------------------------------
--                                      Plugin config                                          --
-------------------------------------------------------------------------------------------------

require("chatgpt").setup({})

--------------
-- surround --
--------------

require("nvim-surround").setup(require("bepo").nvim_surround())

----------
-- leap --
----------

require("leap")
require("bepo").setup_leap()

----------
-- SAGA --
----------

local saga = require("lspsaga")
saga.setup({
    symbol_in_winbar = { enable = false },
    border_style = "rounded",
    saga_winblend = 10,
    show_diagnostic_source = true,
    lightbulb = {
        enable = true,
        sign = true,
        sign_priority = 100,
        virtual_text = false,
    },
    ui = {
        code_action = "★",
    },
    diagnostic = {
        on_insert = false,
        on_insert_follow = false,
        insert_winblend = 0,
        show_code_action = true,
        show_source = true,
        jump_num_shortcut = true,
        --1 is max
        max_width = 0.7,
        custom_fix = nil,
        custom_msg = nil,
        text_hl_follow = false,
        border_follow = true,
        keys = {
            exec_action = "o",
            quit = "q",
            go_action = "g",
        },
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
        untracked = { text = "" },
    },
    signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
    numhl = false, -- Toggle with `:Gitsigns toggle_numhl`
    linehl = false, -- Toggle with `:Gitsigns toggle_linehl`
    word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
    watch_gitdir = {
        interval = 1000,
        follow_files = true,
    },
    attach_to_untracked = true,
    current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
    current_line_blame_opts = {
        virt_text = true,
        virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
        delay = 1000,
        ignore_whitespace = false,
    },
    current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>",
    sign_priority = 6,
    update_debounce = 100,
    status_formatter = nil, -- Use default
    max_file_length = 40000, -- Disable if file is longer than this (in lines)
    preview_config = {
        -- Options passed to nvim_open_win
        border = "single",
        style = "minimal",
        relative = "cursor",
        row = 0,
        col = 1,
    },
    yadm = {
        enable = false,
    },
})
-- require("gitsigns").setup()
-- {
--     signs = {
--       --     },
--     update_debounce = 100,
--     max_file_length = 40000,
-- })

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
capabilities = require("cmp_nvim_lsp").default_capabilities()

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
        documentation = cmp.config.disable,
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
    pickers = {
        colorscheme = {
            enable_preview = true,
        },
    },
})

-- Enable telescope fzf native
require("telescope").load_extension("fzf")

-- Add leader shortcuts
-- vim.keymap.set("n", "<leader>ff", function()
--     require("telescope.builtin").find_files({ previewer = false })
-- end)
-- vim.keymap.set("n", "<leader>fb", require("telescope.builtin").current_buffer_fuzzy_find)
-- vim.keymap.set("n", "<leader>fh", require("telescope.builtin").help_tags)
-- vim.keymap.set("n", "<leader>ft", require("telescope.builtin").tags)
vim.keymap.set("n", "<leader>b", require("telescope.builtin").buffers)
vim.keymap.set("n", "<leader>r", require("telescope.builtin").live_grep)
-- vim.keymap.set("n", "<leader>?", require("telescope.builtin").oldfiles)

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
    -- vim.keymap.set("n", "<leader>k", require("lspsaga.hover").render_hover_doc, opts)
    vim.keymap.set("n", "<leader>k", "<cmd>Lspsaga hover_doc<CR>", { silent = true })
    vim.keymap.set("n", "<leader>D", "<cmd>Lspsaga peek_definition<CR>", { silent = true })

    vim.keymap.set("n", "<leader>I", vim.lsp.buf.implementation, opts)

    -- vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, opts)
    vim.keymap.set("n", "<leader>n", vim.lsp.buf.rename, opts)
    vim.keymap.set("n", "<leader>a", vim.lsp.buf.code_action, opts)
    -- vim.keymap.set("n", "<leader>S", require("telescope.builtin").lsp_document_symbols, opts)
    vim.api.nvim_buf_create_user_command(bufnr, "Format", vim.lsp.buf.formatting, {})
end
-- Diagnostic setup
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
    virtual_text = false,
    signs = true,
    underline = true,
    update_in_insert = false,
})
vim.diagnostic.config({ virtual_text = false })
vim.keymap.set("n", "<leader>é", "<cmd>Lspsaga show_line_diagnostics<CR>", { silent = true })

-- vim.keymap.set("n", "<leader>é", function()
--     vim.diagnostic.open_float(0, { scope = "line", border = "rounded" })
-- end, { silent = true })
vim.keymap.set("n", "<F10>", function()
    vim.diagnostic.goto_next({ enable_popup = false })
end, { silent = true })
vim.keymap.set("n", "<S-F10>", function()
    vim.diagnostic.goto_prev({ enable_popup = false })
end, { silent = true })

-- Lua
lspconfig.lua_ls.setup({
    on_attach = on_attach,
    settings = {
        Lua = {
            runtime = { version = "LuaJIT" },
            diagnostics = { globals = { "vim" } },
            workspace = { library = vim.api.nvim_get_runtime_file("", true), checkThirdParty = false },
            telemetry = { enable = false },
        },
    },
})

-- clang
local clang_cap = { unpack(capabilities) }
clang_cap.offsetEncoding = "utf-8"
lspconfig.clangd.setup({ on_attach = on_attach, capabilities = clang_cap })

-- bash
lspconfig.bashls.setup({ on_attach = on_attach, capabilities = capabilities })

-- eslint
lspconfig.eslint.setup({ on_attach = on_attach, capabilities = capabilities })

-- json
lspconfig.jsonls.setup({ on_attach = on_attach, capabilities = capabilities })

-- cmake
lspconfig.cmake.setup({ on_attach = on_attach, capabilities = capabilities })

lspconfig.tsserver.setup({
    on_attach = on_attach,
    capabilities = capabilities,
    filetypes = { "typescript", "typescriptreact", "typescript.tsx" },
    root_dir = function()
        return vim.loop.cwd()
    end,
})

-- rust
lspconfig.rust_analyzer.setup({
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
        ["rust-analyzer"] = {
            -- enable clippy on save
            checkOnSave = {
                command = "clippy",
            },
        },
    },
})

-- python
-- lspconfig.jedi_language_server.setup({
--     on_attach = on_attach,
--     capabilities = capabilities,
-- })

require("lspconfig").pyright.setup({
    on_attach = on_attach,
    capabilities = capabilities,
})

-- lspconfig.pylsp.setup({
--     settings = {
--         pylsp = {
--             plugins = {
--                 pylint = { enabled = true },
--                 pyflakes = { enabled = false },
--                 pycodestyle = { enabled = false },
--             },
--         },
--     },
-- })
lspconfig.ltex.setup({})

-- require("lint").linters_by_ft = {
--     python = { "mypy" },
-- }
-- vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost" }, {
--     callback = function()
--         require("lint").try_lint()
--     end,
-- })

---------------------
-- Auto-formatting --
---------------------

require("null-ls").setup({
    on_attach = on_attach,
    capabilities = capabilities,
    sources = {
        require("null-ls").builtins.formatting.isort,
        require("null-ls").builtins.formatting.black,
        require("null-ls").builtins.formatting.shfmt,
        require("null-ls").builtins.formatting.clang_format.with({
            extra_args = { "--style=file:/home/vetse/.clang-format" },
        }),
        require("null-ls").builtins.formatting.stylua,
        require("null-ls").builtins.formatting.prettier,
        require("null-ls").builtins.formatting.rustfmt,
        -- require("null-ls").builtins.diagnostics.mypy,
    },
})

----------------------------------------------------------------------------------------------------
--                                         Look and feel                                          --
----------------------------------------------------------------------------------------------------

-- Set colorscheme
vim.o.termguicolors = true
vim.g.solarized_italics = 0
vim.g.solarized_italic_comments = 0
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

-- require("py_lsp").setup({})

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

----------
-- TEST --
----------

function _G.show_hex()
    local current_word = vim.call("expand", "<cword>")
    local buf = vim.api.nvim_create_buf(false, true)
    vim.api.nvim_buf_set_lines(buf, 0, -1, true, { "title", "content: " .. current_word })
    vim.api.nvim_buf_add_highlight(buf, -1, "Title", 0, 0, -1)
    vim.api.nvim_buf_set_option(buf, "buftype", "nofile")
    vim.keymap.set({ "n", "v" }, "<leader>q", ":q<CR>", { silent = true, buffer = buf })
    vim.keymap.set({ "n", "v" }, "<CR>", ":q<CR>", { silent = true, buffer = buf })
    local opts = {
        relative = "editor",
        width = 25,
        height = 10,
        row = 10,
        col = 10,
        style = "minimal",
        border = "rounded",
    }
    vim.api.nvim_open_win(buf, true, opts)
end

vim.keymap.set("n", "<leader>q", "<cmd>lua show_hex()<CR>", { silent = true })
