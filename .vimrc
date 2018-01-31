" Dependencies:
" [linux] sudo apt-get install silversearcher-ag
" [OSX]   brew install the_silver_searcher

" Install vundle: https://github.com/gmarik/Vundle.vim#quick-start
" Then run :PluginInstall

" Vundle
set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/Vundle.vim'

Plugin 'tpope/vim-rails'
Plugin 'tpope/vim-fugitive'        " Gblame
Plugin 'kien/ctrlp.vim'
Plugin 'FelikZ/ctrlp-py-matcher'
Plugin 'vim-scripts/matchit.zip'   " match xml tags with %
Plugin 'pbrisbin/vim-mkdir'
Plugin 'skalnik/vim-vroom'         " run ruby tests

" Plugin 'Valloric/YouCompleteMe'    " completion

Plugin 'w0rp/ale'                  " async syntax highlighting
" Plugin 'scrooloose/syntastic'
" Plugin 'slim-template/vim-slim'    " haml syntax highlighting?
" Plugin 'toyamarinyon/vim-swift'
" Plugin 'kchmck/vim-coffee-script'  " coffeescript
" Plugin 'mtscout6/vim-cjsx'         " coffeescript jsx
" Plugin 'ngmy/vim-rubocop'

Plugin 'ryanss/vim-hackernews'

" Plugin 'nathanaelkane/vim-indent-guides'  " zebra-stripe indentation
" Plugin 'tpope/vim-endwise'       " add end tags in ruby

call vundle#end()
filetype plugin indent on

" let g:syntastic_ruby_checkers = ['mri', 'rubocop']
" let g:syntastic_ruby_rubocop_exec = '/home/iqnivek/.rbenv/shims/rubocop'
" let g:syntastic_coffee_checkers = ['coffeelint', 'coffee']
let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_python_checkers = ['flake8']
let g:syntastic_scss_checkers = ['scss_lint']

" ctrlp - open files in tabs
let g:ctrlp_prompt_mappings = {
    \ 'AcceptSelection("e")': ['<c-t>'],
    \ 'AcceptSelection("t")': ['<cr>', '<2-LeftMouse>'],
    \ }

" ctrlp - use .gitignore
let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']

" ctrlp - faster indexing with hg and pymatch
let g:ctrlp_match_func = { 'match': 'pymatcher#PyMatch' }
" let g:ctrlp_user_command = 'ag %s -i --nocolor --nogroup --hidden --ignore .git --ignore .svn --ignore .hg --ignore .DS_Store -g ""'

" set background=dark
set ignorecase 
set smartcase
set title
set scrolloff=3
set ruler

" Update file when it gets changed in filesystem
" http://stackoverflow.com/a/10962191/341512
set autoread
augroup checktime
    au!
    if !has("gui_running")
        "silent! necessary otherwise throws errors when using command
        "line window.
        autocmd BufEnter        * silent! checktime
        autocmd CursorHold      * silent! checktime
        autocmd CursorHoldI     * silent! checktime
        "these two _may_ slow things down. Remove if they do.
        autocmd CursorMoved     * silent! checktime
        autocmd CursorMovedI    * silent! checktime
    endif
augroup END

" Don't show 'existing swap file found' warning when opening a file in two vim instances
set shortmess+=A

" Enable mouse
" set mouse=a

" Intuitive backspacing in insert mode
set backspace=indent,eol,start
 
" File-type highlighting and configuration.
" Run :filetype (without args) to see what you may have
" to turn on yourself, or just set them all to be sure.
syntax on
filetype on
filetype plugin on
filetype indent on
 
" Highlight search terms dynamically as they are typed
set hlsearch
set incsearch

" Ruby 2-space tabs
set tabstop=2
set shiftwidth=2
set expandtab
set softtabstop=2
set autoindent

autocmd FileType html setlocal shiftwidth=2 tabstop=2 expandtab softtabstop=2 autoindent

" Press F2 in insert mode to paste text with proper indentation
nnoremap <F2> :set invpaste ?<CR>
set pastetoggle=<F2>
set showmode

" Make 'ga' split the current tab and then navigate to tab under the cursor (depends on vim-rails 'gf' command)
map ga :tab split<Enter>gf

" Set backup directory
" set swapfile
" set dir=~/backup/vim

" Increase tab maximum. I'm a wild man.
set tabpagemax=150

" Tab completion
set wildmode=longest,list
" set wildmode=longest,list,full
" set wildmenu

" Line numbers (:set nonu[mber] to remove for terminal copy/paste)
set number
highlight LineNr ctermfg=grey ctermbg=darkgrey

" Find and use SCSS lint config if available in project
" https://github.com/vim-syntastic/syntastic/issues/1373#issuecomment-161295716
fun! SetScssConfig()
    let scssConfig = findfile('.scss-lint.yml', '.;')
    if scssConfig != ''
        let b:syntastic_scss_scss_lint_args = '--config ' . scssConfig
    endif
endf

" autocommands
if !exists("autocommands_loaded")
    autocmd FileType scss :call SetScssConfig()
endif
