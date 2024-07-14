-- Set <space> as the leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

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
    {
        "vetsE/bepo.nvim",
        config = function()
            require("bepo").setup()
        end,
    },
    {
        "vetsE/hexamine.nvim",
        config = function()
            require("hexamine").setup()
        end,
    },
    {
        "folke/zen-mode.nvim",
        opts = {
            window = {
                width = 120, -- width of the Zen window
                options = {
                    signcolumn = "yes",
                    number = true,
                    cursorline = true,
                },
            },
        },
    },
    { "VonHeikemen/lsp-zero.nvim",        branch = "v3.x" },
    { "williamboman/mason.nvim" },
    { "williamboman/mason-lspconfig.nvim" },
    {
        "neovim/nvim-lspconfig",
    },
    { "L3MON4D3/LuaSnip",      build = "make install_jsregexp" },
    { "nvimtools/none-ls.nvim" },
    {
        "FabijanZulj/blame.nvim",
    },
    {
        "danymat/neogen",
        dependencies = "nvim-treesitter/nvim-treesitter",
        config = true,
    },
    {
        "simrat39/symbols-outline.nvim",
        config = function()
            require("symbols-outline").setup()
        end,
    },
    {
        "FredeEB/tardis.nvim",
        config = function()
            require("tardis-nvim").setup({
                keymap = {
                    next = "<C-t>",           -- next entry in log (older)
                    prev = "<C-s>",           -- previous entry in log (newer)
                    quit = "q",               -- quit all
                    commit_message = "<C-m>", -- show commit message for current commit in buffer
                },
                initial_revisions = 10,
                commits = 256, -- max number of commits to read
            })
        end,
    },
    {
        "kylechui/nvim-surround",
        config = function()
            require("nvim-surround").setup(require("bepo").nvim_surround())
        end,
    },
    { "/tpope/vim-fugitive" },
    {
        "lewis6991/gitsigns.nvim",
        config = function()
            require("gitsigns").setup({
                signs = {
                    add = { text = "▐" },
                    change = { text = "~" },
                    delete = { text = "_" },
                    topdelete = { text = "‾" },
                    changedelete = { text = "~" },
                    untracked = { text = "┆" },
                },
            })
        end,
    },
    {
        "ray-x/lsp_signature.nvim",
    },
    {
        "sindrets/diffview.nvim",
        config = function()
            require("diffview").setup()
        end,
        dependencies = {
            "nvim-tree/nvim-web-devicons",
        },
    },
    {
        "folke/tokyonight.nvim",
        lazy = false,
        priority = 1000,
        opts = {},
        config = function()
            vim.cmd.colorscheme("tokyonight-night")
            vim.cmd([[hi Comment cterm=NONE gui=NONE]])
        end,
    },
    {
        "nvim-lualine/lualine.nvim",
        opts = {
            options = {
                icons_enabled = true,
                theme = "nightfly",
                component_separators = "|",
                section_separators = "",
            },
            sections = {
                lualine_a = { "mode" },
                lualine_b = {},
                lualine_c = { { "filename", path = 1 } },
                lualine_x = { "encoding", "fileformat", "filetype" },
                lualine_y = { "progress" },
                lualine_z = { "location" },
            },
        },
    },
    {
        "kevinhwang91/rnvimr",
        config = function()
            vim.g.rnvimr_enable_ex = 1
            vim.g.rnvimr_enable_picker = 1
            vim.keymap.set({ "n", "v" }, "<leader>o", ":RnvimrToggle<CR>", { silent = true })
        end,
    },
    {
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
        opts = {
            indent = { char = "╎" },
            scope = {
                enabled = false,
            },
            whitespace = {
                remove_blankline_trail = true,
            },
        },
    },
    { "numToStr/Comment.nvim", opts = {} },
    {
        "ggandor/leap.nvim",
        config = function()
            require("leap")
            require("bepo").setup_leap()
        end,
    },
    {
        "iamcco/markdown-preview.nvim",
        cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
        ft = { "markdown" },
        build = function()
            vim.fn["mkdp#util#install"]()
        end,
    },
    -- {
    --     "TobinPalmer/pastify.nvim",
    --     config = function()
    --         require("pastify").setup({
    --             opts = {
    --                 absolute_path = false,
    --                 local_path = "/figures/",
    --                 save = "local",
    --             },
    --             ft = {
    --                 html = '<img src="$IMG$" alt="">',
    --                 markdown = "![]($IMG$)",
    --                 tex = [[\includegraphics[width=\linewidth]{$IMG$}]],
    --             },
    --         })
    --     end,
    -- },
    {
        "cameron-wags/rainbow_csv.nvim",
        config = true,
        ft = {
            "csv",
            "tsv",
            "csv_semicolon",
            "csv_whitespace",
            "csv_pipe",
            "rfc_csv",
            "rfc_semicolon",
        },
        cmd = {
            "RainbowDelim",
            "RainbowDelimSimple",
            "RainbowDelimQuoted",
            "RainbowMultiDelim",
        },
    },
    {
        "AndrewRadev/switch.vim",
        config = function()
            vim.keymap.set("n", "<leader>w", ":Switch<CR>", { silent = true })
        end,
    },
    {
        "nvimdev/lspsaga.nvim",
        event = "BufRead",
        dependencies = {
            { "nvim-tree/nvim-web-devicons" },
        },
    },
    {
        -- Autocompletion
        "hrsh7th/nvim-cmp",
        dependencies = {
            "saadparwaiz1/cmp_luasnip",
            "hrsh7th/cmp-nvim-lsp",
            "rafamadriz/friendly-snippets",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
        },
    },
    {
        "nvim-telescope/telescope.nvim",
        branch = "0.1.x",
        dependencies = {
            "nvim-lua/plenary.nvim",
            {
                "nvim-telescope/telescope-fzf-native.nvim",
                build = "make",
                cond = function()
                    return vim.fn.executable("make") == 1
                end,
            },
        },
    },
    {
        "nvim-treesitter/nvim-treesitter",
        dependencies = {
            "nvim-treesitter/nvim-treesitter-textobjects",
        },
        build = ":TSUpdate",
    },
    {
        "RaafatTurki/hex.nvim",
    },
    {
        "MysticalDevil/inlay-hints.nvim",
        event = "LspAttach",
        dependencies = { "neovim/nvim-lspconfig" },
        config = function()
            require("inlay-hints").setup({ autocmd = { enable = false } })
        end,
    },
}, {})

