require'nvim-tree'.setup {}

-- Key mapping for toggling NvimTree
vim.api.nvim_set_keymap('n', '<C-s>', ':NvimTreeToggle<CR>', {noremap = true, silent = true})

-- Autocommand to close Neovim if the NvimTree is the only buffer left
vim.api.nvim_create_autocmd('BufEnter', {
  pattern = '*',
  callback = function()
    if vim.fn.winnr('$') == 1 and vim.b.term_type == 'tree' then
      vim.cmd('quit')
    end
  end,
})
