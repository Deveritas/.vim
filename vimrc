set nocompatible

filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#rc()
Bundle 'gmarik/vundle'
Bundle 'kien/ctrlp.vim'
Bundle 'Raimondi/delimitMate'
Bundle 'wookiehangover/jshint.vim.git'
Bundle 'scrooloose/nerdtree.git'
Bundle 'raichoo/purescript-vim.git'
Bundle 'rstacruz/sparkup.git'
Bundle 'bling/vim-airline'
Bundle 'tpope/vim-fugitive.git'
Bundle 'airblade/vim-gitgutter.git'
Bundle 'elzr/vim-json.git'
Bundle 'tpope/vim-surround.git'
Bundle 'vimwiki/vimwiki.git'
Plugin 'rking/ag.vim'
syntax on
filetype on
filetype plugin indent on

au BufNewFile,BufRead *.js.wiki set syntax=javascript
au BufNewFile,BufRead *.html.wiki set syntax=html
au BufNewFile,BufRead *.sql SQLSetType mysql.vim
set rtp +=~/.vim/bundle/powerline/bindings/vim

let g:airline_powerline_fonts = 1
let g:gitgutter_sign_column_always = 1
let mapleader=","
let delimitMate_expand_cr = 1
let Tlist_Auto_Open = 1
let Tlist_Ctags_Cmd = '/usr/local/bin/ctags'
let Tlist_Use_Right_Window = 1

set nowrap
set tabstop=2
set backspace=indent,eol,start
set autoindent
set copyindent
set number
set shiftwidth=2
set shiftround
set showmatch
set ignorecase
set smartcase
set smarttab
set hlsearch
set incsearch
set autoread
set expandtab

set scrolloff=4

set formatoptions +=1

nnoremap / /\v
vnoremap / /\v

set lazyredraw
set laststatus=2
set cmdheight=2
set guioptions-=r
set guioptions-=L

if v:version >= 730
	set undofile
	set undodir=~/.vim/.undo,~/tmp,/tmp
endif

if exists('+colorcolumn')
  set colorcolumn=80
else
  au BufWinEnter * let w:m2=matchadd('ErrorMsg', '\%>80v.\+', -1)
endif

set noswapfile

set wildmenu
set wildmode=list:full

set title
set visualbell
set noerrorbells
set showcmd
set cursorline

set foldmethod=syntax
set foldlevel=99
set foldcolumn=4

if &t_Co > 2 || has("gui_running")
	syntax on                    " switch syntax highlighting on, when the
endif

nnoremap ; :
nnoremap <leader>; ;

nnoremap <Space> za
vnoremap <Space> zf

noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l
nnoremap <leader>w <C-w>v<C-w>l

" Avoid accidental hits of <F1> while aiming for <Esc>
noremap! <F1> <Esc>

" Quickly close the current window
nnoremap <leader>q :q<CR>

nnoremap <CR> o<Esc>

nnoremap <silent> <leader>/ :nohlsearch<CR>

" NERDTree settings {{{
nnoremap <leader>N :NERDTreeClose<CR>
nnoremap <leader>n :NERDTreeToggle<CR>

" Store the bookmarks file
let NERDTreeBookmarksFile=expand("$HOME/.vim/NERDTreeBookmarks")

" Show the bookmarks table on startup
let NERDTreeShowBookmarks=1

" Show hidden files, too
let NERDTreeShowFiles=1
let NERDTreeShowHidden=1

" Highlight the selected entry in the tree
let NERDTreeHighlightCursorline=1
let NERDTreeChDirMode=2
" Use a single click to fold/unfold directories and a double click to open
" files
let NERDTreeMouseMode=2
" }}}

set updatetime=750

autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

if has("gui_running")
	set guifont=Sauce\ Code\ Powerline\ Light:h12 linespace=0
end

colorscheme molokai

set pastetoggle=<F2>

nnoremap <up> <nop>
nnoremap <down> <nop>
nnoremap <left> <nop>
nnoremap <right> <nop>


inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>

autocmd vimenter * NERDTree ~/Documents
autocmd BufEnter * silent! lcd %:p:h

augroup reload_vimrc " {
    autocmd!
    autocmd BufWritePost $MYVIMRC source $MYVIMRC
augroup END " }

" generate doc comment template
nnoremap <leader>cc :call GenerateDOCComment()<cr>

function! GenerateDOCComment()
  let l    = line('.')
  let i    = indent(l)
  let pre  = repeat(' ',i)
  let text = getline(l)
  let params   = matchstr(text,'([^)]*)')
  let paramPat = '\([$a-zA-Z_0-9]\+\)[, ]*\(.*\)'
  echomsg params
  let vars = []
  let m    = ' '
  let ml = matchlist(params,paramPat)
  while ml!=[]
    let [_,var;rest]= ml
    let vars += [pre.' * @param '.var]
    let ml = matchlist(rest,paramPat,0)
  endwhile
  let comment = [pre.'/**',pre.' * '] + vars + [pre.' */']
  call append(l-1,comment)
  call cursor(l+1,i+3)
endfunction
