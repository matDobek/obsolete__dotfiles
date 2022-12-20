" ====================
" ====================
"
" PLUGINS
"
" ====================
" ====================

call plug#begin('~/.config/nvim/plugged')

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'          " fzf           -- fuzzy search
Plug 'scrooloose/nerdcommenter'  " nerdcommenter -- easy comments
Plug 'scrooloose/nerdtree'       " nerdtree      -- file tree
Plug 'godlygeek/tabular'         " tabular       -- alignment
Plug 'tpope/vim-fugitive'        " vim-fugitive  -- git
Plug 'tpope/vim-dadbod'          " vim-dadbod    -- database interface
Plug 'vim-test/vim-test'         " vim-test      -- wrapper for running tests
Plug 'rktjmp/lush.nvim'          " colorscheme editing make easy

" syntax
Plug 'tpope/vim-markdown'        " markdown
Plug 'elixir-editors/vim-elixir' " elixir
Plug 'vim-ruby/vim-ruby'         " ruby
Plug 'rlue/vim-fold-rspec'       " rspec         -- automatically folds specs
Plug 'elkowar/yuck.vim'          " yuck

" themes
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'ghifarit53/tokyonight-vim', { 'as': 'tokyonight' }
Plug 'danilo-augusto/vim-afterglow', { 'as': 'afterglow' }
Plug 'sts10/vim-pink-moon'
Plug 'morhetz/gruvbox'
Plug 'file://'.expand('~/main/friday/colorschemes/tamtam.nvim'), { 'as': 'tamtam' }

" maybe
"Plug 'jbyuki/venn.nvim' " Draw ASCII diagrams
Plug 'norcalli/nvim-colorizer.lua' " color highlighter
Plug 'tpope/vim-dispatch'


"Plug 'neovim/nvim-lspconfig'
"Plug 'onsails/lspkind-nvim'
"Plug 'hrsh7th/cmp-nvim-lsp'
"Plug 'hrsh7th/cmp-buffer'
"Plug 'hrsh7th/cmp-path'
"Plug 'hrsh7th/cmp-cmdline'
"Plug 'hrsh7th/nvim-cmp'

"" For vsnip users.
"Plug 'hrsh7th/cmp-vsnip'
"Plug 'hrsh7th/vim-vsnip'

call plug#end()

" ====================
" ====================
"
" GLOBAL
"
" ====================
" ====================

" fix colors when in tmux
if exists('+termguicolors')
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif

set shellcmdflag=-ic                         " load ~/.bashrc ( useful to load bash_aliases )

set nocompatible                             " turn off compatibility with Vi

set tabstop=2                                " size (in spaces) of tab
set shiftwidth=2                             " affects pressing '<<' , '>>' , =='
set expandtab                                " expand tab to spaces
set autoindent                               " copy indentation from previous line, and apply to next one

set hlsearch                                 " highlight searches
set incsearch                                " start searching when you type
set ignorecase                               " ignore case when searching

set laststatus=2                             " last window will have a status line always visible

set relativenumber                           " display relative number
set noswapfile                               " do not use swapfiles, as files are modified by one user at time

set undodir=~/.vim/undodir                   " specify where to keep history
set undofile                                 " keep history after exiting file

filetype on                                  " Enable filetype detection
filetype indent on                           " Enable filetype-specific indenting
filetype plugin on                           " Enable filetype-specific plugins

syntax on

colorscheme tamtam

autocmd BufWritePre * :call TrimWhiteSpace() " trim white spaces on save

function! TrimWhiteSpace()
  %s/\s\+$//e
endfunction

" ====================
" ====================
"
" KEY BINDINGS
"
" ====================
" ====================

let mapleader = " "

" normal mode in terminal via esc
tnoremap <Esc> <C-\><C-n>

" cycle through buffers
nnoremap <S-k> :bn<cr>
nnoremap <S-j> :bp<cr>

" quit Hlsearch
noremap qq :noh<cr>

" resize by arrows in normal mode
nnoremap <left> :vertical resize +5<cr>
nnoremap <right> :vertical resize -5<cr>

" vim :: reload
nnoremap <leader>rel :source ~/.config/nvim/init.vim<CR>

" copy to system clipbord
noremap <leader>yy "+yy

" close buffer, without breaking the split
noremap <leader>bd :b#<bar>bd#<CR>

" split buffer vertically
noremap <leader>v :vsplit<CR>
" split buffer horizontally
noremap <leader>h :split<CR>

" --------------------
" folds
" --------------------
"
" fold / unfold
nnoremap <tab> za

" close all folds
nnoremap <leader>folc zM

" open all folds
nnoremap <leader>folo zR

