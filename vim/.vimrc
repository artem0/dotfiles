" Install Pathogen plugin manager
let pathogen_path = expand('~/.vim/autoload/pathogen.vim')
if !filereadable(pathogen_path)
    echo "Installing Pathogen"
    silent !mkdir -p ~/.vim/autoload
    silent !curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim
endif

execute pathogen#infect()
call pathogen#helptags()

:set mouse=a

" Fisa-vim-config
" http://fisadev.github.io/fisa-vim-config/
" version: 8.3.1

" ============================================================================
" Vim-plug initialization
" Avoid modify this section, unless you are very sure of what you are doing

let vim_plug_just_installed = 0
let vim_plug_path = expand('~/.vim/autoload/plug.vim')
if !filereadable(vim_plug_path)
    echo "Installing Vim-plug"
    silent !mkdir -p ~/.vim/autoload
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    let vim_plug_just_installed = 1
endif

" manually load vim-plug the first time
if vim_plug_just_installed
    :execute 'source '.fnameescape(vim_plug_path)
endif

" Obscure hacks done, you can now modify the rest of the .vimrc as you wish :)

" ============================================================================
" Active plugins
" You can disable or add new ones here:

" this needs to be here, so vim-plug knows we are declaring the plugins we
" want to use
call plug#begin('~/.vim/plugged')

" Plugins from github repos:

" Override configs by directory 
Plug 'arielrossanigo/dir-configs-override.vim'
" Better file browser
Plug 'scrooloose/nerdtree'
Plug 'jistr/vim-nerdtree-tabs', { 'on': 'NERDTreeTabsToggle' }
Plug  'tiagofumo/vim-nerdtree-syntax-highlight'
" Code commenter
Plug 'scrooloose/nerdcommenter'
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
" Pending tasks list
Plug 'fisadev/FixedTaskList.vim'
" Surround
Plug 'tpope/vim-surround'
" Autoclose
Plug 'Townk/vim-autoclose'
" Indent text object
Plug 'michaeljsmith/vim-indent-object'
" Indentation based movements
Plug 'jeetsukumaran/vim-indentwise'
" Python autocompletion, go to definition.
Plug 'davidhalter/jedi-vim'
" Snippets manager (SnipMate), dependencies, and snippets repo
Plug 'MarcWeber/vim-addon-mw-utils'
Plug 'tomtom/tlib_vim'
Plug 'honza/vim-snippets'
Plug 'garbas/vim-snipmate'
" Automatically sort python imports
Plug 'fisadev/vim-isort'
" Window chooser
Plug 't9md/vim-choosewin'
" Python and other languages code checker
Plug'dense-analysis/ale'
" Paint css colors with the real color
Plug 'lilydjwg/colorizer'
" Ack code search (requires ack installed in the system)
Plug 'mileszs/ack.vim'
if has('python')
    " YAPF formatter for Python
    Plug 'pignacio/vim-yapf-format'
endif
" Relative numbering of lines (0 is the current line)
" (disabled by default because is very intrusive and can't be easily toggled
" on/off. When the plugin is present, will always activate the relative 
" numbering every time you go to normal mode. Author refuses to add a setting 
" to avoid that)
" Plug 'myusuf3/numbers.vim'

" Plugins from vim-scripts repos:

" Search results counter
Plug 'vim-scripts/IndexedSearch'
" XML/HTML tags navigation
Plug 'vim-scripts/matchit.zip'
" Gvim colorscheme
Plug 'vim-scripts/Wombat'
" Yank history navigation
Plug 'vim-scripts/YankRing.vim'

" :PlugInstall and PlugUpdate will clone fzf in ~/.fzf and run the install script
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'

" Git wrappers
Plug 'airblade/vim-gitgutter'

" Color schemas
Plug 'arcticicestudio/nord-vim'
Plug 'liuchengxu/space-vim-dark'
Plug 'whatyouhide/vim-gotham'
Plug 'keith/parsec.vim'
Plug 'joshdick/onedark.vim'
Plug 'morhetz/gruvbox'

