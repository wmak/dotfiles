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

" Use qq to escape
inoremap qq <ESC>

" enters paste mode on F2
set pastetoggle=<F2>

" remap <F3> to show whitespace
nnoremap <F3> :set list!<cr>

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

" go fmt
nnoremap <F4> :w<cr>:!go fmt % <cr>:edit<cr>

" Word count
command! -count=0 -nargs=0 WC <count>,$w ! wc -w
command! -range=% -nargs=0 WC <line1>,<line2>w ! wc -w
