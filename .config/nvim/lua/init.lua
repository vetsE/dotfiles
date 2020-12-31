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
-- vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
--   vim.lsp.diagnostic.on_publish_diagnostics, {
--     virtual_text = false,
--     signs = true,
--     underline = true,
--     update_in_insert = false,
--   }
-- )
-- vim.lsp.callbacks['textDocument/codeAction'] = require'lsputil.codeAction'.code_action_handler
-- vim.lsp.callbacks['textDocument/references'] = require'lsputil.locations'.references_handler
-- vim.lsp.callbacks['textDocument/definition'] = require'lsputil.locations'.definition_handler
-- vim.lsp.callbacks['textDocument/declaration'] = require'lsputil.locations'.declaration_handler
-- vim.lsp.callbacks['textDocument/typeDefinition'] = require'lsputil.locations'.typeDefinition_handler
-- vim.lsp.callbacks['textDocument/implementation'] = require'lsputil.locations'.implementation_handler
-- vim.lsp.callbacks['textDocument/documentSymbol'] = require'lsputil.symbols'.document_handler
-- vim.lsp.callbacks['workspace/symbol'] = require'lsputil.symbols'.workspace_handler

-- function printdiag ()
--     local current_row = vim.api.nvim_win_get_cursor(0)[1] - 1
--     -- if _G.lastrowdiag == current_row then
--     --     return
--     -- end
--     -- _G.lastrowdiag = current_row

--     local current_buffer = vim.api.nvim_get_current_buf()
--     vim.lsp.diagnostic.show_line_diagnostics({show_header=true}, current_buffer, current_row)
-- end

-- python lsp
-- require'lspconfig'.pyls.setup{
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

