-- treesitter
require'nvim-treesitter.configs'.setup {
    ensure_installed = "maintained",
    highlight = {
        enable = true,
        -- disable = {"python"}
    },
    indent = {
        enable = false
    },
    incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = " v",
      node_incremental = "»",
      scope_incremental = " »",
      node_decremental = "«",
    },
  },
}
-- diagnostic
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
        virtual_text = false,
        signs = true,
        underline = true,
        update_in_insert = false,
  }
)

local actions = require("telescope.actions")
local trouble = require("trouble.providers.telescope")
local telescope = require("telescope").setup{
    defaults = {
        initial_mode = "insert",
        mappings = {
            i = { ["<C-c>"] = actions.close, },
            n = {
                ["<esc>"] = actions.close,
                ["t"] = actions.move_selection_next,
                ["s"] = actions.move_selection_previous,
                ["C"] = actions.move_to_top,
                ["M"] = actions.move_to_middle,
                ["R"] = actions.move_to_bottom,
            },
        },
    }
}

require("trouble").setup {
    defaults = {
        mappings = {
            n = {
                ["<leader>w"] = trouble.open_with_trouble,
            },
        },
    },
}

require("todo-comments").setup {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
}

local coq = require("coq")

-- Setup nvim-cmp.
-- local cmp = require'cmp'

-- cmp.setup({
-- snippet = {
--   -- REQUIRED - you must specify a snippet engine
--   expand = function(args)
--     vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
--     -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
--     -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
--     -- require'snippy'.expand_snippet(args.body) -- For `snippy` users.
--   end,
-- },
-- mapping = {
--   ['<C-d>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
--   ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
--   ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
--   ['<C-y>'] = cmp.config.disable, -- If you want to remove the default `<C-y>` mapping, You can specify `cmp.config.disable` value.
--   ['<C-e>'] = cmp.mapping({
--     i = cmp.mapping.abort(),
--     c = cmp.mapping.close(),
--   }),
--   ['<CR>'] = cmp.mapping.confirm({ select = true }),
-- },
-- sources = cmp.config.sources({
--   { name = 'nvim_lsp' },
--   { name = 'vsnip' }, -- For vsnip users.
--   -- { name = 'luasnip' }, -- For luasnip users.
--   -- { name = 'ultisnips' }, -- For ultisnips users.
--   -- { name = 'snippy' }, -- For snippy users.
-- }, {
--   { name = 'buffer' },
-- })
-- })

-- -- Use buffer source for `/`.
-- cmp.setup.cmdline('/', {
-- sources = {
--   { name = 'buffer' }
-- }
-- })

-- -- Use cmdline & path source for ':'.
-- cmp.setup.cmdline(':', {
-- sources = cmp.config.sources({
--   { name = 'path' }
-- }, {
--   { name = 'cmdline' }
-- })
-- })

-- require'diagborder'

-- -- denols
-- require'lspconfig'.denols.setup{
--     init_options = { enable = true, lint = true }
-- }

require'lspconfig'.clangd.setup{}
require'lspconfig'.cmake.setup{}

-- python lsp
-- require'lspconfig'.pyright.setup{}
-- require'lspconfig'.jedi_language_server.setup{}
require'lspconfig'.pylsp.setup(coq.lsp_ensure_capabilities{
        settings = {
            pylsp = {
                plugins = {
                    pylint = {
                        enabled = true
                    },
                    pyflakes = {
                        enabled = true
                    },
                     pycodestyle = {
                        enabled = false
                    },
                    mypy = {
                        enabled = true,
                    },
                }
            }

        }
    }
)
-- require'lspconfig'.pylsp.setup{
--     settings={
--         pyls = {
--             plugins = {
--                 pyls_mypy = {
--                     enabled = true,
--                 },
--                 pycodestyle = {
--                     enabled = false
--                 },
--                 jedi_completion = {
--                     enabled = true
--                 },
--                 pylint = {
--                     enabled = true
--                 }
--             }
--         }
--     }
-- }

-- rust lsp
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.resolveSupport = {
    properties = {
        'documentation',
        'detail',
        'additionalTextEdits',
    }
}

require'lspconfig'.rust_analyzer.setup{
    capabilities = capabilities,
}


-- latex lsp
-- require'lspconfig'.texlab.setup{ latex = { lint = { onChange = true } } }

require("lsp-colors").setup({
    Error = "#db4b4b",
    Warning = "#e0af68",
    Information = "#0db9d7",
    Hint = "#10B981"
})

require('lualine').setup{options = {theme = 'solarized_dark'}}

vim.g.solarized_diffmode = 'low'
vim.g.solarized_visibility = 'normal'
vim.g.solarized_italics = 0


require'nvim-treesitter.configs'.setup {
    textobjects = {
        select = {
            enable = true,
            keymaps = {
                -- You can use the capture groups defined in textobjects.scm
                ["aF"] = "@function.outer",
                ["iF"] = "@function.inner",
                ["ac"] = "@class.outer",
                ["ic"] = "@class.inner",
                ["ab"] = "@block.outer",
                ["ib"] = "@block.inner",
                
            },
        },
    },
}

-- require "lsp_signature".setup{
--     floating_window_above_first = true,
-- }


require("stabilize").setup()

require("toggleterm").setup{
  -- size can be a number or function which is passed the current terminal
  size = function(term)
    if term.direction == "horizontal" then
      return 15
    elseif term.direction == "vertical" then
      return vim.o.columns * 0.4
    end
  end,
  hide_numbers = true, -- hide the number column in toggleterm buffers
  shade_filetypes = {},
  shade_terminals = true,
  shading_factor = '<number>', -- the degree by which to darken to terminal colour, default: 1 for dark backgrounds, 3 for light
  start_in_insert = true,
  insert_mappings = true, -- whether or not the open mapping applies in insert mode
  persist_size = true,
  direction = 'float',
  close_on_exit = true, -- close the terminal window when the process exits
  shell = vim.o.shell, -- change the default shell
  -- This field is only relevant if direction is set to 'float'
  float_opts = {
    -- The border key is *almost* the same as 'nvim_open_win'
    -- see :h nvim_open_win for details on borders however
    -- the 'curved' border is a custom border type
    -- not natively supported but implemented in this plugin.
    border = 'double',
    -- width = <value>,
    -- height = <value>,
    winblend = 3,
    highlights = {
      border = "Normal",
      background = "Normal",
    }
  }
}