--------------------------------------------------------------------------------
-- Settings options                                                           --
--------------------------------------------------------------------------------

vim.o.shiftwidth = 4
vim.o.tabstop = 4
vim.o.breakindent = true
vim.o.clipboard = "unnamedplus"
vim.o.completeopt = "menuone,noselect"
vim.o.cursorline = true
vim.o.encoding = "utf-8"
vim.o.errorbells = false
vim.o.fileencoding = "utf-8"
vim.o.hidden = true
vim.o.hlsearch = true
vim.o.ignorecase = true
vim.o.laststatus = 3
-- vim.o.lazyredraw = true
vim.o.lbr = true
vim.o.list = true
vim.o.mat = 2
vim.o.mouse = "a"
vim.opt.history = 1000
vim.opt.listchars = { nbsp = "¤", tab = "▸ " }
vim.opt.undofile = true
vim.o.showcmd = true
-- vim.o.showmatch = true
vim.o.smartcase = true
vim.o.termguicolors = true
-- vim.o.textwidth = 100
vim.o.timeoutlen = 300
vim.o.undodir = "/home/vetse/.cache/nvim/undodir"
vim.o.undofile = true
vim.o.updatetime = 250
vim.o.visualbell = false
vim.wo.number = true
vim.wo.signcolumn = "yes"
vim.o.expandtab = true
vim.opt.formatprg = "par -w80"

--------------------------------------------------------------------------------
-- Diagnostics                                                                --
--------------------------------------------------------------------------------

