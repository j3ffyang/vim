" https://realpython.com/vim-and-python-a-match-made-in-heaven/#vim-extensions

set nocompatible              " required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" add all your plugins here (note older versions of Vundle
" used Bundle instead of Plugin)

" ...

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

set splitbelow
set splitright

"split navigations
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Enable folding
set foldmethod=indent
set foldlevel=99

" Enable folding with the spacebar
nnoremap <space> za

Plugin 'tmhedberg/SimpylFold'
let g:SimpylFold_docstring_preview=1

au BufNewFile,BufRead *.py
    \ set tabstop=4
    \ set softtabstop=4
    \ set shiftwidth=4
    \ set textwidth=79
    \ set expandtab
    \ set autoindent
    \ set fileformat=unix

" au BufNewFile,BufRead *.js, *.html, *.css
"     \ set tabstop=2
"     \ set softtabstop=2
"     \ set shiftwidth=2

" auto-indentation
Plugin 'vim-scripts/indentpython.vim'

" flagging unnecessary whitespace
au BufRead,BufNewFile *.py,*.pyw,*.c,*.h match BadWhitespace /\s\+$/

" utf-8 support
set encoding=utf-8

" auto-complete
Bundle 'Valloric/YouCompleteMe'

" The first line ensures that the auto-complete window goes away when 
" you’re done with it, and the second defines a shortcut for goto 
" definition.
let g:ycm_autoclose_preview_window_after_completion=1
map <leader>g  :YcmCompleter GoToDefinitionElseDeclaration<CR>

" syntax checking/ highlighting
Plugin 'vim-syntastic/syntastic'
Plugin 'nvie/vim-flake8'

let python_highlight_all=1
syntax on

" color schemes
Plugin 'jnurmine/Zenburn'
Plugin 'altercation/vim-colors-solarized'

if has('gui_running')
  set background=dark
  colorscheme solarized
else
  colorscheme zenburn
endif

" pressing F5 to switch theme > love this one
call togglebg#map("<F5>")

" file browsing
Plugin 'scrooloose/nerdtree'
" file browsing, using tabs
Plugin 'jistr/vim-nerdtree-tabs'

" super searching
Plugin 'kien/ctrlp.vim'

set nu

" git integration
Plugin 'tpope/vim-fugitive'

" powerline
Plugin 'Lokaltog/powerline', {'rtp': 'powerline/bindings/vim/'}

" system clipboard
set clipboard=unnamed

" vim in the shell 
" set editing-mode vi
