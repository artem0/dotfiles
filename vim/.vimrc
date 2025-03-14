" Install Pathogen plugin manage
let pathogen_path = expand('~/.vim/autoload/pathogen.vim')
if !filereadable(pathogen_path)
    echo "Installing Pathogen"
    silent !mkdir -p ~/.vim/autoload
    silent !curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim
endif

execute pathogen#infect()
call pathogen#helptags()

" Vim-plug initialization

let vim_plug_just_installed = 0
let vim_plug_path = expand('~/.vim/autoload/plug.vim')
if !filereadable(vim_plug_path)
    echo "Installing Vim-plug"
    silent !mkdir -p ~/.vim/autoload
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    let vim_plug_just_installed = 1
endif

" Manually load vim-plug the first time
if vim_plug_just_installed
    :execute 'source '.fnameescape(vim_plug_path)
endif

" Obscure hacks done

" Activate plugins
call plug#begin('~/.vim/plugged')

" Override configs by directory 
Plug 'arielrossanigo/dir-configs-override.vim'
" Better file browser
Plug 'scrooloose/nerdtree'
Plug 'jistr/vim-nerdtree-tabs', { 'on': 'NERDTreeTabsToggle' }
Plug  'tiagofumo/vim-nerdtree-syntax-highlight'
" Zen coding
Plug 'mattn/emmet-vim'
" Tab list panel
Plug 'kien/tabman.vim'
" Airline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
" Terminal Vim with 256 colors colorscheme
Plug 'fisadev/fisa-vim-colorscheme'
" Consoles as buffers
Plug 'rosenfeld/conque-term'
" Autoclose
Plug 'Townk/vim-autoclose'
" Indent text object
Plug 'michaeljsmith/vim-indent-object'
" Indentation based movements
Plug 'jeetsukumaran/vim-indentwise'
" Python autocompletion, go to definition.
" Snippets manager (SnipMate), dependencies, and snippets repo
Plug 'honza/vim-snippets'
" Automatically sort python imports
" Window chooser
Plug 't9md/vim-choosewin'
" Python and other languages code checker
Plug'dense-analysis/ale'
" Paint css colors with the real color

" It always activate the relative numbering every time you go to normal mode,
" author refuses to add a setting to avoid that
" Plug 'myusuf3/numbers.vim'

" Plugins from vim-scripts repos:
" XML/HTML tags navigation
Plug 'vim-scripts/matchit.zip'
" Gvim colorscheme
Plug 'vim-scripts/Wombat'
" Yank history navigation
Plug 'vim-scripts/YankRing.vim'

" :PlugInstall and PlugUpdate will clone fzf in ~/.fzf and run the install script
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" Git wrapper, jump from one hunk to the next in the current buffer: ]c and [c
" preview, stage, undo hunks with <leader>hp, <leader>hs, and <leader>hu
Plug 'airblade/vim-gitgutter'

" Color schemas
Plug 'arcticicestudio/nord-vim'
Plug 'liuchengxu/space-vim-dark'
Plug 'whatyouhide/vim-gotham'
Plug 'keith/parsec.vim'
Plug 'joshdick/onedark.vim'
Plug 'morhetz/gruvbox'

" <Leader><Leader>w | b - to trigger the word motion | backwards
" <Leader><Leader>e | ge - to trigger the end of words | backwards
" <Leader><Leader>j | k - to trigger the lines below | backwards
" <Leader><Leader>so - looking for an 'o'
" https://www.barbarianmeetscoding.com/boost-your-coding-fu-with-vscode-and-vim/moving-even-faster-with-vim-sneak-and-easymotion/
Plug 'easymotion/vim-easymotion'

Plug 'haya14busa/incsearch.vim'
Plug 'yegappan/mru'
Plug 'machakann/vim-highlightedyank'
" Tell vim-plug we finished declaring plugins, so it can load them
call plug#end()

" Map leader definition
let mapleader=","

" ============================================================================
" Install plugins the first time vim runs

if vim_plug_just_installed
    echo "Installing Bundles, please ignore key map error messages"
    :PlugInstall
endif

" ============================================================================
" Vim settings and mappings

" mouse
set mouse=a

" no vi-compatible
set nocompatible

" allow plugins by file type (required for plugins!)
filetype plugin on
filetype indent on

" tabs and spaces handling
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4

" tab length exceptions on some file types
autocmd FileType html setlocal shiftwidth=4 tabstop=4 softtabstop=4
autocmd FileType htmldjango setlocal shiftwidth=4 tabstop=4 softtabstop=4
autocmd FileType javascript setlocal shiftwidth=4 tabstop=4 softtabstop=4

