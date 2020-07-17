set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'MarcWeber/vim-addon-mw-utils'
Plugin 'tomtom/tlib_vim'
Plugin 'garbas/vim-snipmate'
Plugin 'honza/vim-snippets'
Plugin 'pangloss/vim-javascript'
Plugin 'mxw/vim-jsx'
Plugin 'VundleVim/Vundle.vim'
Plugin 'qpkorr/vim-bufkill'
"Plugin 'sjbach/lusty'
Plugin 'brucewouaigne/php-getter-setter.vim'
Plugin 'scrooloose/syntastic'
Plugin 'godlygeek/tabular'
Plugin 'tpope/vim-fugitive'
Plugin 'airblade/vim-gitgutter'
Plugin 'arnaud-lb/vim-php-namespace'
Plugin 'evidens/vim-twig'
Plugin 'tpope/vim-surround'
Plugin 'scrooloose/nerdtree'
Plugin 'kien/ctrlp.vim'
Plugin 'HerringtonDarkholme/yats.vim'
Plugin 'maxmellon/vim-jsx-pretty'
Plugin 'BufOnly.vim'

call vundle#end()
filetype plugin indent on

"
" General behavior
"
set encoding=utf-8
set nocompatible                " Use vim defaults
let mapleader=","               " Use the comma as leader
set history=1000                " Increase history
set number
set colorcolumn=80
set ignorecase                  " Case-insensitive searching.
set incsearch                   " Highlight matches as you type.
set hlsearch                    " Highlight matches.
set wildmenu                    " Better completion
set wildmode=list:longest       " BASH style completion
set wildignore=.svn,CVS,.git,.hg,*.o,*.a,*.class,*.mo,*.la,*.so,*.obj,*.swp,*.jpg,*.png,*.xpm,*.gif,*.pyc,*.pyo,*.log,**/cache/prod/**,**/cache/dev/**,**/cache/test/**,**/logs/**,**/zend/**,**/vendor/**/vendor/**,web/css,web/js,web/bundles,*/target/*,*.hi
set nobackup                    " Don't make a backup before overwriting a file.
set nowritebackup               " And again.
set noswapfile                  " Use an SCM instead of swap files
set cursorline                  " Highlight current line
set hidden
set laststatus=2
set list
set listchars=nbsp:☹
set clipboard=unnamed
"
let g:gitgutter_escape_grep = 1

if has("gui_running")
    set guifont=SF\ Mono
    "set guifont=Droid\ Sans\ Mono\ for\ Powerline\ 9
    set guioptions -=m
    set guioptions -=T
    set guioptions -=r
    set guioptions -=L
endif

"noremap <C-P> :CommandT<CR>
noremap <C-T> :NERDTreeToggle<CR>

inoremap <Leader>u <C-O>:call PhpInsertUse()<CR>
noremap <Leader>u :call PhpInsertUse()<CR>

inoremap <Leader>e <C-O>:call PhpExpandClass()<CR>
noremap <Leader>e :call PhpExpandClass()<CR>

set tags+=vendor.tags

let g:airline_powerline_fonts = 1
let g:airline_theme='powerlineish'

" powerline
"set rtp+=/usr/local/lib/python3.7/site-packages/powerline/bindings/vim
set laststatus=2
set t_Co=256
source /Users/dcharrier/Library/Python/3.7/lib/python/site-packages/powerline/bindings/vim/plugin/powerline.vim

" Remove trailing whitespaces and ^M chars
autocmd FileType c,cpp,java,php,js,css,html,xml,yml,vim,twig,jinja autocmd BufWritePre <buffer> :call setline(1,map(getline(1,"$"),'substitute(v:val,"\\s\\+$","","")'))

"
" Coloration
"
set t_Co=256    " use 256 colors
colorscheme wombat256mod

" Change line numbers color
"autocmd InsertEnter * hi LineNr      ctermfg=16 ctermbg=214 guifg=Orange guibg=#151515
"autocmd InsertLeave * hi LineNr      term=underline ctermfg=59 ctermbg=232 guifg=#605958 guibg=#151515

"
" Tabs and spaces
"
set expandtab     " converts tabs to spaces
set autoindent    " automatically copy indentation from previous line
set smartindent   " indents one extra level according to current syntax
" indents with tab = 4 spaces
set tabstop=2
set shiftwidth=2
autocmd FileType java setlocal shiftwidth=2 tabstop=2
autocmd FileType ts setlocal shiftwidth=2 tabstop=2
autocmd FileType tsx setlocal shiftwidth=2 tabstop=2
autocmd FileType jsx setlocal shiftwidth=2 tabstop=2

" define shortcuts ',2' and ',4' to change indentation easily:
nmap <leader>2 :set tabstop=2<cr>:set shiftwidth=2<cr>
nmap <leader>4 :set tabstop=4<cr>:set shiftwidth=4<cr>

"
" Syntax & File types
"
syntax enable         " Enable syntax highlighting
filetype on           " enable file type detection
filetype plugin on    " load plugins specific to file type
filetype indent on    " ... and indentation too

autocmd FileType php set omnifunc=phpcomplete#CompletePHP
imap <C-Space> <C-x><C-o>
imap <C-@> <C-Space>

" Use the htmljinja syntax for twig files
au BufNewFile,BufRead *.twig set ft=htmljinja
au BufNewFile,BufRead *.jinja set ft=htmljinja

" Highlight trailing whitespaces
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()

" Ctags file generator
nnoremap <F7> :!ctags -h ".php" --PHP-kinds=+cf --regex-php="/^[ \t]*trait[ \t]+([a-z0_9_]+)/\1/t,traits/i" --recurse --exclude="*/cache/*" --exclude="*/logs/*" --exclude="*/data/*" --exclude="\.git" --exclude="\.svn" --languages=PHP
nnoremap <F8> :!ctags -h ".py" --python-kinds=-i --recurse --exclude="*/cache/*" --exclude="*/logs/*" --exclude="*/data/*" --exclude="\.git" --exclude="\.svn" --exclude="*/build/*" --languages=Python

autocmd BufWrite * :call <SID>MkdirsIfNotExists(expand('<afile>:h'))

function! <SID>MkdirsIfNotExists(directory)
    if(!isdirectory(a:directory))
        call system('mkdir -p '.shellescape(a:directory))
    endif
endfunction

let g:syntastic_mode_map = { 'mode': 'passive', 'active_filetypes': [],'passive_filetypes': [] }
let g:syntastic_check_on_wq = 0
let g:syntastic_check_on_open = 0
let g:syntastic_python_flake8_post_args='--ignore=E501,E402'
nnoremap <F2> :SyntasticCheck<CR> :SyntasticToggleMode<CR>

inoremap <silent> <Bar>   <Bar><Esc>:call <SID>align()<CR>a

function! s:align()
  let p = '^\s*|\s.*\s|\s*$'
  if exists(':Tabularize') && getline('.') =~# '^\s*|' && (getline(line('.')-1) =~# p || getline(line('.')+1) =~# p)
    let column = strlen(substitute(getline('.')[0:col('.')],'[^|]','','g'))
    let position = strlen(matchstr(getline('.')[0:col('.')],'.*|\s*\zs.*'))
    Tabularize/|/l1
    normal! 0
    call search(repeat('[^|]*|',column).'\s\{-\}'.repeat('.',position),'ce',line('.'))
  endif
endfunction

"set -o vi
"set +o vi

