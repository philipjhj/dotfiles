" Following things would be nice to add:
" - Move up and down between sections (# %%) for python files
" - change package management to 'Dein', see https://github.com/Shougo/dein.vim
" - Plugins:
"       - https://github.com/rhysd/vim-grammarous
"       - https://github.com/dense-analysis/ale
"
" Use Vim settings, rather than Vi settings(much better!).
" This must be first, because it changes other options as a side effect.
" {{{ init
set nocompatible
let mapleader=","
let maplocalleader=","

filetype off                  " required

"}}}1

"{{{1 Plugins 
"{{{2 Vundle 
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

" Archived Plugins
" Plugin 'severin-lemaignan/vim-minimap'
" Python
"Plugin 'reconquest/vim-pythonx'
"Plugin 'python-mode/python-mode'
"Plugin 'davidhalter/jedi-vim'
"Plugin 'wilywampa/vim-ipython'
Plugin 'tell-k/vim-autopep8'
Plugin 'vim-python/python-syntax'
Plugin 'wmvanvliet/jupyter-vim'
"Plugin 'broesler/jupyter-vim'
Plugin 'heavenshell/vim-pydocstring'
Plugin 'tell-k/vim-autoflake'
Plugin 'AndrewRadev/linediff.vim'

" Snippets
Plugin 'MarcWeber/vim-addon-mw-utils'
Plugin 'tomtom/tlib_vim'

" Restructured text
Bundle 'Rykka/riv.vim'
Bundle 'Rykka/InstantRst'

" Markdown
Bundle 'gabrielelana/vim-markdown'

" Focus
Plugin 'junegunn/limelight.vim'
Plugin 'junegunn/goyo.vim'

" LATEX
Plugin 'lervag/vimtex'

" General editing help
Plugin 'tpope/vim-surround' " Make it easy to change inside brackets
Plugin 'Townk/vim-autoclose' " auto closes brackets
Plugin 'beloglazov/vim-online-thesaurus' " Work lookup for synonyms and definitions
Plugin 'vim-scripts/Align'
Plugin 'jlanzarotta/bufexplorer'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'dpelle/vim-LanguageTool' " Grammar checker 
Plugin 'ycm-core/YouCompleteMe'

" All of your Plugins must be added before the following line
call vundle#end()            " required

"{{{2 Plug
" Specify a directory for plugins
" - For Neovim: stdpath('data') . '/plugged'
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')

" Make sure you use single quotes
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() } }
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" Initialize plugin system
call plug#end()
"}}}2
"}}}1

" {{{1 Folds
" Suggestion to use folding for managing a large .vimrc
" found here: https://vi.stackexchange.com/a/24984/19751
" use 1/2 after the 3 curly brackets for level 1/2 folds

set foldmethod=marker
set foldcolumn=1

augroup match_folds
    autocmd!
    " VimEnter handles at start up, WinNew for each window created AFTER startup.
    " Regex matches { { { with an empty group in the middle so that vim does
    " not create a fold in this code, then either a 1 or 2 then a space. Then
    " zs is the start of the match which is the rest of the line then ze is
    " the end of the match. Refer to :help pattern-overview
    autocmd VimEnter,WinNew * let w:_foldlevel1_id = matchadd('_FoldLevel1', '{{\(\){1\ \zs.\+\ze', -1)
    autocmd VimEnter,WinNew * let w:_foldlevel2_id = matchadd('_FoldLevel2', '{{\(\){2\ \zs.\+\ze', -1)
augroup END

hi Folded               guifg=#FF9999 guibg=#005050 gui=bold,italic
hi FoldColumn           guifg=#FF9999 guibg=#005050 gui=bold
hi _FoldLevel1          guifg=#005050 guibg=#FF9999 gui=bold,italic
hi _FoldLevel2          guifg=#003030 guibg=#CC8080 gui=bold,italic
" }}}1

" {{{1 rest (needs to be organized)
let g:pydocstring_doq_path = '/media/programs/miniconda3/envs/py37/bin/doq'

" Native settings
set expandtab
set tabstop=4


let g:autoflake_remove_all_unused_imports=1
let g:autoflake_remove_unused_variables=1
let g:autoflake_disable_show_diff=1

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
let g:airline#extensions#tabline#show_tabs=0
" Just show the filename(no path) in the tab
let g:airline#extensions#tabline#fnamemod=':t'
let g:airline#extensions#tabline#show_buffers=1
let g:airline#extensions#tabline#show_close_button=0
let g:airline#extensions#tabline#show_splits=0
let g:airline#extensions#tabline#switch_buffers_and_tabs=1

" NERDTree options
map <F2> :NERDTreeToggle<CR>
"autocmd BufEnter * silent! lcd %:p:h

"  # Python Options