" <Leader><Leader>w | b - to trigger the word motion | backwards
" <Leader><Leader>e | ge - to trigger the end of words | backwords
" <Leader><Leader>j | k - to trigger the lines below | backwards
" <Leader><Leader>so - looking for an 'o'
Plug 'easymotion/vim-easymotion'

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
" You can edit them as you wish

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

" incremental search
set incsearch

" exit search highlighting
nnoremap <C-H> :set hlsearch!<CR>

" highlighted search results
set hlsearch

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

" navigate windows with meta+arrows
map <M-Right> <c-w>l
map <M-Left> <c-w>h
map <M-Up> <c-w>k
map <M-Down> <c-w>j
imap <M-Right> <ESC><c-w>l
imap <M-Left> <ESC><c-w>h
imap <M-Up> <ESC><c-w>k
imap <M-Down> <ESC><c-w>j

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
map <F3> :NERDTreeToggle<CR>
" open nerdtree with the current file selected
nmap ,t :NERDTreeFind<CR>
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

" Tasklist ------------------------------

" show pending tasks list
map <F2> :TaskList<CR>

" Jedi-vim ------------------------------

" jedi is hanging w\o this line and heavily loads CPU
let g:jedi#force_py_version = 3
" All these mappings work only for python code:
" Go to definition
let g:jedi#goto_command ="<leader>m"
" Find ocurrences
let g:jedi#usages_command = "<leader>o"
" Find assignments
let g:jedi#goto_assignments_command = "<leader>a"
" Go to definition in new tab
nmap <leader>M :tab split<CR>:call jedi#goto()<CR>

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

" run from the insert mode
imap <F5> <Esc>:w<CR>:!clear;python %<CR>

" run from the normal mode
augroup Python
    autocmd!
        autocmd FileType python nnoremap <buffer> <F9> :exec '!python' shellescape(@%, 1)<cr>
augroup END

" Remapping vim beginnin/end of the line keys

inoremap <C-A> <Home>
inoremap <C-E> <End>

xnoremap <C-A> <Home>
xnoremap <C-E> <End>

nnoremap <C-A> 0
nnoremap <C-E> $

"nnoremap 0 $
"nnoremap 9 0

set clipboard=unnamed "OSX

autocmd FileType python set spell spelllang=en omnifunc=pythoncomplete#Complete
autocmd FileType javascript set spell spelllang=en

" Functions for comment/uncomment code
source ~/.vim/vcomments.vim
map gc :call Comment()<CR>
map gC :call Uncomment()<CR>

"ignorecase - case insensitive search
"smartcase - case sensitive if it contains an uppercase letter
set ignorecase
set smartcase

"Make possilbe navigation with Option+Left Arrow and Option+Right Arrow
:map f w

"Disable Vim bells sounds
set belloff=all

" fzf configs
nnoremap <leader>e :Files<CR>
nnoremap <leader>g :GFiles<CR>
nnoremap <leader>b :Buffers<CR>
nnoremap <leader>l :Lines<CR>
nnoremap <leader>q :Ag<CR>

" Source the vimrc file after saving it
if has("autocmd")
  autocmd bufwritepost .vimrc source $MYVIMRC
endif

" XML/HTML autocomplete
function s:CompleteTags()
  inoremap <buffer> > ></<C-x><C-o><Esc>:startinsert!<CR><C-O>?</<CR>
  inoremap <buffer> ><Leader> >
  inoremap <buffer> ><CR> ></<C-x><C-o><Esc>:startinsert!<CR><C-O>?</<CR><CR><Tab><CR><Up><C-O>$
endfunction
autocmd BufRead,BufNewFile *.html,*.js,*.xml call s:CompleteTags()

autocmd FileType python setlocal omnifunc=jedi#completions
let g:jedi#completions_enabled = 0
let g:jedi#auto_vim_configuration = 0

"Cursor settings
let &t_SI.="\e[5 q" "SI = INSERT mode
let &t_SR.="\e[4 q" "SR = REPLACE mode
let &t_EI.="\e[1 q" "EI = NORMAL mode (ELSE)
"Cursor after the last character
set ve+=onemore

" Use the black hole register to really delete something:
nnoremap <leader>d "_d
xnoremap <leader>d "_d

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