vim.diagnostic.config({
    virtual_text = false,
    float = {
        border = "double",
        format = function(diagnostic)
            return string.format("[%s] %s", diagnostic.source, diagnostic.message)
        end,
    },
})
vim.fn.sign_define("DiagnosticSignError", { text = "✘", texthl = "DiagnosticSignError" })
vim.fn.sign_define("DiagnosticSignWarn", { text = "▲", texthl = "DiagnosticSignWarn" })
vim.fn.sign_define("DiagnosticSignInformation", { text = "🛈", texthl = "DiagnosticSignInfo" })
vim.fn.sign_define("DiagnosticSignHint", { text = "👓", texthl = "DiagnosticSignHint" })

--------------------------------------------------------------------------------
-- Keymaps                                                                    --
--------------------------------------------------------------------------------

vim.keymap.set({ "i" }, " ", " ", { silent = true })
vim.keymap.set("n", "<F3>", "nzz", { silent = true })
vim.keymap.set({ "n", "i" }, "<F8>", ":InlayHintsToggle<CR>", { silent = true })
vim.keymap.set("n", "<leader><CR>", ":noh<CR>", { silent = true })
vim.keymap.set("n", "<leader>e", "<C-o>", { silent = true })
vim.keymap.set("n", "<leader>i", "<C-i>", { silent = true })
vim.keymap.set("n", "<leader><leader>", ":b#<CR>", { silent = true })
vim.keymap.set("n", "<leader>s", ":bn<CR>", { silent = true })
vim.keymap.set("n", "<leader>t", ":bp<CR>", { silent = true })
vim.keymap.set("n", "<leader>w", ":Switch<CR>", { silent = true })
vim.keymap.set("n", "<leader>*", "yypVr*<CR>", { silent = true })
vim.keymap.set("n", "<leader>-", "yypVr-<CR>", { silent = true })
vim.keymap.set("n", "<leader>=", "yypVr=<CR>", { silent = true })
vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })
vim.keymap.set("n", "<F10>", vim.diagnostic.goto_prev)
vim.keymap.set("n", "<S-F10>", vim.diagnostic.goto_next, { desc = "Go to next diagnostic message" })
vim.keymap.set("n", "<leader>é", "<cmd>Lspsaga show_line_diagnostics<CR>", { silent = true })
-- vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostics list" })
vim.keymap.set("n", "<leader>q", ":Telescope diagnostics<CR>", { desc = "Open diagnostics list" })
vim.keymap.set("n", "<leader>D", "<cmd>Lspsaga peek_definition<CR>", { silent = true })
vim.keymap.set("n", "<leader>k", "<cmd>Lspsaga hover_doc<CR>", { silent = true })
vim.keymap.set("n", "<leader>n", vim.lsp.buf.rename, { silent = true })
vim.keymap.set("n", "<leader>a", vim.lsp.buf.code_action, { silent = true })
vim.keymap.set("n", "<leader>d", vim.lsp.buf.definition, { silent = true })
vim.keymap.set("n", "<leader>gr", require("telescope.builtin").lsp_references, { silent = true })
vim.keymap.set("n", "<leader>gi", vim.lsp.buf.implementation, { silent = true })
vim.keymap.set(
    "n",
    "<leader>ws",
    require("telescope.builtin").lsp_dynamic_workspace_symbols,
    { silent = true }
)
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>", { silent = true })
vim.keymap.set("n", "<leader>b", require("telescope.builtin").buffers)
vim.keymap.set("n", "<leader>gf", require("telescope.builtin").git_files)
vim.keymap.set("n", "<leader>É", require("telescope.builtin").diagnostics)
vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)
-- vim.keymap.set({ "n" }, "<C-k>", function()
--     require("lsp_signature").toggle_float_win()
-- end, { silent = true, noremap = true, desc = "toggle signature" })

--------------------------------------------------------------------------------
-- LSP & co                                                                   --
--------------------------------------------------------------------------------

local saga = require("lspsaga")
saga.setup({
    symbol_in_winbar = { enable = false },
    border_style = "rounded",
    saga_winblend = 10,
    show_diagnostic_source = true,
    lightbulb = { enable = true, sign = true, sign_priority = 100, virtual_text = false },
    ui = { code_action = "" },
    diagnostic = {
        on_insert = false,
        on_insert_follow = false,
        insert_winblend = 0,
        show_code_action = false,
        show_source = true,
        jump_num_shortcut = true,
        -- 1 is max
        max_width = 0.7,
        custom_fix = nil,
        custom_msg = nil,
        text_hl_follow = false,
        border_follow = true,
        keys = { exec_action = "o", quit = "q", go_action = "g" },
        extend_relatedInformation = true,
    },
})

