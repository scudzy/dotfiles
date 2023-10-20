"" set lines=55 100
"" set columns=100
"" set guioptions-=T

set t_Co=256
syntax enable

set ruler
set autoindent
"" set hlsearch
set incsearch
set ignorecase
set smartcase
set tabstop=4
set shiftwidth=4
set cursorline
set foldmethod=marker
set fen

set shiftround

colorscheme atom-dark
set gfn=MesloLGS\ NF\ 11

nmap <C-N><C-N> :set invnumber<CR>
nmap <C-S> :silent noh<CR>
set number
set numberwidth=4

hi LineNr guibg=grey10 guifg=grey30
hi Folded guibg=#1d1d1d guifg=#808080 gui=none

set enc=utf-8
set mousehide

"" let g:easytags_cmd = '/usr/local/bin/ctags'
"" let g:easytags_always_enabled = 1
"" set tags=./.tags;,~/.vimtags

"" annoying shift mistakes
cmap W w

"" set up syntax completion
filetype plugin on
imap <C-Tab> <C-x><C-o>

"" custom syntax highlighting rules
filetype on
au BufNewFile,BufRead *.less set filetype=less

"" stop cursor blinking
set guicursor+=n-v-c:blinkon0
