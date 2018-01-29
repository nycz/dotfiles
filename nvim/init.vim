" ========== Table of contents ============================
"
" Search for the number + letters without space (eg. 1ntv)
" to get to the section in question.
"
" 1 ntv - Native settings
" 2 def - Defaults in Nvim
" 3 plu - Plugins
" 4 pls - Plugin settings
" 5 kbi - Key bindings
" 6 mts - Misc/temp settings
" 7 fin - Final things


" ==1ntv=== Native settings ==============================

set background=dark
set expandtab           " <Tab> inserts spaces instead of tabs
set ignorecase
set hidden              " Hide buffers when they are abandoned
set number              " Line numbers
set shiftwidth=4        " Spaces to indent with
set showmatch           " Show matching brackets.
set smartcase           " Ignore case unless capitals are present
set softtabstop=4       " Spaces to insert on <Tab>
set tabstop=4           " Tab characters' width
set t_Co=256            " 256 colors
set termguicolors       " True colors (24bit)
set timeoutlen=500      " The time it takes for leader to timeout

" How soon (ms) the swap will be written to disk.
" Useful for gitgutter (and others?)
set updatetime=250

" Removes extra autocompletion window at the top
set completeopt=menu  ",preview

" Set correct shell syntax
let g:is_posix = 1

" Set the python3 path
let g:python3_host_prog = '/usr/bin/python3'
" Disable python2
let g:loaded_python_provider = 1

" Custom file formats
au BufNewFile,BufRead *.pyi set filetype=python
au FileType html setlocal shiftwidth=2 tabstop=2 softtabstop=2
au FileType css setlocal shiftwidth=2 tabstop=2 softtabstop=2
au FileType javascript setlocal shiftwidth=2 tabstop=2 softtabstop=2

" =========================================================





" ==2def==== Defaults in Nvim (but not in vim) ============

" if has("syntax")
"   syntax on
" endif
" if has("autocmd")
"   filetype plugin indent on
" endif
" set autoindent
" set bs=2         " Same as set backspace=indent,eol,start
" set hlsearch
" set incsearch
" set showcmd
" set smarttab

" =========================================================





" ==3plu==== Plugins ======================================

call plug#begin('~/.config/nvim/plugged')

" ## Themes ##
" ------------
Plug 'morhetz/gruvbox'
Plug 'tomasr/molokai'
Plug 'fmoralesc/molokayo'
Plug 'nielsmadan/harlequin'
Plug 'crusoexia/vim-monokai'


" ## Syntax highlight ##
" ----------------------
" Python (improved)
Plug 'vim-python/python-syntax'

" Pydoc support
"Plug 'davidhalter/jedi-vim'

" Javascript (improved)
Plug 'pangloss/vim-javascript'

" JSX (new)
"Plug 'mxw/vim-jsx'

" Handlebars (new)
Plug 'mustache/vim-mustache-handlebars'

" Various languages (see plugin options to pick which ones)
Plug 'sheerun/vim-polyglot'

" i3 config syntax
Plug 'PotatoesMaster/i3-vim-syntax'


" ## HTML stuff ###
" -----------------
" HTML editing
Plug 'mattn/emmet-vim'

" Autoclose tags
Plug 'alvan/vim-closetag'

" Highlight matching tags
Plug 'gregsexton/MatchTag'


" ## Misc ##
" ----------
" Linter
Plug 'neomake/neomake'

" Fuzzy search
Plug 'ctrlpvim/ctrlp.vim'

" File/tree explorer
Plug 'scrooloose/nerdtree'

" Git diff in the left margin
Plug 'airblade/vim-gitgutter'

" Autocompletion
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'zchee/deoplete-jedi'      " Python
Plug 'carlitux/deoplete-ternjs' " Javascript, npm install -g tern

" Table mode
Plug 'dhruvasagar/vim-table-mode'

" Comment out shit
Plug 'scrooloose/nerdcommenter'


