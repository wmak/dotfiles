" Plugins will be downloaded under the specified directory.
call plug#begin('~/.vim/plugged')
" Declare the list of plugins.
Plug 'dense-analysis/ale'
Plug 'yggdroot/indentline'
Plug 'airblade/vim-gitgutter'
Plug 'timsu92/vim-easymotion'
Plug 'vim-test/vim-test'
Plug 'folke/tokyonight.nvim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'tmhedberg/SimpylFold'
" Git
Plug 'farmergreg/vim-lastplace'
Plug 'tpope/vim-fugitive'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'pappasam/coc-jedi', { 'do': 'yarn install --frozen-lockfile && yarn build' }
Plug 'lewis6991/gitsigns.nvim'
Plug 'romgrk/barbar.nvim'
Plug 'chentoast/marks.nvim'
Plug 'psf/black'
Plug 'neovim/nvim-lspconfig'
Plug 'navarasu/onedark.nvim'
Plug 'rose-pine/neovim'
" List ends here. Plugins become visible to Vim after this call.
call plug#end()

" fzf alias
cnoreabbrev ~~ FZF

let g:node_host_prog = system('volta which neovim-node-host | tr -d "\n"')

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
let g:airline_extensions = []

" Jump back to last location on file open

" show line numbers
set number

let g:ale_linters = {
\   'python': ['flake8', 'mypy'],
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
inoremap <M-b> <S-Left>
inoremap <M-f> <S-Right>

" Bind F1 to toggle folding
nnoremap <F1> :set foldenable!<cr>
set foldmethod=syntax
let javaScript_fold=1

" remap <F3> to show whitespace
nnoremap <F3> :set list!<cr>

" TestNearest
nnoremap <F4> :w<cr>:TestNearest<cr>
nnoremap <S-F4> :w<cr>:TestLast<cr>
nnoremap <F5> :w<cr>:Mypy<cr>
let test#strategy = "neovim"
let test#neovim#term_position = "vert botright"
let test#python#pytest#options = '--disable-pytest-warnings -p no:warnings'
if has('nvim')
  tmap <C-k> <C-\><C-n>
endif

" Open fzf
nnoremap <C-O> :GFiles<cr>
function! RipgrepFzf(query, fullscreen)
  let command_fmt = 'rg --ignore-file ~/.gitignore --glob="!static/" --column --line-number --no-heading --color=always --smart-case -- %s || true'
  let initial_command = printf(command_fmt, shellescape(a:query))
  let reload_command = printf(command_fmt, '{q}')
  let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
  call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
endfunction
function! RipgrepFzfStatic(query, fullscreen)
  let command_fmt = 'rg --ignore-file ~/.gitignore --column --line-number --no-heading --color=always --smart-case -- %s static || true'
  let initial_command = printf(command_fmt, shellescape(a:query))
  let reload_command = printf(command_fmt, '{q}')
  let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
  call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
endfunction

set mouse=

" Don't yank when you paste
xnoremap p pgvy

" Search non static folders
command! -nargs=* -bang RG call RipgrepFzf(<q-args>, <bang>0)
nnoremap <C-I> :RG<cr>

command! -nargs=* -bang RGS call RipgrepFzfStatic(<q-args>, <bang>0)
nnoremap <C-J> :RGS<cr>

" Easier entry to commmand-mode
noremap ; :

" rebing backslash and bar for F and T
noremap <BSLASH> ;
noremap <BAR> ,

" Viewport laziness
noremap <S-Up> <C-W>k
noremap <S-Down> <C-W>j
noremap <C-k> <C-W>h
noremap <C-m> <C-W>l

nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gr <Plug>(coc-references)

" Make scrolling better
nmap <silent> <C-u> <C-u>zz
nmap <silent> <C-d> <C-d>zz
set scrolloff=3

" Leader binding
let mapleader           = ' '

" EasyMotion
map <leader> <Plug>(easymotion-prefix)

" Indent
map <leader>i :IndentLinesToggle<cr>

" buffer management
let mapleader           = ','
nnoremap <leader>l :ls<cr>:b<space>
nnoremap <leader>b :BufferPick<cr>
nnoremap <leader>p :BufferPrevious<cr>
nnoremap <leader>n :BufferNext<cr>
nnoremap <leader>c :BufferClose<cr>
nnoremap <leader>d :BufferPickDelete<cr>
nnoremap <leader>s :BufferOrderByBufferNumber<cr>
nnoremap <leader>< :BufferScrollLeft 50<cr>
nnoremap <leader>> :BufferScrollRight 50<cr>
let mapleader           = ' '

" Ignore swp and pyc files
let g:netrw_list_hide= '.*\.swp$,.*\.pyc'

" When there's a match highlight all matches
set hlsearch

" statusline.
set laststatus=2
set statusline=%t[%{strlen(&fenc)?&fenc:'none'},%{&ff}]%h%m%r%y%=%c,%l/%L

" Persistent History
if has("persistent_undo")
    set undodir=~/.vim/backups
    set undofile
endif

let g:indentLine_char_list = ['|', '¦', '┆', '┊']

" Colour theme
set t_Co=256
set t_ut=
let g:onedark_config = {
    \ 'style': 'cool',
\}
colorscheme rose-pine-moon
set termguicolors
hi Normal ctermbg=NONE
hi Blamer guifg=lightgrey
hi NormalFloat ctermfg=LightGrey

" Barbar
let g:barbar_auto_setup = v:false " disable auto-setup
lua << EOF
require'barbar'.setup {
  icons = {
    button = '',
    filetype = {enabled = false},
    pinned = {button = '', filename = true},
    separator = { left = '|' },
    inactive = {
      separator = {
        left = '|'
      }
    }
  },
  maximum_padding = 0,
  minimum_padding = 0,
  letters = 'arstneioARSTNEIOdhDHzxcvm,./ZXCVM<>?',
}
EOF

" Marks
lua << EOF
require'marks'.setup {
  signs = true
}
EOF

" Language Servers
" require'lspconfig'.tsserver.setup{}
" vim.lsp.config("jedi_language_server").jedi_language_server.setup{}
lua << EOF
EOF
let g:coc_global_extensions = ['coc-json', 'coc-git', 'coc-jedi', 'coc-tslint-plugin']

" run black on close
:autocmd BufWritePost *.py silent! :Black
