{
  pkgs,
  pkgs-unstable,
  ...
}:

let
  bicep-ls = pkgs.callPackage ../../pkgs/bicep-ls { inherit pkgs; };
in
{
  home.packages = [
    bicep-ls
    pkgs.nodejs # Required for nvim-copilot
    pkgs.ripgrep # For nvim-telescope and nvim-spectre
    pkgs.fd # For nvim-telescope
    pkgs.tree-sitter # For nvim-treesitter
    pkgs.gcc # For nvim-lspconfig
    pkgs.typescript # For nvim-lspconfig
    pkgs.nixd # For nvim-lspconfig
    pkgs.nodePackages.typescript-language-server # For nvim-lspconfig
    pkgs.yaml-language-server # For nvim-lspconfig
    pkgs.dotnet-sdk_8 # For bicep-ls
    pkgs-unstable.terraform-ls # For nvim-lspconfig
  ];

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    extraConfig = builtins.readFile ./vimrc;
    extraLuaConfig =
      ''
        local bicep_lsp_bin = "${bicep-ls}/Bicep.LangServer.dll"
      ''
      + builtins.readFile ./init.lua;
    plugins =
      let
        cmp = [
          {
            plugin = pkgs.vimPlugins.nvim-cmp;
            type = "lua";
            config = builtins.readFile ./plugins/nvim-cmp.lua;
          }
          pkgs.vimPlugins.cmp-nvim-lsp
          pkgs.vimPlugins.cmp-buffer
          pkgs.vimPlugins.cmp-path
          pkgs.vimPlugins.cmp-cmdline
          pkgs.vimPlugins.nvim-cmp
          pkgs.vimPlugins.cmp-vsnip
          pkgs.vimPlugins.vim-vsnip
        ];
        telescope = [
          {
            plugin = pkgs.vimPlugins.telescope-nvim;
            type = "lua";
            config = builtins.readFile ./plugins/telescope-nvim.lua;
          }
          pkgs.vimPlugins.nvim-treesitter
        ];
        searchbox = [
          {
            plugin = pkgs.vimPlugins.searchbox-nvim;
            type = "lua";
            config = builtins.readFile ./plugins/searchbox-nvim.lua;
          }
          pkgs.vimPlugins.nui-nvim
        ];
      in
      [
        { 
          plugin = pkgs.vimPlugins.diffview-nvim;
        }
        {
          plugin = pkgs.vimPlugins.copilot-vim;
          type = "lua";
          config = builtins.readFile ./plugins/copilot-vim.lua;
        }
        {
          plugin = pkgs.vimPlugins.nvim-tree-lua;
          type = "lua";
          config = builtins.readFile ./plugins/nvim-tree-lua.lua;
        }
        {
          plugin = pkgs.vimPlugins.nvim-lspconfig;
          type = "lua";
          config = builtins.readFile ./plugins/nvim-lspconfig.lua;
        }
        {
          plugin = pkgs.vimPlugins.nvim-spectre;
          type = "lua";
          config = builtins.readFile ./plugins/nvim-spectre.lua;
        }
        #{
        #  plugin = auto-session;
        #  type = "lua";
        #  config = builtins.readFile ./neovim/plugins/auto-session.lua;
        #}
      ]
      ++ telescope
      ++ cmp
      ++ searchbox;
  };
}
