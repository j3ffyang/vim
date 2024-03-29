# Turn VIM into Python IDE
<img src="./imgs/vim-logo.svg">

## Background
I've tried several editors for writing __Python__, such as VSCode, Atom, Sublime, PyCharm, and even Bluefish. The issues I experienced bothered me, like Atom too fat, Sublime complicated plugin configuration, PyCharm uncertain runtime path... Eventually I decided to stay with my love, ```vi``` and ```vim``` that I've used for almost 20 years.

There are multiple ways to configure VIM as Python IDE, through ```vundle```, ```pip3 install```, then I figured to have plugins managed by ```git``` and ```vundle```, the plugin manager. Therefore I write this document.

Notes:
- This doc is written with Python3, not tested with Python2
- Python's plugin are very various and many. I choose some as my personal experience only
- Using Fedora 36 with default ```vim```, at the moment when writing this doc

Personally I think that _the best practice to Enable VIM as Python IDE_ is https://realpython.com/vim-and-python-a-match-made-in-heaven/ with credits. And I also fixed 2 defects in configuration, supplied by RealPython.com, with comment starting with `Jeff's Fix`

My current ```~/.vimrc``` can be downloaded [./vimrc](scripts/vimrc_vundle)

## VIM Pre-requisite

```sh
vim --version
```

Supposedly you can see
```sh
VIM - Vi IMproved 8.0 (2016 Sep 12, compiled Sep 30 2017 18:21:38)
...
Huge version with GTK3 GUI.  Features included (+) or not (-):
+acl             +file_in_path    +mouse_sgr       +tag_old_static
...
+conceal         +libcall         +profile         +viminfo
+cryptv          +linebreak       -python          +vreplace
+cscope          +lispindent      +python3         +wildignore
```

that indicates this pre-built ```vim``` (version 8.0) supports ```python3```, but not ```python2```. Weird but this is default from _Debian Stretch 9.6_, with ```vim-tiny``` completely removed

And verify in vim
```py
:python import sys; print(sys.version)
```

## Install Plugins and Setup

#### `vundle`

```sh
git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
```

#### `~/.vimrc`

Touch `~/.vimrc` and copy the following into it. __Remember__ to execute `:wq` and `:PluginInstall` each time after adding new plugin(s) in `~/.vimrc`

```sh
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

Plugin 'tmhedberg/SimpylFold'
let g:SimpylFold_docstring_preview=1


" Auto-indentation
Plugin 'vim-scripts/indentpython.vim'


" Jedi-vim
Plugin 'davidhalter/jedi-vim'


" Auto-complete
Plugin 'Valloric/YouCompleteMe'
let g:ycm_autoclose_preview_window_after_completion=1
map <leader>g  :YcmCompleter GoToDefinitionElseDeclaration<CR>


" Syntax checking/ highlighting
Plugin 'vim-syntastic/syntastic'
Plugin 'nvie/vim-flake8'
let python_highlight_all=1
syntax on


" Color schemes
Plugin 'jnurmine/Zenburn'
Plugin 'altercation/vim-colors-solarized'


" File browsing
Plugin 'scrooloose/nerdtree'
Plugin 'jistr/vim-nerdtree-tabs'
let NERDTreeIgnore=['\.pyc$', '\~$'] "ignore files in NERDTree


" Super searching
Plugin 'kien/ctrlp.vim'


" Git integration
Plugin 'tpope/vim-fugitive'


" Powerline
Plugin 'Lokaltog/powerline', {'rtp': 'powerline/bindings/vim/'}


" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required


" Color scheme
if has('gui_running')
  set background=dark
  colorscheme solarized
else
  colorscheme zenburn
endif


" Split Layouts
set splitbelow
set splitright

" split navigations
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Enable folding
set foldmethod=indent
set foldlevel=99

" Enable folding with the spacebar
nnoremap <space> za

" Jeff's Fix: there must be a "|" to isolate each "set" 
au BufNewFile,BufRead *.py,*.md
    \ set tabstop=4 |
    \ set softtabstop=4 |
    \ set shiftwidth=4 |
    \ set textwidth=79 |
    \ set expandtab |
    \ set autoindent |
    \ set fileformat=unix

" Jeff's Fix: there is NO whitespace between *.js and *.html, etc
au BufNewFile, BufRead *.js,*.html,*.css,*.yml,*.yaml
    \ set tabstop=2 |
    \ set softtabstop=2 |
    \ set shiftwidth=2

" Flagging Unnecessary Whitespace
au BufRead, BufNewFile *.py,*.pyw,*.c,*.h match BadWhitespace /\s\+$/

" UTF-8 Support
set encoding=utf-8
```

