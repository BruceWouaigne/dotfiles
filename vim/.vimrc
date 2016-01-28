silent! call pathogen#infect()
silent! call Helptags()

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
"set clipboard=unnamedplus
"
let g:gitgutter_escape_grep = 1

if has("gui_running")
    set guifont=Droid\ Sans\ Mono\ for\ Powerline\ 9
    set guioptions -=m
    set guioptions -=T
    set guioptions -=r
    set guioptions -=L
endif

noremap <C-P> :CommandT<CR>

inoremap <Leader>u <C-O>:call PhpInsertUse()<CR>
noremap <Leader>u :call PhpInsertUse()<CR>

inoremap <Leader>e <C-O>:call PhpExpandClass()<CR>
noremap <Leader>e :call PhpExpandClass()<CR>

set tags+=vendor.tags

let g:airline_powerline_fonts = 1
let g:airline_theme='powerlineish'

" Remove trailing whitespaces and ^M chars
autocmd FileType c,cpp,java,php,js,css,html,xml,yml,vim,twig autocmd BufWritePre <buffer> :call setline(1,map(getline(1,"$"),'substitute(v:val,"\\s\\+$","","")'))

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
set tabstop=4
set shiftwidth=4

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

" Highlight trailing whitespaces
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()

" Ctags file generator
nnoremap <F7> :!ctags -h ".php" --PHP-kinds=+cf --regex-php="/^[ \t]*trait[ \t]+([a-z0_9_]+)/\1/t,traits/i" --recurse --exclude="*/cache/*" --exclude="*/logs/*" --exclude="*/data/*" --exclude="\.git" --exclude="\.svn" --languages=PHP

autocmd BufWrite * :call <SID>MkdirsIfNotExists(expand('<afile>:h'))

function! <SID>MkdirsIfNotExists(directory)
    if(!isdirectory(a:directory))
        call system('mkdir -p '.shellescape(a:directory))
    endif
endfunction

let g:syntastic_mode_map = { 'mode': 'active', 'active_filetypes': ['php'], 'passive_filetypes': [] }

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
