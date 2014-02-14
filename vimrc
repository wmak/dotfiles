" ignore vi compatibility
set nocompatible

" better brace matching
runtime macros/matchit.vim

" syntax highlighting
syntax on
filetype on
filetype plugin on
filetype indent on

" highlight 81 and onward so 80 is the last valid column
set textwidth=80
set colorcolumn=+1

" show line numbers
set number

" tell vim how many columns a tab is
set tabstop=4
set shiftwidth=4
set smarttab

" show whitespace characters
set listchars=eol:$,tab:>-,trail:~,extends:>,precedes:<

" tell vim I have a dark background
set bg=dark

" enters paste mode on F2
set pastetoggle=<F2>

" remap qq to be the escape 
inoremap qq <ESC>

" remap <F3> to show whitespace
nnoremap <F3> :set list!<cr>