"  # Python-Mode options
let g:pymode_run=1
let g:pymode_doc=0
let g:pymode_doc_bind='K'
let g:pymode_indent=1
let g:pymode_folding=1
let g:pymode_run_bind='<leader>r'
let g:pymode_python='python3'
let g:pymode_quickfix_minheight = 3
let g:pymode_quickfix_maxheight = 20
let g:pymode_lint_ignore=""
" Rope support
let g:pymode_rope = 1
let g:pymode_rope_complete_on_dot = 1
let g:pymode_rope_show_doc_bind='<C-d>'
let g:pymode_rope_autoimport = 0

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

let g:vimtex_quickfix_mode=0
let g:tex_flavor = 'latex'

map <F3> :VimtexCompileSS<CR>

" enable youcompleteme for vimtex
if !exists('g:ycm_semantic_triggers')
let g:ycm_semantic_triggers = {}
endif
let g:ycm_semantic_triggers.tex = g:vimtex#re#youcompleteme



" let g:vimtex_quickfix_ignored_warnings=[
" \'Underfull',
" \'Overfull',
" \'specifier changed to',]

"Automatic Tex Plugin
"let g:tex_flavor = "latex" "ensuring correct highlightning
"let g: atp_tab_map = 1
"let g: no_apt = 1
"let g: atp_Compiler = 'bash'

"}}}1

"{{{1 Custom functions

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

function ToggleWrap()
 if (&wrap == 1)
   set nowrap
 else
   set wrap
 endif
endfunction

" Functions to shuffle between prespecified options
function Next_item_from_bracket_list(bracket_list, current_item)
    " Takes a list a:bracket_list like [a,b,c] and identifies the item following
    " the a:current_item
        let end_pos=matchend(a:bracket_list, a:current_item)
        let char_match=strpart(a:bracket_list,end_pos,1)

        if char_match == ','
            let remind=matchstr(strpart(a:bracket_list,end_pos),', \w*')
            let new_opt=strpart(remind, 2)
        elseif char_match == ']'
            let remind=matchstr(a:bracket_list,'[\w*')
            let new_opt=strpart(remind, 1)
        endif
        
        return new_opt
endfunction

function ToggleOpt()
    let line = getline('.') "line under cursor

    let old_opt_value=strpart(matchstr(line, '=\w*'),1)
    let opt_list=matchstr(line, '\[.*\]')

    let new_opt = Next_item_from_bracket_list(opt_list, old_opt_value)

    let new_line = substitute(line,old_opt_value, new_opt, '')
    call setline('.', new_line)
endfunction

"}}}1

" {{{1 Mappings 

"{{{2 Native Functionality

"Edit and source vimrc easily
nnoremap <leader>ev :vsplit $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>


map <F5> :cprev<CR>
map <F6> :cnext<CR>
map <F4> :clist<CR>

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

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" Tabs key bindings
map <C-l> :tabnext<CR>
map <C-h> :tabprevious<CR>

" Buffer key bindings
map <C-k> :bnext<CR>
map <C-j> :bprevious<CR>
"nnoremap <A-PageUp> :bnext<CR>
"nnoremap <A-PageDown> :bprevious<CR>

" Move lines up or down
nnoremap <A-j> :m .+1<CR>==
nnoremap <A-k> :m .-2<CR>==
inoremap <A-j> <Esc>:m .+1<CR>==gi
inoremap <A-k> <Esc>:m .-2<CR>==gi
vnoremap <A-j> :m '>+1<CR>gv=gv
vnoremap <A-k> :m '<-2<CR>gv=gv

"{{{2 MAPS for custom functions
map <F9> :call ToggleWrap()<CR>
map! <F9> ^[:call ToggleWrap()<CR>

vnoremap~y:call setreg('', TwiddleCase(@"), getregtype(''))<CR>gv""Pgv
nnoremap <M-t> :call ToggleOpt()<CR>

"}}}2
"}}}1

"{{{1 Custom Settings

" Errorformat: Begin multiline with pattern './<filename>:<line#>: <message>',
" end multiline with remaining message, and ignore all other patterns
" Looping throught patterns until a match is found(patterns colon seperated)
set efm=%A./%f:%l:\%m,%Z%m,%-G%.%
syntax on
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
"set wildmenu
"set wildmode=full


" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif

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

" Setup for recognizing Alt as a modifier when using vim in the terminal
" from here:
" https://stackoverflow.com/questions/6778961/alt-key-shortcuts-not-working-on-gnome-terminal-with-vim
let c='a'
while c <= 'z'
  exec "set <A-".c.">=\e".c
  exec "imap \e".c." <A-".c.">"
  let c = nr2char(1+char2nr(c))
endw

set timeout ttimeoutlen=50

" External files
source ~/.vim/surround-function.vim "https://gist.github.com/romgrk/35186f3b5a71a7d89b2229b6f73e4f32 

" Spell checking
set nospell 
set spelllang=en
set spellfile=~/.vim/spell/en.utf-8.add

autocmd! User GoyoEnter Limelight
autocmd! User GoyoLeave Limelight!

let g:languagetool_jar='$HOME/langtool/LanguageTool-5.0/languagetool-commandline.jar'
