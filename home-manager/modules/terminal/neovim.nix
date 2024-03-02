{ pkgs, ... }:

{
  home.packages = with pkgs; [
    nodejs # Required for nvim-copilot
    ripgrep # For nvim-telescope
    terraform-ls # For nvim-lspconfig
    typescript # For nvim-lspconfig
    nodePackages.typescript-language-server # For nvim-lspconfig
    yaml-language-server # For nvim-lspconfig
  ];

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    extraConfig = ''
      colorscheme slate
      set number
      set relativenumber
      set numberwidth=1
      highlight LineNr ctermfg=White
      set mouse=
      set autoindent
      set tabstop=2
      set shiftwidth=2
      set softtabstop=2
      set smarttab
      set smartcase
      set expandtab
      set encoding=utf-8
      set clipboard+=unnamedplus
      highlight Normal ctermbg=none
      highlight NonText ctermbg=none
    '';
    plugins = with pkgs.vimPlugins; [
      copilot-vim
      vim-fugitive
      # nvim-tree
      {
        plugin = nvim-tree-lua;
        config = ''
          lua <<EOF
            require'nvim-tree'.setup {}
          EOF

          nnoremap <C-n> :NvimTreeToggle<CR>
          autocmd BufEnter * if winnr('$') == 1 && exists('b:term_type') && b:term_type == 'tree' | quit | endif
        '';
      }
      # Telescope
      plenary-nvim
      {
        plugin = telescope-nvim;
        config = ''
          lua << EOF
            require('telescope').setup {
              pickers = {
                find_files = {
                  find_command = { 'rg', '--files', '--hidden', '-g', '!.git/*' }
                }
              }
            }
          EOF

          nnoremap <C-f> :Telescope find_files<CR>
          nnoremap <C-g> :Telescope live_grep<CR>
        '';
      }
      # LSP
      {
        plugin = nvim-lspconfig;
        config = ''
          lua <<EOF
          require'lspconfig'.dartls.setup{}
          require'lspconfig'.terraformls.setup{}
          require'lspconfig'.tsserver.setup{}
          require'lspconfig'.yamlls.setup{}
          EOF
        '';
      }
      nvim-cmp
    ];
  };
}
