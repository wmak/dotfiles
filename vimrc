" ignore vi compatibility
set nocompatible

" better brace matching
runtime macros/matchit.vim

" syntax highlighting
syntax on
filetype on
filetype plugin on
filetype indent on

" show line numbers
set number

" tell vim how many columns a tab is
set tabstop=4

" show whitespace characters
set listchars=eol:$,tab:>-,trail:~,extends:>,precedes:<
set list

" tell vim I have a dark background
set bg=dark

" enters paste mode on F2
set pastetoggle=<F2>

" remap qq to be the escape 
inoremap qq <ESC>

" remap <F3> to show whitespace
nnoremap <F3> :set list!<cr>
