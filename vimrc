" Setup for Vundle
let g:vundle_default_git_proto="git"
set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'gmarik/Vundle.vim'
" Plugin 'scrooloose/syntastic'
Plugin 'godlygeek/tabular'
Plugin 'plasticboy/vim-markdown'
call vundle#end() 

" better brace matching
runtime macros/matchit.vim

" syntax highlighting
syntax on
filetype plugin indent on 

" highlight 81 and onward so 80 is the last valid column
set textwidth=80
set colorcolumn=+1,+21

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

" Keybindings {{{
" Use qq to escape
inoremap qq <ESC>

" Bind F1 to toggle folding
nnoremap <F1> :set foldenable!<cr>

" enters paste mode on F2
set pastetoggle=<F2>

" remap <F3> to show whitespace
nnoremap <F3> :set list!<cr>

" go fmt
nnoremap <F4> :w<cr>:!go fmt % <cr>:edit<cr>

" map <F7> to spellcheck
nnoremap <F5> :set spelllang=en_ca spell<cr>

" Easier entry to commmand-mode
noremap ; :

" rebing backslash and bar for F and T
noremap <BSLASH> ;
noremap <BAR> ,

" Map Leader is comma
let mapleader           = ','
" }}}

" When there's a match highlight all matches
set hlsearch

" When typing a search immediately show immediately where the match is
set incsearch

" recognize that md is markdown not modula
au BufRead,BufNewFile *.md set filetype=markdown

" vim-latexsuite
set grepprg=grep\ -nH\ $*
let g:tex_flavor = "latex"

" statusline.
set laststatus=2
set statusline=%t[%{strlen(&fenc)?&fenc:'none'},%{&ff}]%h%m%r%y%=%c,%l/%L

" coloured statusline
if version >= 700
	hi StatusLine term=reverse ctermfg=5 ctermbg=3 gui=bold,reverse
	au InsertEnter * hi StatusLine term=reverse ctermfg=4 gui=undercurl guisp=blue
	au InsertLeave * hi StatusLine term=reverse ctermfg=5 gui=bold,reverse
endif

" Word count
command! -count=0 -nargs=0 WC <count>,$w ! wc -w
command! -range=% -nargs=0 WC <line1>,<line2>w ! wc -w

" Folds {{{
set foldmethod=marker          " Fold based on marker
set foldnestmax=3              " Deepest fold is 3 levels
set foldenable               " Dont fold by default
set foldopen=block,hor,insert  " Which commands trigger autounfold
set foldopen+=jump,mark
set foldopen+=percent,search
set foldopen+=quickfix,tag,undo
" }}}

" Completion {{{
set completeopt=longest,menuone
set wildmenu                            " C-n and C-p scroll through matches
set wildmode=longest:full,full          " Show completions on first <TAB> and
                                        " start cycling through on second <TAB>
"stuff to ignore when tab completing
set wildignore=*.o,*.obj                " object files
set wildignore+=*.class                 " Java class files
set wildignore+=*.pyc                   " python compiled files
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
colorscheme leo
hi Normal ctermbg=NONE