" ## Inactive/legacy ##
" ---------------------
"Plug 'flazz/vim-colorschemes'
"Plug 'felixhummel/setcolors.vim'
"Plug 'jlanzarotta/bufexplorer'
"Plug 'posva/vim-vue'

call plug#end()

" =========================================================





" ==4pls==== Plugin settings ==============================

" Neomake
let g:neomake_highlight_lines = 1
let g:neomake_python_enabled_makers = ['flake8']
let g:neomake_enabled_makers = ['dash']
"let g:neomake_open_list = 2    " Always show error/warning list
let g:neomake_error_sign = {'text': 'E', 'texthl': 'NeomakeErrorSign'}
let g:neomake_warning_sign = {'text': 'W', 'texthl': 'NeomakeWarningSign'}
let g:neomake_message_sign = {'text': 'M', 'texthl': 'NeomakeMessageSign'}
let g:neomake_info_sign = {'text': 'I', 'texthl': 'NeomakeInfoSign'}
autocmd! BufWritePost,BufEnter * Neomake " Lint on write and open

" python-syntax
let python_highlight_all = 1    " Use the plugin instead of native

" deoplete
let g:deoplete#enable_at_startup = 1

" vim-closetag
let g:closetag_filenames = "*.html,*.xhtml,*.phtml,*.xml,*.htm"

" dont use polyglot to highlight python
let g:polyglot_disabled = ['python', 'javascript']

" jedi-vim
"let g:jedi#completions_enabled = 0
"let g:jedi#auto_vim_configuration = 0
"let g:jedi#goto_command = ""
"let g:jedi#goto_assignments_command = ""
"let g:jedi#goto_definitions_command = ""
"let g:jedi#documentation_command = "K"
"let g:jedi#usages_command = ""
"let g:jedi#completions_command = ""
"let g:jedi#rename_command = ""

" =========================================================





" ==5kbi==== Key bindings =================================
"
" (Including plugins' bindings)


" ## Various good bindings ##
" Leader
let mapleader = "\\"
" Clear highlight
map <leader>h :nohl<CR>
" Quit even when holding shift
command Q :q
" Open help in a vertical split to the right
cabbrev h vert bo help
" Better escape
imap <leader>e <Esc>
map <leader>e <Esc>


" ## Better colemak-compatible navigation ##
" ↑ Up
noremap h k
noremap <C-w>h <C-w>k
" ↓ Down
noremap k j
noremap <C-w>k <C-w>j
" ← Left
noremap j h
noremap <C-w>j <C-w>h
" → Right (not needed since it isn't changed)
"noremap l l
"noremap <C-w>l <C-w>l


" ## Buffers ##
" Next
map <leader>n :bn<CR>
" Previous
map <leader>p :bp<CR>
" Last
map <leader>l :b#<CR>
" Close
map <leader>d :bd<CR>
" Show list
map <leader>f :ls<CR>
" Go to file (note the space at the end!!)
map <leader>g :b 

" ## Better omni completion ##
inoremap <C-Space> <C-x><C-o>

" ## Use <Tab> in autocompletion/popup menu ##
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" ## Switch between javascript and mustache syntax ##
function SwitchWebSyntax()
    if &syntax =~ '^javascript'
        set syntax=mustache
        echo "switching to mustache syntax"
    elseif &syntax =~ '^mustache'
        set syntax=javascript
        echo "switching to javascript syntax"
    endif
endfunction
map <leader>, :call SwitchWebSyntax()<CR>

" ## Plugins ##
" Run Neomake
map <leader>m :Neomake<CR>


" ## Copy between different vim instances ##
command CrossCopy :call writefile(getreg("", 1, 1), "/tmp/vimcrossdump")
command CrossPaste :r /tmp/vimcrossdump

" =========================================================





" ==6mts==== Misc/temp settings ===========================

"let $NVIM_TUI_ENABLE_CURSOR_SHAPE = 1

" =========================================================





" ==7fin==== Final things =================================

colorscheme mononycz

" =========================================================

