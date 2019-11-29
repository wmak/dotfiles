" Setup for Vundle
let g:vundle_default_git_proto="git"
set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'gmarik/Vundle.vim'
Plugin 'w0rp/ale'
Plugin 'plasticboy/vim-markdown'
Plugin 'tpope/vim-sleuth'
Plugin 'airblade/vim-gitgutter'
Plugin 'tmhedberg/SimpylFold'
Plugin 'w0ng/vim-hybrid'
Plugin 'bling/vim-bufferline'
Plugin 'vim-airline/vim-airline'
Plugin 'wmak/fairyfloss.vim'
Plugin 'yggdroot/indentline'
Plugin 'janko-m/vim-test'
Plugin 'tpope/vim-fugitive'
Plugin 'scrooloose/nerdtree'
Plugin 'Xuyuanp/nerdtree-git-plugin'
Plugin 'sheerun/vim-polyglot'
call vundle#end() 

" NerdTree
map <C-a> :NERDTreeToggle<CR>
let NERDTreeShowLineNumbers=1

" switch buffers without saving
set hidden

" Tell vim-test to do django
let test#python#runner = 'djangotest'

" bufferline settings
let g:bufferline_echo = 0
autocmd VimEnter *
  \ let &statusline='%{bufferline#refresh_status()}'
    \ .bufferline#get_status_string()

" Airline font
let g:airline_powerline_fonts = 1
let g:airline_left_alt_sep =''
let g:airline_section_b = ''
let g:airline_section_x = ''
let g:airline_section_y = ''
let g:airline_section_z = airline#section#create(['%c'])
let g:airline_extensions = ['bufferline']

" better brace matching
runtime macros/matchit.vim

" syntax highlighting
syntax on
filetype plugin indent on 

" Backspace on macs
set nocompatible
set backspace=indent,eol,start

" highlight 91 and onward so 90 is the last valid column
set textwidth=120
autocmd bufreadpre *.html setlocal textwidth=0
set colorcolumn=+1,+31

" spellcheck git commits
autocmd Filetype gitcommit setlocal spell textwidth=72

" ale
let g:ale_linters = {
\   'python': ['black'],
\   'javascript': ['eslint'],
\}
let g:ale_completion_tsserver_autoimport = 1

" speed up buffers?
augroup EditVim
  autocmd!
  autocmd BufWritePost .vimrc source $MYVIMRC
  autocmd FileType vim setlocal foldmethod=marker
augroup END
set bufhidden=hide

" show line numbers
set number

" tell vim how many columns a tab is
set tabstop=4
set shiftwidth=4
set smarttab

" show whitespace characters
set listchars=eol:↩,tab:▶▷,trail:▷,extends:>,precedes:<

" tell vim I have a dark background
set bg=dark

" I'm a bad person and like emacs nav
inoremap <C-A> <Home>
inoremap <C-B> <Left>
inoremap <C-E> <End>
inoremap <C-F> <Right>
inoremap <C-_> <Esc>ui

" Bind F1 to toggle folding
nnoremap <F1> :set foldenable!<cr>

" enters paste mode on F2
set pastetoggle=<F2>

" remap <F3> to show whitespace
nnoremap <F3> :set list!<cr>

" TestNearest
nnoremap <F4> :w<cr>:TestNearest<cr>

" Spellchecking
" set spell spelllang=en_us
nnoremap <F8> :set spelllang=en_ca spell<cr>

" Easier entry to commmand-mode
noremap ; :

" rebing backslash and bar for F and T
noremap <BSLASH> ;
noremap <BAR> ,

" Viewport laziness
noremap <S-Up> <C-W>k
noremap <S-Down> <C-W>j
noremap <S-Left> <C-W>h
noremap <S-Right> <C-W>l


" Ignore swp and pyc files
let g:netrw_list_hide= '.*\.swp$,.*\.pyc'

" Map Leader is comma
let mapleader           = ','
" }}}

" When there's a match highlight all matches
set hlsearch

" When typing a search immediately show immediately where the match is
" set incsearch

" recognize that md is markdown not modula
au BufRead,BufNewFile *.md set filetype=markdown

" statusline.
set laststatus=2
set statusline=%t[%{strlen(&fenc)?&fenc:'none'},%{&ff}]%h%m%r%y%=%c,%l/%L

" Word count
command! -count=0 -nargs=0 WC <count>,$w ! wc -w
command! -range=% -nargs=0 WC <line1>,<line2>w ! wc -w

command! -nargs=? -complete=file E :Explore <args>
" Folds {{{
set foldmethod=marker          " Fold based on marker
set foldnestmax=3              " Deepest fold is 3 levels
set foldlevel=99               " Dont fold by default
set foldopen=block,hor,insert  " Which commands trigger autounfold
set foldopen+=jump,mark
set foldopen+=percent,search
set foldopen+=quickfix,tag,undo
" }}}

" Completion {{{
set completeopt=longest,menuone
set wildmenu                            " C-n and C-p scroll through matches
set wildmode=longest:full,full          " Show completions on first <TAB> and
"stuff to ignore when tab completing
set wildignore=*.o,*.obj                " object files
set wildignore+=*.class                 " Java class files
set wildignore+=*.pyc                   " python compiled files
set wildignore+=*.meta                  " unity meta
set wildignore+=*~,#*#,*.swp            " all other backup files
" tmp folder and log folders
set wildignore+=log/**
set wildignore+=tmp/**                  " anything that is temporary
" image files
set wildignore+=*.png,*.jpg,*.gif
set wildignore+=*.bmp
" }}}

" Persistent History, Oh baby!
if has("persistent_undo")
    set undodir=~/.vim/backups
    set undofile
endif

" Colour theme
set t_Co=256
set t_ut=
colorscheme fairyfloss
set termguicolors
hi Normal ctermbg=NONE

let g:indentLine_char_list = ['|', '¦', '┆', '┊']

if exists('$TMUX')
  let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
  let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
else
  let &t_SI = "\<Esc>]50;CursorShape=1\x7"
  let &t_EI = "\<Esc>]50;CursorShape=0\x7"
endif
