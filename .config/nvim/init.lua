-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "--branch=stable",
        lazyrepo,
        lazypath,
    })
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
            { out, "WarningMsg" },
            { "\nPress any key to exit..." },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end
vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = " "
vim.g.maplocalleader = " "
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

-- preformat json with jq
-- vim.api.nvim_create_autocmd({ "BufReadPost", "BufWritePost" }, {
--     pattern = "*.json",
--     command = ":%!jq ."
-- })

-- Highlight on yank
local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
    callback = function()
        vim.highlight.on_yank()
    end,
    group = highlight_group,
    pattern = "*",
})

local has_words_before = function()
    local col = vim.api.nvim_win_get_cursor(0)[2]
    if col == 0 then
        return false
    end
    local line = vim.api.nvim_get_current_line()
    return line:sub(col, col):match("%s") == nil
end

vim.diagnostic.config({
    virtual_text = false,
    underline = false,
    float = {
        border = "double",
        header = "",
        format = function(diagnostic)
            return string.format("[%s] %s", diagnostic.source, diagnostic.message)
        end,
    },
})
-- vim.fn.sign_define("DiagnosticSignError", { text = "✘", texthl = "DiagnosticSignError" })
-- vim.fn.sign_define("DiagnosticSignWarn", { text = "▲", texthl = "DiagnosticSignWarn" })
-- vim.fn.sign_define("DiagnosticSignInformation", { text = "🛈", texthl = "DiagnosticSignInfo" })
-- vim.fn.sign_define("DiagnosticSignHint", { text = "👓", texthl = "DiagnosticSignHint" })

vim.keymap.set({ "i" }, " ", " ", { silent = true })
vim.keymap.set("n", "<leader><CR>", ":noh<CR>", { silent = true })
vim.keymap.set("n", "<leader>e", "<C-o>", { silent = true })
vim.keymap.set("n", "<leader>i", "<C-i>", { silent = true })
vim.keymap.set("n", "<leader><leader>", ":b#<CR>", { silent = true })
vim.keymap.set("n", "<leader>s", ":bn<CR>", { silent = true })
vim.keymap.set("n", "<leader>t", ":bp<CR>", { silent = true })
vim.keymap.set("n", "<leader>*", "yypVr*<CR>", { silent = true })
vim.keymap.set("n", "<leader>-", "yypVr-<CR>", { silent = true })
vim.keymap.set("n", "<leader>=", "yypVr=<CR>", { silent = true })
vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>", { silent = true })
vim.keymap.set("n", "<leader>é", vim.diagnostic.open_float, { silent = true })
vim.keymap.set("n", "«", "<", { silent = true })
vim.keymap.set("n", "»", ">", { silent = true })
vim.keymap.set("n", "<leader>k", function()
    vim.lsp.buf.hover({ border = "double" })
end, { silent = true })
vim.keymap.set("n", "<leader>d", vim.lsp.buf.definition, { silent = true })

