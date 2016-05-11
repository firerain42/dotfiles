set nocompatible

" Initialize Pathogen
runtime bundle/vim-pathogen/autoload/pathogen.vim
execute pathogen#infect()

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

" highlight current line
set cursorline

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

" Map Leader+e go from terminal to normal mode (only nvim)
if has('nvim')
    tnoremap <Leader>e <C-\><C-n>
endif

" Highlight the 80 chars margin
if exists('+colorcolumn')
    set colorcolumn=80
endif

" Disable code folding
set nofoldenable

" Directories for swp files
set backupdir=~/.vimbackup
set directory=~/.vimbackup

" EasyMotion configuration
let g:EasyMotion_do_mapping = 0
nmap s <Plug>(easymotion-s2)
let g:EasyMotion_smartcase = 1

" Tabular configuration
nmap <Leader>a :Tabularize /
vmap <Leader>a :Tabularize /

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

" make Python follow PEP8 ( http://www.python.org/dev/peps/pep-0008/ )
au FileType python set softtabstop=4 tabstop=4 shiftwidth=4 textwidth=79

" spell check all git commit messages
au BufNewFile,BufRead COMMIT_EDITMSG set spell

" don't strip whitespaces for 'git add --patch '
au BufNewFile,BufRead ADD_EDIT.patch let b:noStripWhitespace=1
