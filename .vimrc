set nocompatible

" Plugins
call plug#begin('~/.vim/plugged')
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'itchyny/lightline.vim'
Plug 'godlygeek/tabular'
Plug 'kien/ctrlp.vim'
Plug 'neomake/neomake'
Plug 'ervandew/supertab'

Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'majutsushi/tagbar', { 'on': 'TagbarOpenAutoClose' }
Plug 'easymotion/vim-easymotion', { 'on': '<Plug>(easymotion-s2)' }

Plug 'xolox/vim-misc', { 'for': ['rust', 'haskell'] }
Plug 'xolox/vim-easytags', { 'for': ['rust', 'haskell'] }
Plug 'rust-lang/rust.vim', { 'for': 'rust' }
Plug 'racer-rust/vim-racer', { 'for': 'rust' }
Plug 'tpope/vim-markdown', { 'for': 'markdown' }
Plug 'bitc/vim-hdevtools', { 'for': 'haskell' }
Plug 'eagletmt/neco-ghc', { 'for': 'haskell' }

if has('nvim') && has('python3')
    Plug 'Shougo/deoplete.nvim'
end
call plug#end()




" Enable syntax highlighting
syntax on
filetype plugin indent on

color jellybeans

" Add line numbers
set number
set relativenumber
set ruler

" Set encoding
set encoding=utf-8

" Whitespace stuff
set nowrap
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab

" Show trailing spaces and highlight hard tabs
set list listchars=tab:»·,trail:·

" Highlight current line
set cursorline

" Statusline
set noshowmode

" faster scrolling
set lazyredraw

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

" Strip trailing whitespaces on each save
fun! <SID>StripTrailingWhitespaces()
    if exists('b:noStripWhitespace')
        return
    endif

    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    call cursor(l, c)
endfun
autocmd BufWritePre * :call <SID>StripTrailingWhitespaces()

" set language for the spell checks to English
:set spelllang=en_us

" Search related settings
set ignorecase
set smartcase
set incsearch
set hlsearch

" Map Leader
let mapleader = '-'

" Map Ctrl+l to clear highlighted searches
nnoremap <silent> <C-l> :<C-u>nohlsearch<CR><C-l>

" Map Ctrl-s to save
inoremap <C-s> <ESC>:w<CR>i
nnoremap <C-s> :w<CR>

" close all with :Q
command Q :qa

" Map Ctrl-q to run macro
nnoremap <C-q> @q

" Map Leader+e go from terminal to normal mode (only nvim)
if has('nvim')
    tnoremap <Leader>e <C-\><C-n>
endif

" Highlight the 100 chars margin
if exists('+colorcolumn')
    set colorcolumn=100
endif

" Disable code folding
set nofoldenable

" Directories for swp files
set backupdir=~/.vimbackup
set directory=~/.vimbackup

" EasyMotion configuration
let g:EasyMotion_do_mapping = 0
let g:EasyMotion_smartcase = 1
nmap s <Plug>(easymotion-s2)

" Tabular configuration
nmap <Leader>a :Tabularize /
vmap <Leader>a :Tabularize /

" deoplete configuration
let g:deoplete#enable_at_startup = 1

" Neomake configuration
autocmd! BufWritePost,BufEnter * Neomake

" NERDTree configuration
let NERDTreeIgnore=['\.pyc$', '\.rbc$', '\~$']
map <Leader>n :NERDTreeToggle<CR>

" tagbar settings
nnoremap <silent> <F9> :TagbarOpenAutoClose<CR>
let g:tagbar_type_haskell = {
    \ 'ctagsbin'  : 'hasktags',
    \ 'ctagsargs' : '-x -c -o-',
    \ 'kinds'     : [
        \  'm:modules:0:1',
        \  'd:data: 0:1',
        \  'd_gadt: data gadt:0:1',
        \  't:type names:0:1',
        \  'nt:new types:0:1',
        \  'c:classes:0:1',
        \  'cons:constructors:1:1',
        \  'c_gadt:constructor gadt:1:1',
        \  'c_a:constructor accessors:1:1',
        \  'ft:function types:1:1',
        \  'fi:function implementations:0:1',
        \  'o:others:0:1'
    \ ],
    \ 'sro'        : '.',
    \ 'kind2scope' : {
        \ 'm' : 'module',
        \ 'c' : 'class',
        \ 'd' : 'data',
        \ 't' : 'type'
    \ },
    \ 'scope2kind' : {
        \ 'module' : 'm',
        \ 'class'  : 'c',
        \ 'data'   : 'd',
        \ 'type'   : 't'
    \ }
\ }

" make uses real tabs
au FileType make set noexpandtab

" add json syntax highlighting
au BufNewFile,BufRead *.json set ft=javascript

" spell check all git commit messages
au BufNewFile,BufRead COMMIT_EDITMSG set spell

" don't strip whitespaces for 'git add --patch '
au BufNewFile,BufRead ADD_EDIT.patch let b:noStripWhitespace=1
