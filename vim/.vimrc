" ---- Vundle {{{
set nocompatible              " be iMproved, required
filetype off                  " required <<========== We can turn it on later

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" <============================================>
"Plugin 'lyuts/vim-rtags'
Plugin 'scrooloose/nerdtree'        " File explorer
Plugin 'ctrlpvim/ctrlp.vim'         " Fuzzy file finder
Plugin 'tpope/vim-commentary.git'   " Comment/Uncomment
Plugin 'junegunn/goyo.vim'          " Distraction free writing
Plugin 'Valloric/YouCompleteMe.git' " Auto completion   
" <============================================>
" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line
" Put the rest of your .vimrc file here
" }}}

" ---- Powerline {{{ 
" Set up PowerLine when installed via deb package
python3 from powerline.vim import setup as powerline_setup
python3 powerline_setup()
python3 del powerline_setup
set laststatus=2    " Always display the statusline in all windows
set showtabline=2   " Always display the tabline, even if there is only one tab
set noshowmode      " Hide the default mode text (e.g. -- INSERT -- below the statusline)
set t_Co=256        " Use 256 colors (Use this setting only if your terminal supports 256 colors)
" }}}

syntax on
filetype on

colorscheme slate
hi Search ctermbg=Yellow ctermfg=Black
hi MatchParen ctermfg=Black ctermbg=Yellow 

let mapleader=" "

set wildmenu
set wildmode=longest:list,full
set showcmd
" http://vim.wikia.com/wiki/Indenting_source_code
set tabstop=4       " Tab set to 4 wide
set shiftwidth=4    " Size of an 'indent'
set expandtab       " Tab expands to spaces
set autoindent
set smarttab
set wrap            " Wrap words visually
set linebreak       " Don't split words in a word wrap
set textwidth=0     " Prevent Vim from automatically inserting line breaks
set wrapmargin=0    " The number of spaces from right margin to wrap from. 0 disables newline
set nolist          " list shows hidden characters such as newline. 
set number          " Show line numbers
set relativenumber  " Show line numbers relative to the cursor position
set mouse=a         " Enable mouse click to move cursor
set showmatch       " Show matching perenthesis
set backspace=indent,eol,start " Allow backspace in insert mode
set history=50      " Default 8

let g:ycm_global_ycm_extra_conf = "~/.vim/.ycm_extra_conf.py"
nnoremap <F2> :YcmCompleter GoTo<CR>
nnoremap <leader>gl :YcmCompleter GoToDeclaration<CR>
nnoremap <leader>gf :YcmCompleter GoToDefinition<CR>
nnoremap <leader>gg :YcmCompleter GoToDefinitionElseDeclaration<CR>

set hidden
nmap <leader>T :enew<cr>
nmap <leader>l :bnext<cr>
nmap <leader>h :bprevious<cr>
nmap <leader>bq :bp <BAR> bd #<cr>
nmap <leader>bl :<cr>

" ---- Folding {{{
" enable folding; http://vim.wikia.com/wiki/Folding
set foldmethod=marker

"}}}

" Set darker background after 80 chars (https://stackoverflow.com/a/13731714)
"let &colorcolumn=join(range(81,999),",")
"highlight ColorColumn ctermbg=235 guibg=#2c2d27

" ---- Search {{{ 
set ignorecase
set smartcase
" Highligting search
set hlsearch
set incsearch
vnoremap // y/<C-R>"<CR>

" Esc to remove search findings
nnoremap <silent><esc> :noh<return><esc>
nnoremap <esc>^[ <esc>^[
" }}}

" Scrolling
nnoremap <C-e> 2<C-e>
nnoremap <C-y> 2<C-y>
"map <ScrollWheelUp> <C-Y>
"map <ScrollWheelDown> <C-E>

" I need to break my habit...
" Disable Arrow keys in Normal mode
map <up> <nop>
map <down> <nop>
map <left> <nop>
map <right> <nop>
" Disable Arrow keys in Insert mode
imap <up> <nop>
imap <down> <nop>
imap <left> <nop>
imap <right> <nop>

nnoremap <C-j> :m .+1<CR>==
nnoremap <C-k> :m .-2<CR>==
inoremap <C-j> <Esc>:m .+1<CR>==gi
inoremap <C-k> <Esc>:m .-2<CR>==gi
vnoremap <C-j> :m '>+1<CR>gv=gv
vnoremap <C-k> :m '<-2<CR>gv=gv

" Toggle between relative and absolute numbering
nnoremap <silent><C-l> :set rnu!<CR>

" Map ctrl+c to copy to system clipboard when in visual mode
" Requires gvim(arch?) or vim-gui-common (Debian)
vnoremap <C-c> "*y :let @+=@*<CR>:echo "Copied to system clipboard"<cr>

" Function keys
map <silent> <F4> :call ToggleBetweenHeaderAndSourceFile()<CR>
map <F9> :setlocal spell! spelllang=en,sv<CR>
map <F10> :Goyo<CR>
inoremap <F10> <esc>:Goyo<CR>a
" <F11> for fullscreen
noremap <F12> :NERDTreeToggle<CR>

" Build/run
autocmd FileType python nnoremap <buffer> <F5> :w<CR>:exec '!python3' shellescape(@%, 1)<CR>
autocmd FileType r nnoremap <buffer> <F5> :w<CR>:exec '!Rscript' shellescape(@%, 1)<CR>

" Snippets
autocmd FileType cpp inoremap ;co std::cout<Space><<<Space>f<Space><<<Space> std::endl;<Esc>Ffcw

function! ToggleBetweenHeaderAndSourceFile()
  let bufname = bufname("%")
  let ext = fnamemodify(bufname, ":e")
  if ext == "h"
    let ext = "cpp"
  elseif ext == "cpp"
    let ext = "h"
  else
    return
  endif
  let bufname_new = fnamemodify(bufname, ":r") . "." . ext
  let bufname_alt = bufname("#")
  if bufname_new == bufname_alt
    execute ":e#"
  else
    execute ":e " . bufname_new
  endif
endfunction

function! s:goyo_leave()
    "highlight ColorColumn ctermbg=235 guibg=#2c2d27
endfunction

autocmd! User GoyoLeave nested call <SID>goyo_leave()