" always show status bar
set ls=2

" syntax highlight on
syntax on

" show line numbers
set nu

" tab navigation mappings
map tn :tabn<CR>
map tp :tabp<CR>
map tm :tabm 
map tt :tabnew 
map ts :tab split<CR>
map <C-S-Right> :tabn<CR>
imap <C-S-Right> <ESC>:tabn<CR>
map <C-S-Left> :tabp<CR>
imap <C-S-Left> <ESC>:tabp<CR>

" Comment this line to enable autocompletion preview window
" (displays documentation related to the selected completion option)
" Disabled by default because preview makes the window flicker
set completeopt-=preview

" save as sudo
ca w!! w !sudo tee "%"

" use 256 colors when possible
if (&term =~? 'mlterm\|xterm\|xterm-256\|screen-256') || has('nvim')
	let &t_Co = 256
    colorscheme fisa
else
    colorscheme delek
endif

" colors for gvim
if has('gui_running')
    colorscheme wombat
endif

" when scrolling, keep cursor 3 lines away from screen border
set scrolloff=3

" autocompletion of files and commands behaves like shell
" (complete only the common part, list the options that match)
set wildmode=list:longest

" better backup
set backupdir=/tmp//
set directory=/tmp//
set undodir=/tmp//

" ============================================================================
" Plugins settings and mappings

" NERDTree ----------------------------- 

" toggle nerdtree display
map <leader>1 :NERDTreeToggle<CR>
" open nerdtree with the current file selected
nmap <leader>2  :NERDTreeFind<CR>
" don't show these file types
let NERDTreeIgnore = ['\.pyc$', '\.pyo$']
" enable mouse
let g:NERDTreeMouseMode=3

" make nerdtree prettier
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1
let NERDTreeAutoDeleteBuffer = 1
let NERDTreeShowHidden=1
" nerdtree-syntax-highlight
let g:NERDTreeFileExtensionHighlightFullName = 1

" TabMan ------------------------------

" mappings to toggle display, and to focus on it
let g:tabman_toggle = 'tl'
let g:tabman_focus  = 'tf'

" Autoclose ------------------------------

" Fix to let ESC work as espected with Autoclose plugin
let g:AutoClosePumvisible = {"ENTER": "\<C-Y>", "ESC": "\<ESC>"}

" Window Chooser ------------------------------

" mapping
nmap  -  <Plug>(choosewin)
" show big letters
let g:choosewin_overlay_enable = 1

" Airline ------------------------------

let g:airline_powerline_fonts = 0
let g:airline_theme = 'bubblegum'
let g:airline#extensions#whitespace#enabled = 0

let g:airline_section_z = '%l:%v %p%% %L'
let g:airline_section_y = '%{&fileencoding?&fileencoding:&encoding}'

" Remapping vim beginning/end of the line keys

inoremap <C-A> <Home>
inoremap <C-E> <End>

xnoremap <C-A> <Home>
xnoremap <C-E> <End>

nnoremap <C-A> 0
nnoremap <C-E> $

nnoremap 9 $

" Navigating in command mode
cnoremap <C-a> <Home>
cnoremap <C-e> <End>

set clipboard=unnamed "OSX

" autocmd FileType python set spell spelllang=en
" autocmd FileType javascript set spell spelllang=en

" Functions for comment/uncomment code
source ~/.vim/vcomments.vim
map gc :call Comment()<CR>
map gC :call Uncomment()<CR>

"Make possible navigation with Option+Left Arrow and Option+Right Arrow
map f w

"Disable Vim bells sounds
set belloff=all

" fzf configs
nnoremap <leader>f :Files<CR>
nnoremap <leader>g :GFiles<CR>
nnoremap <leader>b :Buffers<CR>
nnoremap <leader>L :Lines<CR>
nnoremap <leader>a :Rg<CR>
nnoremap <leader>m :Marks<CR>
"applied commands history
nnoremap <leader>e :History:<CR>
"edited files history
nnoremap <leader>r :History<CR>
" :History/ search history 

" Source the vimrc file after saving it
if has("autocmd")
  autocmd bufwritepost .vimrc source $MYVIMRC
endif

