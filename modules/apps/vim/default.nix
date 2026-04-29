{ config, pkgs, lib, ... }:

let
  tokyonight = pkgs.vimPlugins.tokyonight-nvim;

  tokyonightVim = pkgs.runCommand "tokyonight-vim" {} ''
    mkdir -p $out/colors
    cp ${tokyonight}/extras/vim/colors/* $out/colors/
  '';
in

{

  options.mymodules.vim.enable = lib.mkEnableOption "vim";

  config = lib.mkIf config.mymodules.vim.enable {

    environment.systemPackages = [
      (pkgs.vim-full.customize {
        name = "vim";

        vimrcConfig.packages.myplugins = with pkgs.vimPlugins; {
          start = [
            fzf-vim
            lightline-vim
          ];
        };

        vimrcConfig.customRC = ''
          " --- options ---
          filetype plugin indent on
          set expandtab
          set shiftwidth=2
          set softtabstop=2
          set tabstop=2
          set number
          set relativenumber
          set smartindent
          set showmatch
          set backspace=indent,eol,start
          syntax on
          set mouse=a
          let g:netrw_liststyle = 3

          " --- colors ---
          set termguicolors
          set laststatus=2
          set runtimepath^=${tokyonightVim}
          let g:tokyonight_enable_italic = 1
          let g:lightline = {'colorscheme' : 'darcula'}
          colorscheme tokyonight

          " --- keybinds ---
          let mapleader = " "
          nnoremap <leader>cd :Ex<CR>

          " --- fzf ---
          nnoremap <leader>ff :Files<CR>
          nnoremap <leader>fo :History<CR>
          nnoremap <leader>fb :Buffers<CR>
          nnoremap <leader>fq :CList<CR>
          nnoremap <leader>fh :Helptags<CR>
          nnoremap <leader>fs :Rg <C-r><C-w><CR>
          nnoremap <leader>fg :Rg<Space>
          nnoremap <leader>fc :execute 'Rg ' . expand('%:t:r')<CR>
          nnoremap <leader>fi :Files ~/.vim<CR>
        '';
      })

      pkgs.fzf
      pkgs.ripgrep  # required for :Rg
    ];
  };

}