local null_ls = require("null-ls")

null_ls.setup({
    sources = {
        -- null_ls.builtins.formatting.clang_format,
        null_ls.builtins.formatting.prettier,
        null_ls.builtins.formatting.stylua.with({
            extra_args = {
                "--indent-type",
                "Spaces",
                "--indent-width",
                "4",
                "--column-width",
                "100",
                "-",
            },
        }),
        -- null_ls.builtins.completion.spell,
        null_ls.builtins.code_actions.gitsigns,
        null_ls.builtins.formatting.isort.with({
            extra_args = {
                "--profile",
                "black",
            },
        }),
        -- null_ls.builtins.diagnostics.pylint.with({
        --     diagnostics_postprocess = function(diagnostic)
        --         diagnostic.code = diagnostic.message_id
        --     end,
        -- }),
        -- null_ls.builtins.formatting.ruff_format.with({ extra_args = { "--line-length=100" } }),
        null_ls.builtins.formatting.shfmt.with({
            extra_args = {
                "-s",
                "-i",
                "4",
            },
        }),
        null_ls.builtins.formatting.shellharden,
    },
})

require("lsp_signature").setup({
    floating_window = false,
    floating_window_above_cur_line = false,
    floating_window_off_x = 1,
    floating_window_off_y = -2,
    fix_pos = false,
    hint_enable = false,
    handler_opts = { border = "double" },
    always_trigger = false,
    toggle_key = "<C-k>",
})

local lsp_zero = require("lsp-zero")
lsp_zero.on_attach(function(client, bufnr)
    -- require("lsp_signature").on_attach(signature_setup, bufnr)
    -- lsp_zero.default_keymaps({ bggguffer = bufnr })
end)

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.offsetEncoding = { "utf-16" }
require("lspconfig").clangd.setup({
    capabilities = capabilities,
})

-- see :help lsp-zero-guide:integrate-with-mason-nvim
-- to learn how to use mason.nvim with lsp-zero
require("mason").setup({})
require("mason-lspconfig").setup({
    handlers = {
        lsp_zero.default_setup,
    },
})

require("lspconfig").ruff_lsp.setup({
    init_options = {
        settings = {
            -- args = { "--line-length=100" },
        },
    },
})

require("lspconfig").eslint.setup({})

require("lspconfig").basedpyright.setup({
    settings = {
        basedpyright = {
            analysis = {
                diagnosticSeverityOverrides = {
                    reportAny = "none",
                    reportMissingSuperCall = "none",
                    reportImplicitOverride = "none",
                    reportUnknownParameterType = "none",
                    reportUnknownVariableType = "none",
                    reportMissingParameterType = "none",
                    reportUnknownArgumentType = "none",
                    reportUnknownMemberType = "none",
                    reportUntypedFunctionDecorator = "none",
                    reportMissingTypeArgument = "none",
                    reportUnnecessaryIsInstance = "none",
                    reportUnusedCallResult = "none",
                    reportMissingTypeStubs = "none",
                    reportUnknownLambdaType = "none",
                    reportCallInDefaultInitializer = "none",
                },
            },
        },
    },
})

