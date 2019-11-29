" Plugins will be downloaded under the specified directory.
call plug#begin('~/.vim/plugged')
" Declare the list of plugins.
Plug 'dense-analysis/ale'
Plug 'yggdroot/indentline'
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'janko-m/vim-test'
Plug 'wmak/fairyfloss.vim'
Plug 'bling/vim-bufferline'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'sheerun/vim-polyglot'
Plug 'tpope/vim-fugitive'
Plug 'tmhedberg/SimpylFold'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'deoplete-plugins/deoplete-jedi'
Plug '/usr/local/opt/fzf'
" List ends here. Plugins become visible to Vim after this call.
call plug#end()

" fzf alias
cnoreabbrev ~~ FZF

let g:deoplete#enable_at_startup = 1
let g:deoplete#disable_auto_complete = 1
inoremap <expr> <C-n>  deoplete#manual_complete()
let g:deoplete#sources#jedi#enable_typeinfo = 0

" NerdTree
map <C-a> :NERDTreeToggle<CR>
let NERDTreeShowLineNumbers=1

" highlight 121 and onward so 120 is the last valid column
set textwidth=120
autocmd bufreadpre *.html setlocal textwidth=0
set colorcolumn=+1,+31

" switch buffers without saving
set hidden

" Airline font
let g:airline_powerline_fonts = 1
let g:airline_left_alt_sep =''
let g:airline_section_b = ''
let g:airline_section_x = ''
let g:airline_section_y = ''
let g:airline_section_z = airline#section#create(['%c'])
let g:airline_extensions = ['bufferline']

" show line numbers
set number

let g:ale_linters = {
\   'python': ['black'],
\   'javascript': ['eslint'],
\}

" show whitespace characters
set listchars=eol:↩,tab:▶▷,trail:▷,extends:>,precedes:<

" I'm a bad person and like emacs nav
inoremap <C-A> <Home>
inoremap <C-B> <Left>
inoremap <C-E> <End>
inoremap <C-F> <Right>
inoremap <C-_> <Esc>ui

" Bind F1 to toggle folding
nnoremap <F1> :set foldenable!<cr>
set foldmethod=syntax
let javaScript_fold=1

" enters paste mode on F2
set pastetoggle=<F2>

" remap <F3> to show whitespace
nnoremap <F3> :set list!<cr>

" TestNearest
nnoremap <F4> :w<cr>:TestNearest<cr>

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

" When there's a match highlight all matches
set hlsearch

" statusline.
set laststatus=2
set statusline=%t[%{strlen(&fenc)?&fenc:'none'},%{&ff}]%h%m%r%y%=%c,%l/%L

" Persistent History, Oh baby!
if has("persistent_undo")
    set undodir=~/.vim/backups
    set undofile
endif

let g:indentLine_char_list = ['|', '¦', '┆', '┊']

" Colour theme
set t_Co=256
set t_ut=
colorscheme fairyfloss
set termguicolors
hi Normal ctermbg=NONE