" --------------------
" spell checker
" --------------------
"
" add new word to dictionary
nnoremap <leader>dira zg

" delete word from dictionary
nnoremap <leader>dird zw

" correct to the first suggested word
nnoremap <leader>dirc 1z=

" list of correct words
nnoremap <leader>dirl z=

" next mispelled world
nnoremap <leader>dirn ]s

" previous mispelled world
nnoremap <leader>dirN [s


" ====================
" ====================
"
" PLUGINS SETUP
"
" ====================
" ====================
"
" --------------------
" fzf
" --------------------
" https://github.com/junegunn/fzf.vim

let g:fzf_layout = { 'down': '~100%' }
let g:fzf_preview_window = ['up:50%', 'ctrl-/']

" hidden by default, ctrl-/ to toggle
"let g:fzf_preview_window = ['up:30%:hidden', 'ctrl-/']

" search from all files in directory
noremap <leader>sf :Files ./<cr>

" search for keywords
noremap <leader>sk :Ag<space>

" --------------------
" nerdtree
" --------------------
" https://github.com/preservim/nerdtree

let NERDTreeShowHidden=1

nnoremap <leader>p :call ToggleNERDTree()<cr>

function! ToggleNERDTree()
  if g:NERDTree.IsOpen()
    execute ':NERDTreeClose'
  elseif filereadable(bufname(bufnr())) > 0
    execute ':NERDTreeFind'
  else
    execute ':NERDTree'
  endif
endfunction

" --------------------
" nerdcommenter
" --------------------
" https://github.com/preservim/nerdcommenter

xmap <leader>/ <Plug>NERDCommenterToggle
nmap <leader>/ <Plug>NERDCommenterToggle

" --------------------
" tabular
" --------------------
" https://github.com/godlygeek/tabular
"
" :'<,'>Tabular/=
"
xmap <leader>a :Tabularize/
nmap <leader>a :Tabularize/

xmap <leader>a= :Tabularize/=<enter>
nmap <leader>a= :Tabularize/=<enter>

xmap <leader>a\| :Tabularize/\|<enter>
nmap <leader>a\| :Tabularize/\|<enter>

" --------------------
" vim-fugitive
" --------------------
" https://github.com/tpope/vim-fugitive

" --------------------
" markdown
" --------------------
" https://github.com/tpope/vim-markdown

let g:markdown_folding = 1


" --------------------
" vim-dadbod
" --------------------
" https://github.com/tpope/vim-dadbod

nnoremap <leader>dbl :DB postgresql://postgres@localhost/sample_database

" --------------------
" vim-test
" --------------------
" https://github.com/vim-test/vim-test
" :TestNearest -- in a test file runs the test nearest to the cursor, otherwise runs the last nearest test
" :TestFile -- in a test file runs all tests in the current file, otherwise runs the last file tests.
" :TestSuite -- runs the whole test suite (if the current file is a test file, runs that framework's test suite, otherwise determines the test framework from the last run test).
" :TestLast -- runs the last test.
" :TestVisit -- visits the test file from which you last run your tests (useful when you're trying to make a test pass, and you dive deep into application code and close your test buffer to make more space, and once you've made it pass you want to go back to the test file to write more tests).
"

"let test#strategy = "dispatch"

nmap <silent> <leader>tt :TestNearest<CR>
nmap <silent> <leader>tf :TestFile<CR>
nmap <silent> <leader>ta :TestSuite<CR>
nmap <silent> <leader>tl :TestLast<CR>
nmap <silent> <leader>tg :TestVisit<CR>

" --------------------
" ruby
" --------------------
"
" run ruby for current file
"autocmd FileType ruby noremap <leader>rr :Dispatch ruby % <CR>

" run minitest test for current file
"autocmd FileType ruby noremap <leader>rtm :Dispatch bin/minitest % <CR>

" run spec test for current file
"autocmd FileType ruby noremap <leader>rtr :Dispatch rspec % <CR>

" create alternate file
"autocmd FileType ruby noremap <leader>ram :! $friday__scripts_path/rails_alternate_file/main %:p minitest <CR>
"autocmd FileType ruby noremap <leader>rar :! $friday__scripts_path/rails_alternate_file/main %:p rspec <CR>

" --------------------
" jbyuki/venn.nvim
" --------------------

"set virtualedit=all
"nmap <C-h> <C-v>h:VBox<CR>
"nmap <C-j> <C-v>j:VBox<CR>
"nmap <C-k> <C-v>k:VBox<CR>
"nmap <C-l> <C-v>l:VBox<CR>

"vmap <C-f> :VBox<CR>

" ============= LUA ==============

set completeopt=menu,menuone,noselect

lua <<EOF
  require'colorizer'.setup()
EOF
