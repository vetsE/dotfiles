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

-- require'diagborder'

-- -- denols
-- require'lspconfig'.denols.setup{
--     init_options = { enable = true, lint = true }
-- }

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

