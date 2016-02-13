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
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    call cursor(l, c)
endfun
autocmd BufWritePre * :call <SID>StripTrailingWhitespaces()

" set language for the spell checks to English
:set spell spelllang=en_us
:set nospell

" Search related settings
set incsearch
set hlsearch

" Map Ctrl+l to clear highlighted searches
nnoremap <silent> <C-l> :<C-u>nohlsearch<CR><C-l>

nnoremap <silent> <F9> :TagbarOpenAutoClose<CR>

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

" NERDTree configuration
let NERDTreeIgnore=['\.pyc$', '\.rbc$', '\~$']
map <Leader>n :NERDTreeToggle<CR>

" make uses real tabs
au FileType make set noexpandtab

" Thorfile, Rakefile, Vagrantfile and Gemfile are Ruby
au BufRead,BufNewFile {Gemfile,Rakefile,Vagrantfile,Thorfile,config.ru}    set ft=ruby

" add json syntax highlighting
au BufNewFile,BufRead *.json set ft=javascript

" make Python follow PEP8 ( http://www.python.org/dev/peps/pep-0008/ )
au FileType python set softtabstop=4 tabstop=4 shiftwidth=4 textwidth=79

" spell check all git commit messages
au BufNewFile,BufRead COMMIT_EDITMSG set spell

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

" syntastic settings
let g:syntastic_check_on_wq = 0

" tagbar settings
nmap <F8> :TagbarToggle<CR>