#### `YouCompleteMe` plugin

> Reference > https://ycm-core.github.io/YouCompleteMe/#linux-64-bit

Clone the code, then

If you want auto-complete for Go, a pre-requisite is to install `go` and `go-lang`

Or for Python only,

```sh
cd ~/.vim/bundle/YouCompleteMe
git submodule update --init --recursive

python3 install.py
```

#### Auto-Complete

Based on `jedi-vim` and reference to https://github.com/davidhalter/jedi-vim

Clone the code

```sh
git clone --recursive https://github.com/davidhalter/jedi-vim.git ~/.vim/bundle/jedi-vim
```

Then place the following in `~/.vimrc`, execute install with `:PluginInstall`

```yml
Plugin 'davidhalter/jedi-vim'
```

--- 


<!-- 

#### Create directories
Backup the existing ```~/.vimrc``` and ```~/.vim```!!!

```sh
mkdir -p ~/.vim/{autoload,bundle}
```

`bundle` holds all plugins

#### pathogen
> Reference > https://github.com/tpope/vim-pathogen

Simply install

```sh
mkdir -p ~/.vim/autoload ~/.vim/bundle && \
curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim
```

Then add the following at the top of `~/.vimrc`

```sh
execute pathogen#infect()
```

#### vundle

```sh
touch ~/.vimrc
```

```sh
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
```
> Reference > https://github.com/VundleVim/Vundle.vim


Then put the following at the top of ```~/.vimrc```
```sh
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
```

> Tips: make sure all plugins being added before the last stance in ```~/.vimrc```. Read the above.

To enable it, get into ```vim```
```sh
:PluginInstall
```


#### ~~python-mode~~ (removed due to dup'd features)
~~This is a combo that contains lots of feature and submodules. See the details at reference doc > https://github.com/python-mode/python-mode~~

```sh
cd ~/.vim/bundle
git clone https://github.com/python-mode/python-mode.git
cd python-mode
git submodule update --init --recursive
```

#### Auto-Complete
I think this is the most important plugin and makes VIM a _true_ Python IDE

Install `YouComplete` plugin, with following https://github.com/ycm-core/YouCompleteMe#linux-64-bit

```sh
Bundle 'Valloric/YouCompleteMe'

let g:ycm_autoclose_preview_window_after_completion=1
map <leader>g  :YcmCompleter GoToDefinitionElseDeclaration<CR>
```

Save the above in ```~/.vimrc``` then run ```:PluginInstall``` within ```vim```

> Tips: if ```PluginInstall``` running into error, you might need to execute install manually by ```cd ~/.vim/bundle/YouCompleteMe; ./install.py```

Screenshots of _auto-complete_ and display relative _document_ after pressing Tab
<img src="./imgs/autocomplete1.png">

#### File Browsing
We can see the effect from the above screenshot. The files, from left navigation, are double-clickable into editing mode. Very fancy and nice.
```sh
Plugin 'scrooloose/nerdtree'
Plugin 'jistr/vim-nerdtree-tabs'  " use tab

" hide .pyc
let NERDTreeIgnore=['\.pyc$', '\~$'] "ignore files in NERDTree
```

#### Super Searching

Pressing ```Ctrl```+ ```p``` to enable search

```sh
Plugin 'kien/ctrlp.vim'
```

<img src="./imgs/supersearch.png">

To search ```keras``` in all directories

#### Powerline

```sh
Plugin 'Lokaltog/powerline', {'rtp': 'powerline/bindings/vim/'}
```
<img src="./imgs/powerline.png">

Show status and file format

## Other Tweaks without Plugin
#### Split Windows

```sh
set splitbelow
set splitright
```

To enable multiple-views, press ```:sp```, we see

<img src="./imgs/multi_views.png">

Use ```Ctrl``` + ```h``` /```j``` /```k``` /```l``` to switch among windows

```sh
" split navigations
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
```

#### UTF-8 Support
```sh
set encoding=utf-8
```

#### Set line-number
```sh
set nu
```
#### PEP8

```sh
au BufNewFile,BufRead *.py
    \ set tabstop=4 |
    \ set softtabstop=4 |
    \ set shiftwidth=4 |
    \ set textwidth=79 |
    \ set expandtab |
    \ set autoindent |
    \ set fileformat=unix
```

-->
