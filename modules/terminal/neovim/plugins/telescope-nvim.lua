require('telescope').setup {
  pickers = {
    find_files = {
      find_command = { 'rg', '--files', '--hidden', '-g', '!.git/*' }
    }
  }
}

-- Map <C-f> to open Telescope find_files
vim.api.nvim_set_keymap('n', '<C-f>', ':Telescope find_files<CR>', {noremap = true, silent = true})

-- Map <C-g> to open Telescope live_grep
vim.api.nvim_set_keymap('n', '<C-g>', ':Telescope live_grep<CR>', {noremap = true, silent = true})
