-- treesitter
require'nvim-treesitter.configs'.setup {
    ensure_installed = "maintained",
    highlight = {
        enable = true,
        disable = {}
    },
    indent = {
        enable = false
    }
}
-- diagnostic
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
        virtual_text = true,
        signs = true,
        underline = true,
        update_in_insert = false,
  }
)

-- require'diagborder'

-- denols
require'lspconfig'.denols.setup{
    init_options = { enable = true, lint = true }
}

-- python lsp
require'lspconfig'.pyls.setup{
    settings={
        pyls = {
            plugins = {
                pyls_mypy = {
                    enabled = true,
                },
                pycodestyle = {
                    enabled = false
                },
                jedi_completion = {
                    enabled = true
                },
                pylint = {
                    enabled = true
                }
            }
        }
    }
}

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
require'lspconfig'.texlab.setup{ latex = { lint = { onChange = true } } }

