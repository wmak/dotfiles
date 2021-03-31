" Plugins will be downloaded under the specified directory.
let g:polyglot_disabled = ['markdown']
call plug#begin('~/.vim/plugged')
" Declare the list of plugins.
Plug 'dense-analysis/ale'
Plug 'yggdroot/indentline'
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'airblade/vim-gitgutter'
Plug 'easymotion/vim-easymotion'
Plug 'janko-m/vim-test'
Plug 'wmak/fairyfloss.vim'
Plug 'bling/vim-bufferline'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'sheerun/vim-polyglot'
" Git
Plug 'tpope/vim-fugitive'
Plug 'tmhedberg/SimpylFold'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'pappasam/coc-jedi', { 'do': 'yarn install --frozen-lockfile && yarn build' }
Plug 'HerringtonDarkholme/yats.vim'
Plug 'mhartington/nvim-typescript', {'do': './install.sh'}
Plug 'Shougo/denite.nvim'
" List ends here. Plugins become visible to Vim after this call.
call plug#end()

" fzf alias
cnoreabbrev ~~ FZF

let g:node_host_prog = '~/.volta/tools/image/packages/neovim/4.9.0/bin/cli.js'

" NerdTree
map <C-a> :NERDTreeToggle<CR>
let NERDTreeShowLineNumbers=1

" highlight 121 and onward so 120 is the last valid column
set textwidth=120
autocmd bufreadpre *.html setlocal textwidth=0
autocmd Filetype javascript setlocal tabstop=8 softtabstop=0 expandtab shiftwidth=2 smarttab
autocmd Filetype javascriptreact setlocal tabstop=8 softtabstop=0 expandtab shiftwidth=2 smarttab
autocmd Filetype typescriptreact setlocal tabstop=8 softtabstop=0 expandtab shiftwidth=2 smarttab
set colorcolumn=+1,+31

" switch buffers without saving
set hidden

" Airline font
let g:airline_powerline_fonts = 1
let g:airline_left_alt_sep =''
let g:airline_section_b = ''
let g:airline_section_x = ''
let g:airline_section_y = airline#section#create(['%l'])
let g:airline_section_z = airline#section#create(['%c'])
let g:airline_extensions = ['bufferline']

" show line numbers
set number

let g:ale_linters = {
\   'python': ['flake8'],
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
let test#python#pytest#options = '--disable-pytest-warnings'

" Open fzf
nnoremap <C-O> :GFiles<cr>
function! RipgrepFzf(query, fullscreen)
  let command_fmt = 'rg --ignore-file ~/.gitignore --column --line-number --no-heading --color=always --smart-case -- %s || true'
  let initial_command = printf(command_fmt, shellescape(a:query))
  let reload_command = printf(command_fmt, '{q}')
  let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
  call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
endfunction

command! -nargs=* -bang RG call RipgrepFzf(<q-args>, <bang>0)
nnoremap <C-I> :RG<cr>

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

" buffer management
let mapleader           = ' '
nnoremap <leader>b :ls<cr>:b<space>

nnoremap <leader>r :RGc

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
hi Blamer guifg=lightgrey