require("lazy").setup({
    {
        "vetsE/bepo.nvim",
        config = function()
            require("bepo").setup()
        end,
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
        "williamboman/mason.nvim",
        config = function()
            require("mason").setup()
        end,
    },
    {
        "williamboman/mason-lspconfig.nvim",
        config = function()
            -- local capabilities = require("cmp_nvim_lsp").default_capabilities()
            local capabilities = {}

            vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
                border = "rounded",
            })

            -- Setup keymaps for LSP functionality
            local on_attach = function(_, bufnr)
                local nmap = function(keys, func, desc)
                    if desc then
                        desc = "LSP: " .. desc
                    end
                    vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
                end

                -- Code Actions
                nmap("<leader>a", vim.lsp.buf.code_action, "Code Action")
                vim.keymap.set("v", "<leader>a", vim.lsp.buf.code_action, { buffer = bufnr, desc = "Code Action" })

                -- Other useful LSP keymaps
                nmap("gd", vim.lsp.buf.definition, "Goto Definition")
                nmap("gr", require("telescope.builtin").lsp_references, "Goto References")
                nmap("K", vim.lsp.buf.hover, "Hover Documentation")
                nmap("<leader>rn", vim.lsp.buf.rename, "Rename")
            end

            require("mason-lspconfig").setup()

            -- Configure each LSP with capabilities and on_attach
            require("lspconfig").basedpyright.setup({
                capabilities = capabilities,
                on_attach = on_attach,
            })
            require("lspconfig").ruff.setup({
                capabilities = capabilities,
                on_attach = on_attach,
            })
            require("lspconfig").clangd.setup({
                capabilities = capabilities,
                on_attach = on_attach,
            })
            require("lspconfig").lua_ls.setup({
                capabilities = capabilities,
                on_attach = on_attach,
            })
            require("lspconfig").bashls.setup({
                capabilities = capabilities,
                on_attach = on_attach,
            })
            require("lspconfig").neocmake.setup({
                capabilities = capabilities,
                on_attach = on_attach,
            })
            require("lspconfig").jsonls.setup({
                capabilities = capabilities,
                on_attach = on_attach,
            })
        end,
    },
    { "sindrets/diffview.nvim" },
    "neovim/nvim-lspconfig",
    {
        "stevearc/conform.nvim",
        config = function()
            local conform = require("conform")
            conform.setup({
                formatters_by_ft = {
                    lua = { "stylua" },
                    python = { "ruff_format", "ruff_fix", "ruff_organize_imports" },
                    c = { "clangd" },
                    cpp = { "clangd" },
                    cmake = { "cmake-format" },
                    bash = { "shfmt" },
                    markdown = { "prettier" },
                    json = { "fixjson" },
                    markdown = { "mdformat" },
                },
            })
            vim.keymap.set({ "n", "v" }, "<leader>f", function()
                conform.format({
                    async = false,
                    timeout_ms = 5000,
                    lsp_fallback = true,
                })
            end, { desc = "[F]ormat" })
        end,
    },
    {
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
        config = function()
            require("ibl").setup({
                indent = { char = "╎" },
                scope = {
                    enabled = false,
                },
                whitespace = {
                    remove_blankline_trail = true,
                },
            })
        end,
    },
    {
        "nvim-telescope/telescope.nvim",
        tag = "0.1.8",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            local telescope = require("telescope").setup({
                defaults = {
                    mappings = {
                        i = {
                            ["<C-u>"] = false,
                            ["<C-d>"] = false,
                        },
                    },
                },
            })
            vim.keymap.set("n", "<leader>q", ":Telescope diagnostics<CR>")
            vim.keymap.set("n", "<leader>b", require("telescope.builtin").buffers)
            vim.keymap.set("n", "<leader>gf", require("telescope.builtin").git_files)
        end,
    },
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function()
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
                        goto_previous_start = {
                            ["[m"] = "@function.outer",
                            ["[["] = "@class.outer",
                        },
                        goto_previous_end = { ["[M"] = "@function.outer", ["[]"] = "@class.outer" },
                    },
                },
                sync_install = false,
                ignore_install = {},
                auto_install = true,
                modules = {},
            })
        end,
    },
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
        "kelly-lin/ranger.nvim",
        config = function()
            require("ranger-nvim").setup({
                replace_netrw = true,
                enable_cmds = true,
                ui = { border = "double", height = 0.8, width = 0.8 },
            })
            vim.api.nvim_set_keymap("n", "<leader>o", "", {
                noremap = true,
                callback = function()
                    require("ranger-nvim").open(true)
                end,
            })
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
        "kylechui/nvim-surround",
        config = function()
            require("nvim-surround").setup(require("bepo").nvim_surround())
        end,
    },
    { "L3MON4D3/LuaSnip", build = "make install_jsregexp" },
    {
        "saghen/blink.cmp",
        dependencies = { "rafamadriz/friendly-snippets" },
        signature = { enabled = true },
        version = "1.*",
        opts = {
            -- 'default' (recommended) for mappings similar to built-in completions (C-y to accept)
            -- 'super-tab' for mappings similar to vscode (tab to accept)
            -- 'enter' for enter to accept
            -- 'none' for no mappings
            --
            -- All presets have the following mappings:
            -- C-space: Open menu or open docs if already open
            -- C-n/C-p or Up/Down: Select next/previous item
            -- C-e: Hide menu
            -- C-k: Toggle signature help (if signature.enabled = true)
            --
            -- See :h blink-cmp-config-keymap for defining your own keymap
            keymap = {
                preset = "none",
                ["<Tab>"] = {
                    function(cmp)
                        if cmp.is_visible() then
                            return cmp.select_next()
                        end
                        if has_words_before() then
                            return cmp.show()
                        end
                    end,
                },
                ["<S-Tab>"] = {
                    function(cmp)
                        if cmp.is_visible() then
                            return cmp.select_prev()
                        end
                    end,
                },
                ["<CR>"] = { "accept", "fallback" },
            },

            appearance = {
                nerd_font_variant = "mono",
            },

            completion = {
                menu = { border = "double", auto_show = false },
                documentation = { auto_show = false, window = { border = "double" } },
            },

            sources = {
                default = { "lsp", "path", "snippets", "buffer" },
            },
            fuzzy = { implementation = "prefer_rust_with_warning" },
        },
        opts_extend = { "sources.default" },
    },
    -- {
    --     -- Autocompletion
    --     "hrsh7th/nvim-cmp",
    --     dependencies = {
    --         "saadparwaiz1/cmp_luasnip",
    --         "hrsh7th/cmp-nvim-lsp",
    --         "rafamadriz/friendly-snippets",
    --         "hrsh7th/cmp-buffer",
    --         "hrsh7th/cmp-path",
    --     },
    --     config = function()
    --         local cmp = require("cmp")
    --         local luasnip = require("luasnip")
    --         require("luasnip.loaders.from_vscode").lazy_load()
    --         luasnip.config.setup({})
    --         local has_words_before = function()
    --             local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    --             return col ~= 0
    --                 and vim.api
    --                 .nvim_buf_get_lines(0, line - 1, line, true)[1]
    --                 :sub(col, col)
    --                 :match("%s")
    --                 == nil
    --         end
    --
    --         cmp.setup({
    --             completion = { autocomplete = false, completeopt = "menu,menuone,noinsert" },
    --             snippet = {
    --                 expand = function(args) luasnip.lsp_expand(args.body) end,
    --             },
    --             window = {
    --                 completion = cmp.config.window.bordered(),
    --                 documentation = false,
    --             },
    --             mapping = cmp.mapping.preset.insert({
    --                 ["<C-n>"] = cmp.mapping.select_next_item(),
    --                 ["<C-p>"] = cmp.mapping.select_prev_item(),
    --                 ["<C-d>"] = cmp.mapping.scroll_docs(-4),
    --                 ["<C-f>"] = cmp.mapping.scroll_docs(4),
    --                 ["<C-Space>"] = cmp.mapping.complete({}),
    --                 ["<CR>"] = cmp.mapping.confirm({
    --                     behavior = cmp.ConfirmBehavior.Insert,
    --                     select = true,
    --                 }),
    --                 ["<Tab>"] = cmp.mapping(function(fallback)
    --                     if cmp.visible() then
    --                         cmp.select_next_item()
    --                     elseif has_words_before() then
    --                         cmp.complete()
    --                     elseif luasnip.expand_or_locally_jumpable() then
    --                         luasnip.expand_or_jump()
    --                     else
    --                         fallback()
    --                     end
    --                 end, { "i", "s" }),
    --                 ["<S-Tab>"] = cmp.mapping(function(fallback)
    --                     if cmp.visible() then
    --                         cmp.select_prev_item()
    --                     elseif luasnip.locally_jumpable(-1) then
    --                         luasnip.jump(-1)
    --                     else
    --                         fallback()
    --                     end
    --                 end, { "i", "s" }),
    --             }),
    --             sources = {
    --                 { name = "nvim_lsp" },
    --                 -- { name = "buffer" },
    --                 { name = "path" },
    --                 { name = "luasnip" },
    --             },
    --         })
    --     end,
    -- },
    {
        "ggandor/leap.nvim",
        config = function()
            require("leap")
            require("bepo").setup_leap()
        end,
    },
    {
        "smjonas/inc-rename.nvim",
        config = function()
            require("inc_rename").setup()
            vim.keymap.set("n", "<leader>n", ":IncRename ")
        end,
    },
    {
        "numToStr/Comment.nvim",
        config = function()
            require("Comment").setup()
        end,
    },
})
