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
Plug 'osyo-manga/vim-over'

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
set linebreak
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab

" Move always one display line
nnoremap j gj
nnoremap k gk

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

" Easier window navigation
if has('nvim')
    tnoremap <A-a> <C-\><C-n>

    tnoremap <A-h> <C-\><C-n><C-w>h
    tnoremap <A-j> <C-\><C-n><C-w>j
    tnoremap <A-k> <C-\><C-n><C-w>k
    tnoremap <A-l> <C-\><C-n><C-w>l
endif
nnoremap <A-h> <C-w>h
nnoremap <A-j> <C-w>j
nnoremap <A-k> <C-w>k
nnoremap <A-l> <C-w>l

" Map Ctrl-q to run macro
nnoremap <C-q> @q

" Map Leader+e go from terminal to normal mode (only nvim)
if has('nvim')
    tnoremap <Leader><ESC> <C-\><C-n>
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

" Ignore these filetypes when expanding a wildcard
set wildignore=*.class,*.jar,*.tar*,*.pdf,*.png,*.jpg,*.jpeg,*.tiff,*.tif

" Simplify clipboard usage
nnoremap <Leader>p "+p
vnoremap <Leader>p "+p
vnoremap <Leader>y "+y

" EasyMotion configuration
let g:EasyMotion_do_mapping = 0
let g:EasyMotion_smartcase = 1
nmap s <Plug>(easymotion-s2)

" Tabular configuration
nmap <Leader>a :Tabularize /
vmap <Leader>a :Tabularize /

" deoplete configuration
let g:deoplete#enable_at_startup = 1

" Lightline configuration
set laststatus=2

" SuperTab configuration
let g:SuperTabCrMapping = 1
let g:SuperTabMappingForward = '<s-tab>'
let g:SuperTabMappingBackward = '<tab>'

" vim-over configuration
nmap <Leader>S :OverCommandLine<CR>

" Neomake configuration
nmap <Leader>m :Neomake<CR>
let g:neomake_open_list = 2
let g:neomake_list_height = 7
let g:neomake_cabal_cabal_buffer_output = 1
let g:neomake_rust_rustc_buffer_output = 1
au FileType rust nmap <Leader>M :Neomake! cargo<CR>
au FileType haskell nmap <Leader>M :Neomake! stack<CR>
function! neomake#makers#ft#tex#EnabledMakers() abort
    return ['chktex', 'lacheck', 'rubberinfo', 'proselint', 'rubber']
endfunction

" NERDTree configuration
let NERDTreeIgnore=['\.pyc$', '\.rbc$', '\~$']
map <Leader>n :NERDTreeToggle<CR>

" EasyTags configuration
let g:easytags_async = 1
let g:easytags_events = ['BufWritePost']
let g:easytags_include_members = 1
let g:easytags_auto_highlight = 0

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
let g:tagbar_type_rust = {
    \ 'ctagstype' : 'rust',
    \ 'kinds' : [
        \'T:types',
        \'f:functions',
        \'g:enums',
        \'s:structs',
        \'m:modules',
        \'c:consts',
        \'t:traits',
        \'i:impls',
    \ ],
    \}

" make uses real tabs
au FileType make set noexpandtab

" wrap lines
au FileType text,tex,latex,markdown set wrap

" add json syntax highlighting
au BufNewFile,BufRead *.json set ft=javascript

" spell check all git commit messages
au BufNewFile,BufRead COMMIT_EDITMSG set spell

" don't strip whitespaces for 'git add --patch '
au BufNewFile,BufRead ADD_EDIT.patch let b:noStripWhitespace=1

" set wrap for the quickfix list
au FileType qf setlocal wrap
