require'lspconfig'.dartls.setup{}
require'lspconfig'.terraformls.setup{}
require'lspconfig'.tsserver.setup{}
require'lspconfig'.yamlls.setup{}
require'lspconfig'.nixd.setup{}
require'lspconfig'.bicep.setup{
  cmd = { "dotnet", bicep_lsp_bin },
}
-- Auto command to set filetype for Bicep files
vim.api.nvim_create_autocmd({"BufNewFile", "BufRead"}, {
  pattern = "*.bicep",
  command = "set filetype=bicep"
})