-- require("lspconfig").pylsp.setup({
-- require("lspconfig").pylsp.setup({
--     settings = {
--         pylsp = {
--             plugins = {
--                 pycodestyle = {
--                     enabled = false,
--                 },
--                 mypy = {
--                     enabled = true,
--                 },
--                 pyls_mypy = {
--                     enabled = true,
--                 },
--             },
--         },
--     },
-- })

--------------------------------------------------------------------------------
-- Autocompletion                                                             --
--------------------------------------------------------------------------------
--
local cmp = require("cmp")
local luasnip = require("luasnip")
require("luasnip.loaders.from_vscode").lazy_load()
luasnip.config.setup({})

local has_words_before = function()
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0
        and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s")
        == nil
end

cmp.setup({
    completion = { autocomplete = false, completeopt = "menu,menuone,noinsert" },
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },
    window = {
        completion = cmp.config.window.bordered(),
        documentation = false,
    },
    mapping = cmp.mapping.preset.insert({
        ["<C-n>"] = cmp.mapping.select_next_item(),
        ["<C-p>"] = cmp.mapping.select_prev_item(),
        ["<C-d>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete({}),
        ["<CR>"] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Insert,
            select = true,
        }),
        ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif has_words_before() then
                cmp.complete()
            elseif luasnip.expand_or_locally_jumpable() then
                luasnip.expand_or_jump()
            else
                fallback()
            end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.locally_jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, { "i", "s" }),
    }),
    sources = {
        { name = "nvim_lsp" },
        -- { name = "buffer" },
        { name = "path" },
        { name = "luasnip" },
    },
})

-- require("lsp_signature").setup({
--    toggle_key = "C-k",
--    floating_window = true,
--    bind = true,
--    handler_opts = {
--       border = "rounded",
--    },
--    hint_enable = false,
--    hint_prefix = "",
-- })

--------------------------------------------------------------------------------
-- Misc                                                                       --
--------------------------------------------------------------------------------

require("hex").setup({
    dump_cmd = "hexxy -g 1 -u",
    is_buf_binary_pre_read = function()
        return false
    end,
})

-- Highlight on yank
local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
    callback = function()
        vim.highlight.on_yank()
    end,
    group = highlight_group,
    pattern = "*",
})

-- Configure Telescope
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

-- Enable telescope fzf native, if installed
pcall(require("telescope").load_extension, "fzf")

-- Configure Treesitter
require("nvim-treesitter.configs").setup({
    ensure_installed = {
        "c",
        "cpp",
        "go",
        "lua",
        "python",
        "rust",
        "tsx",
        "typescript",
        "vimdoc",
        "vim",
    },
    highlight = {
        enable = true,
        disable = { "lua", "csv", "tsv" },
    },
    incremental_selection = {
        enable = false,
        keymaps = {
            init_selection = "gnn",
            node_incremental = "grn",
            scope_incremental = "grc",
            node_decremental = "grm",
        },
    },
    indent = { enable = false },
    textobjects = {
        select = {
            enable = true,
            lookahead = true,
            keymaps = {
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
            goto_next_start = { ["]m"] = "@function.outer", ["]]"] = "@class.outer" },
            goto_next_end = { ["]M"] = "@function.outer", ["]["] = "@class.outer" },
            goto_previous_start = { ["[m"] = "@function.outer", ["[["] = "@class.outer" },
            goto_previous_end = { ["[M"] = "@function.outer", ["[]"] = "@class.outer" },
        },
    },
    sync_install = false,
    ignore_install = {},
    auto_install = true,
    modules = {},
})

-- Toggle terminal
local prev_buf = -1

local function toggle_terminal_buffer()
    local cur_buf = vim.api.nvim_get_current_buf()

    if vim.api.nvim_buf_get_option(cur_buf, "buftype") == "terminal" then
        if prev_buf ~= -1 then
            vim.api.nvim_set_current_buf(prev_buf)
            prev_buf = -1
            return
        end
    end

    if prev_buf == -1 then
        for _, buf in ipairs(vim.api.nvim_list_bufs()) do
            if vim.api.nvim_buf_get_option(buf, "buftype") == "terminal" then
                prev_buf = cur_buf
                vim.api.nvim_set_current_buf(buf)
                return
            end
        end
        prev_buf = cur_buf
        vim.cmd("terminal")
    else
        vim.api.nvim_set_current_buf(prev_buf)
        prev_buf = -1
    end
end

-- Map the function to F5
vim.api.nvim_set_keymap(
    "n",
    "<F5>",
    [[<Cmd>lua toggle_terminal_buffer()<CR>]],
    { noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
    "t",
    "<F5>",
    [[<C-\><C-n>:lua toggle_terminal_buffer()<CR>]],
    { noremap = true, silent = true }
)