" XML/HTML autocomplete
function s:CompleteTags()
  inoremap <buffer> > ></<C-x><C-o><Esc>:startinsevim-snippetsrt!<CR><C-O>?</<CR>
  inoremap <buffer> ><Leader> >
  inoremap <buffer> ><CR> ></<C-x><C-o><Esc>:startinsert!<CR><C-O>?</<CR><CR><Tab><CR><Up><C-O>$
endfunction

autocmd BufRead,BufNewFile *.html,*.js,*.xml call s:CompleteTags()

"Cursor settings
let &t_SI.="\e[5 q" "SI = INSERT mode
let &t_SR.="\e[4 q" "SR = REPLACE mode
let &t_EI.="\e[1 q" "EI = NORMAL mode (ELSE)
"Cursor after the last character
set ve+=onemore

" Use the black hole register to really delete something:
nnoremap <leader>d "_d
xnoremap <leader>d "_d

nnoremap <leader>c "_c
xnoremap <leader>c "_c

" Backspace in the visual mode for deleting
vmap <bs> "_d
imap <bs> "_d

" replace currently selected text with default register without yanking it
vnoremap <leader>p "_dP

" Highlight the current line
set cursorline
hi cursorline cterm=none term=none
autocmd WinEnter * setlocal cursorline
autocmd WinLeave * setlocal nocursorline
highlight CursorLine guibg=#303000 ctermbg=234

highlight CursorColumn ctermfg=White ctermbg=Yellow cterm=bold guifg=white guibg=yellow gui=bold
hi CursorLineNr term=bold ctermfg=Blue gui=bold guifg=Yellow

" Wildmenu
set wildmenu
set wildmode=full:full

"colorscheme gruvbox

" Enable NERDTree resizing in tmux
if has("mouse_sgr")
    set ttymouse=sgr
else
    set ttymouse=xterm2
end

" Enable FZF hidden files
let $FZF_DEFAULT_COMMAND = 'ag --hidden --ignore .git -l -g ""'

command! -bang -nargs=* Ag
  \ call fzf#vim#ag(
  \   <q-args>,
  \   '--hidden',
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
  \   <bang>0
  \ )

" :Rg command
command! -bang -nargs=* Rg
   \ call fzf#vim#grep(
   \   'rg --hidden --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>),
   \   1,
   \   fzf#vim#with_preview('right:50%', '?'),
   \   <bang>0)

function! ClearRegisters()
    let regs='abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789/-="*+'
    let i=0
    while (i<strlen(regs))
        exec 'let @'.regs[i].'=""'
        let i=i+1
    endwhile
endfunction

command! ClearRegisters call ClearRegisters()

" quote/unquote words
nnoremap <Leader>" ciw""<Esc>P
nnoremap <Leader>' ciw''<Esc>P
nnoremap <Leader>"d daW"=substitute(@@,"'\\\|\"","","g")<CR>P

let g:snipMate = { 'snippet_version' : 1 }

" Easymotion  3.0 ------------------------------
" <Leader>f{char} to move to {char}
map  <Leader>s <Plug>(easymotion-bd-f)
nmap <Leader>s <Plug>(easymotion-overwin-f)

" s{char}{char} to move to {char}{char}
nmap <Leader><Leader>s <Plug>(easymotion-overwin-f2)

" Move to line
map <Leader>l <Plug>(easymotion-bd-jk)
nmap <Leader>l <Plug>(easymotion-overwin-line)

" Move to word
map  <Leader>w <Plug>(easymotion-bd-w)
nmap <Leader>w <Plug>(easymotion-overwin-w)

" Incsearch  ------------------------------
map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)

"ignorecase - case insensitive search
"smartcase - case sensitive if it contains an uppercase letter
set ignorecase
set smartcase

" This feature turns 'hlsearch' off automatically after searching-related motions
set hlsearch
let g:incsearch#auto_nohlsearch = 1
map n  <Plug>(incsearch-nohl-n)
map N  <Plug>(incsearch-nohl-N)

" Show count of matches
set shortmess-=S

" Reselect pasted text 
nnoremap rp `[v`]

" MRU
nnoremap  <leader>hr :MRUToggle<CR>

function! MRUClean()
  let home_dir = expand("~")
  let full_path = home_dir . "/" . ".vim_mru_files"
  if filereadable(full_path)
    call delete(full_path)
    echo "Cleaned MRU hisotry " . full_path
  else
    echo "MRU history file not found: " . full_path
  endif
endfunction

command! ClearMRU call MRUClean()

" YankRing, :YRClear to clean the history
nnoremap <leader>y :YRShow<CR>

" Yanked text highlight duration
let g:highlightedyank_highlight_duration = 60

