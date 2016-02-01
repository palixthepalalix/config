" vimrc
"Alix Cook 

" Vundle setup
set nocompatible
filetype off

" random
set backspace=2         " This makes the backspace key function like it does in other programs.

set showcmd             " Shows incomplete commands

" appearance
set number " Enables relative line numbering
set ruler          " Shows cursor position in bottom bar
set scrolloff=3    " leaves 3 spaces between top/bottom and cursor
set showmatch      " Highlights matching brackets in programming languages

" tabs
set expandtab
set tabstop=4       " Spaces instead of tabs
set shiftwidth=4
set smarttab        " Improves tabbing
set shiftwidth=4    " Assists code formatting

" folding
set foldnestmax=5       " deepest fold in 10 levels
set nofoldenable        " don't fold by default
set foldlevel=1

" searching
set hlsearch    " highlight search matches
set incsearch   " searches as you type
set ignorecase  " case insensitive searching
set smartcase   " searches w/ case if there's a capital letter
" redraw clears highlights at the same time
nnoremap <C-L> :nohl<CR><C-L>

" indenting
set autoindent  "If you're indented, new lines will also be indented
set smartindent  "Automatically indents lines after opening a bracket in programming languages

" colors
syntax on           "Enables syntax highlighting for programming languages
if $TERM =~ '256color'
    set t_Co=256
elseif $TERM =~ '^xterm$'
    set t_Co=256
endif

" color choices
" colorscheme zephyr
" colorscheme jellybeans
colorscheme mopkai
highlight Normal guibg=black guifg=white
set background=dark

set synmaxcol=200                   " stop highlighting after 200 characters

" markdown syntax
au BufRead,BufNewFile *.md set filetype=markdown
" coffee syntax
au BufRead,BufNewFile *.coffee set filetype=coffee
" less syntax
au BufRead,BufNewFile *.less set filetype=less
" golang stuff
au BufRead,BufNewFile *.go set filetype=go
" ocaml
au BufRead,BufNewFile *.ml,*.mli compiler ocaml
set rtp+=/usr/local/share/ocamlmerlin/vim
autocmd FileType ocaml source /Users/natebrennand/.opam/system/share/vim/syntax/ocp-indent.vim


" use filetype specific vim settings
" settings located in ~/.vim/after/ftplugin/
filetype indent plugin on

" show cursor position
set cursorline

" window stuff
" set winwidth=80     " default to a width of 80 columns
" no equalalways

" toggle pasting with f11
set pastetoggle=<F11>

" key remappings
" commands: don't use shift when save/quit/etc ";" --> ":" (in command mode)
noremap ; :
" windows: rmap s to ctrl-W
noremap s <C-W>
" navigation: move by displayed lines, not real lines
noremap j gj

noremap k gk

" clipboard stuff
" cutting
vmap <C-x> :!pbcopy<CR>
" copying
vmap <C-C> :w !pbcopy<CR><CR>

" spell check w/ f5
map <F5> :setlocal spell! spelllang=en_us<CR>

" adding special characters
set listchars=eol:¬,tab:>-,trail:█,extends:>,precedes:-
set list

function! Tab_Or_Complete()
        if col('.')>1 && strpart( getline('.'), col('.')-2, 3) =~ '^\w'
            return "\<C-N>"
        else
            return "\<Tab>"
        endif
endfunction
:inoremap <Tab> <C-R>=Tab_Or_Complete()<CR>
:set dictionary="/usr/dict/words"

