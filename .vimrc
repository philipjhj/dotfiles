" Use Vim settings, rather than Vi settings(much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

let mapleader=","
let maplocalleader=","

filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'


Plugin 'bling/vim-airline'

set previewheight=25
Plugin 'tpope/vim-fugitive'
Plugin 'airblade/vim-gitgutter'
Plugin 'tpope/vim-rhubarb'
Plugin 'scrooloose/nerdtree'

" Python
Plugin 'python-mode/python-mode'
"Plugin 'davidhalter/jedi-vim'
"Plugin 'wilywampa/vim-ipython'
Plugin 'tell-k/vim-autopep8'


" Snippets
Plugin 'MarcWeber/vim-addon-mw-utils'
Plugin 'tomtom/tlib_vim'

" Restructured text
Bundle 'Rykka/riv.vim'
Bundle 'Rykka/InstantRst'

" LATEX
Plugin 'lervag/vimtex'

" General editing help
Plugin 'tpope/vim-surround' " Make it easy to change inside brackets
Plugin 'Townk/vim-autoclose' " auto closes brackets
Plugin 'beloglazov/vim-online-thesaurus' " Work lookup for synonyms and definitions
Plugin 'vim-scripts/Align'
Plugin 'jlanzarotta/bufexplorer'
Plugin 'kien/ctrlp.vim'


" All of your Plugins must be added before the following line
call vundle#end()            " required

" Native settings
set expandtab
set tabstop=4


" Ultisnips
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"
let g:UltiSnipsListSnippets="<c-tab>"

" Powerline required settings
"set guifont=DejaVu\ Sans\ Mono\ for\ Powerline\ 9
set laststatus=2
set term=xterm-256color
" Airline options

" Tab line with buffers
let g:airline#extensions#tabline#enabled=1
" Just show the filename(no path) in the tab
let g:airline#extensions#tabline#fnamemod=':t'


" NERDTree options
map <F2> :NERDTreeToggle<CR>


"  # Python Options

"  # Python-Mode options
let g:pymode_run=1
"let g:pymode_doc=1
"let g:pymode_doc_bind='B'
let g:pymode_indent=1
let g:pymode_folding=1
let g:pymode_run_bind='<leader>r'
"let g:pymode_rope_show_doc_bind='<C-d>'
let g:pymode_python='python3'
let g:pymode_lint_ignore=""

" Latex Box Options
"let g:LatexBox_viewer='okular'

" Ctrl-P settings
let g:ctrlp_working_path_mode='ra'

" Fugitive
"set statusline=%<%f\%h%m%r%{fugitive#statusline()}%=%-14.(%l,%c%V%)\%P
nmap <leader>gs :Gstatus<CR>

" vimtex options
let g:vimtex_view_general_viewer='okular'
let g:vimtex_view_general_options='--unique @pdf\#src:@line@tex'
let g:vimtex_view_general_options_latexmk='--unique'

let g:vimtex_quickfix_mode=2

map <F3> :VimtexCompileSS<CR>

" Errorformat: Begin multiline with pattern './<filename>:<line#>: <message>',
" end multiline with remaining message, and ignore all other patterns
" Looping throught patterns until a match is found(patterns colon seperated)
set efm=%A./%f:%l:\%m,%Z%m,%-G%.%

map <F5> :cprev<CR>
map <F6> :cnext<CR>
map <F4> :clist<CR>

let g:vimtex_quickfix_ignored_warnings=[
\'Underfull',
\'Overfull',
\'specifier changed to',]

"Automatic Tex Plugin
syntax on
"let g:tex_flavor = "latex" "ensuring correct highlightning
"let g: atp_tab_map = 1
"let g: no_apt = 1
"let g: atp_Compiler = 'bash'


" Text folding
"- save automatic
autocmd BufWinLeave *.* mkview
autocmd BufWinEnter *.* silent loadview

" avoid navigating to quickfix buffer with: bnext /: bprev
" (https: // stackoverflow.com/questions/28613190/exclude-quickfix-buffer-from-bnext-bprevious)
augroup qf
    autocmd!
    autocmd FileType qf set nobuflisted
augroup END

"<< << < ----------- MY KEY MAPPINGS - ---------->>>>>

"Insert Time Stamp
nnoremap <F5> "=strftime("%FT%T%z")<CR>P
inoremap <F5> <C-R>=strftime("%FT%T%z")<CR>

" to move inside wrapped lines
"map j gj
"map k gk

" Save map
nmap <C-s> :update<CR>

" Inset new lines in normal mode
" nnoremap <S-CR> <S-O><Esc> " Doesnt work in terminal vim
nnoremap <CR> o<Esc>

" Map ESC in insert mode
inoremap jk <Esc>

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file
endif
set history=500		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching

set relativenumber
set number
set wildmenu

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif

filetype plugin indent on
syntax on

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  " Also don't do it when the mark is in the first line, that is the default
  " position when opening a file.
  autocmd BufReadPost *
    \ if line("'\"")>1&&line("'\"")<=line("$")|
    \   exe "normal! g`\""|
    \ endif

  augroup END

else

  set autoindent		" always set autoindenting on

endif " has("autocmd")

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r + +edit  # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif



" Tabs key bindings
map <C-l> :tabnext<CR>
map <C-h> :tabprevious<CR>

" Buffer key bindings
map <C-k> :bnext<CR>
map <C-j> :bprevious<CR>
"nnoremap <A-PageUp> :bnext<CR>
"nnoremap <A-PageDown> :bprevious<CR>


" Capitalization of regions
"
function! TwiddleCase(str)
  if a:str==#toupper(a:str)
    let result=tolower(a: str)
  elseif a:str==#tolower(a:str)
    let result=substitute(a:str,'\(\<\w\+\>\)','\u\1','g')
  else
    let result=toupper(a:str)
  endif
  return result
endfunction
vnoremap~y:call setreg('', TwiddleCase(@"), getregtype(''))<CR>gv""Pgv


" Move lines up or down
nnoremap <s-j> :m.+1<CR>==
nnoremap <s-k> :m.-2<CR>==
" inoremap <s-j> <Esc>:m.+1<CR>==gi
" inoremap <s-k> <Esc>:m.-2<CR>==gi
vnoremap <s-k> :m'<-2<CR>gv=gv
vnoremap <s-j> :m'>+1<CR>gv=gv
