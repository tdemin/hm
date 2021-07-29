""" Plugins list

call plug#begin("~/.vim/plugged")
Plug 'rakr/vim-one'
Plug 'vim-airline/vim-airline', { 'tag': '*' }
Plug 'preservim/nerdcommenter', { 'tag': '*' }
Plug 'nathanaelkane/vim-indent-guides', { 'tag': '*' }
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'liuchengxu/vista.vim', { 'branch': 'master' }
Plug 'junegunn/fzf', { 'tag': '*' }
Plug 'tpope/vim-sensible', { 'tag': '*' }
Plug 'tpope/vim-fugitive', { 'tag': '*' }
Plug 'rhysd/reply.vim', { 'branch': 'master', 'on': ['Repl', 'ReplAuto', 'ReplSend', 'ReplRecv'] }
Plug 'sakshamgupta05/vim-todo-highlight'
Plug 'mattn/emmet-vim', { 'tag': '*', 'for': ['html', 'css'] }
Plug 'w0rp/ale', { 'tag': '*', 'for': ['javascript', 'python', 'typescript', 'go', 'c', 'cpp'] }
Plug 'fatih/vim-go', { 'tag': '*', 'for': 'go' }
Plug 'sebdah/vim-delve', { 'branch': 'master', 'for': 'go' }
Plug 'nsf/gocode', { 'tag': '*', 'for': 'go' }
Plug 'iamcco/sran.nvim', { 'do': { -> sran#util#install() } }
Plug 'iamcco/git-p.nvim'
Plug 'liuchengxu/vim-clap', { 'tag': '*', 'do': ':Clap install-binary!' }
Plug 'junegunn/vim-easy-align', { 'tag': '*' }
Plug 'editorconfig/editorconfig-vim', { 'tag': '*' }
Plug 'mhinz/vim-startify'
Plug 'nfnty/vim-nftables'
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-repeat', { 'tag': '*' }
Plug 'tpope/vim-surround', { 'tag': '*' }
Plug 'glts/vim-textobj-comment'
Plug 'kana/vim-textobj-user'
" Completion
Plug 'neoclide/coc.nvim', { 'branch': 'release', 'for': ['javascript', 'python', 'typescript', 'go', 'c', 'cpp'] }
Plug 'josa42/coc-go', { 'tag': '*', 'for': 'go', 'do': 'yarn install --frozen-lockfile' }
Plug 'neoclide/coc-json', { 'tag': '*', 'for': 'json', 'do': 'yarn install --frozen-lockfile' }
Plug 'neoclide/coc-python', { 'tag': '*', 'for': 'python', 'do': 'yarn install --frozen-lockfile' }
Plug 'neoclide/coc-snippets', { 'tag': '*', 'for': ['python', 'go', 'typescript', 'javascript', 'go', 'c', 'cpp'], 'do': 'yarn install' }
Plug 'neoclide/coc-tsserver', { 'tag': '*', 'for': ['typescript', 'javascript'], 'do': 'yarn install --frozen-lockfile' }
Plug 'honza/vim-snippets'
" Known to cause problems with vim-go
Plug 'sheerun/vim-polyglot'
call plug#end()

""" Basic editing

if exists('+termguicolors')
   set termguicolors
endif
syntax on
colorscheme one
set background=dark

set number
set nowrap
set linebreak
set showbreak=+++
set textwidth=100
set showmatch
set visualbell
set hlsearch
set smartcase
set ignorecase
set incsearch
set autoindent
set expandtab
set shiftwidth=4
set smartindent
set smarttab
set softtabstop=4
set ruler
set so=5
set colorcolumn=80
set whichwrap+=<,>,[,]

set undolevels=1000
set backspace=indent,eol,start
set timeoutlen=1000 ttimeoutlen=0

set encoding=utf-8
set fileencoding=utf-8

set updatetime=10
set shortmess+=c
set signcolumn=yes

set exrc
set secure

""" Basic editing

let mapleader = ","

nnoremap <silent> <C-a> ggVG
" Tabs/windows
tnoremap <Esc> <C-\><C-n>
nmap <silent> tt :tabnew<CR>
nmap <silent> tw :close<CR>
nmap <silent> tn :tabnext<CR>
nmap <silent> tp :tabprev<CR>
nmap <silent> <leader>sh :split<CR>
nmap <silent> <leader>sv :vsplit<CR>
nnoremap <silent> <A-S-Up> :m .-2<CR>==
nnoremap <silent> <A-S-Down> :m .+1<CR>==
inoremap <silent> <A-S-Up> <Esc>:m .-2<CR>==gi
inoremap <silent> <A-S-Down> <Esc>:m .+1<CR>==gi
vnoremap <silent> <A-S-Up> :m '<-2<CR>gv=gv
vnoremap <silent> <A-S-Down> :m '>+1<CR>gv=gv
nmap <leader>hl :set nohlsearch<CR>

""" Search

function! BufferCount() abort
    return len(filter(range(1, bufnr('$')), 'bufwinnr(v:val) != -1'))
endfunction

function! ToggleQuickFix()
    if empty(filter(getwininfo(), 'v:val.quickfix'))
        silent! copen
    else
        silent! cclose
    endif
endfunction

function! ToggleLocationList()
    let buffer_count_before = BufferCount()
    silent! lclose
    silent! lclose
    if BufferCount() == buffer_count_before
        execute "silent! lopen"
    endif
endfunction

nmap <silent> <C-m> :call ToggleQuickFix()<CR>
nmap <silent> <A-m> :call ToggleLocationList()<CR>
nnoremap <leader>cd :cd %:p:h<CR>

nmap <silent> <C-p> :Clap files<CR>
nmap <silent> <C-f> :Clap grep<CR>
nmap <silent> <A-y> :Clap tags<CR>
nmap <silent> <A-t> :Clap proj_tags<CR>

""" Per-language settings

filetype plugin on

" Python

au filetype python setlocal expandtab tabstop=4 shiftwidth=4 softtabstop=4

" Go

au filetype go setlocal tabstop=4 shiftwidth=4 softtabstop=4
let g:go_fmt_command = "goimports"
let g:go_auto_type_info = 0
let g:go_auto_sameids = 0
let g:go_def_mode = "gopls"
let g:go_info_mode = "gopls"
let g:go_rename_command = "gopls"
let g:go_highlight_build_constraints = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_operators = 1
let g:go_highlight_structs = 1
let g:go_highlight_types = 1
au filetype go nmap <silent> <leader>ga <Plug>(go-alternate-edit)
au filetype go nmap <silent> <leader>gah <Plug>(go-alternate-split)
au filetype go nmap <silent> <leader>gav <Plug>(go-alternate-vertical)
au filetype go nmap <silent> <F10> :GoTest -short<CR>
au filetype go nmap <silent> <F5> :DlvDebug<CR>
au filetype go nmap <silent> <F7> :DlvToggleBreakpoint<CR>
au filetype go nmap <silent> <F8> :GoDoc<CR>

" Misc

au filetype yaml setlocal expandtab tabstop=2 shiftwidth=2 softtabstop=2
au filetype lisp setlocal expandtab

augroup mail_trailing_whitespace
    au!
    au filetype mail setlocal formatoptions+=w tw=80
augroup END

""" IDE features

" Misc

let g:EditorConfig_exclude_patterns = ['fugitive://.*']
let g:EditorConfig_disable_rules = ['trim_trailing_whitespace']

let g:startify_custom_header = []

let g:reply_repls = {
            \   "ruby": ["irb"],
            \   "prolog": ["swipl"]
            \ }

let g:NERDTreeWinPos = "right"

let g:indent_guides_enable_on_vim_startup = 1

let g:gitp_blame_virtual_text = 1
let g:gitp_blame_format = '    %{account} * %{ago}'

" Linting

let g:ale_fixers = {
            \ "javascript": ["prettier", "eslint"],
            \ "python": ["black"],
            \ "go": ["goimports"],
            \ "cpp": ["astyle"],
            \ "c": ["astyle"]
            \ }
let g:ale_fix_on_save = 1
let g:ale_linters = {
            \ "javascript": ["eslint"],
            \ "python": ["flake8", "mypy"],
            \ "go": ["gopls"],
            \ "c": ["clang-check", "clang-tidy", "clang", "gcc"],
            \ "cpp": ["clang-check", "clang-tidy", "clang", "g++"]
            \ }

" Hotkeys

au filetype go,python,c,cpp nmap <silent> <F12> :call CocAction("jumpDefinition", "tab drop")<CR>
au filetype go,python,c,cpp nmap <silent> <F2> <Plug>(coc-rename)
au filetype go,python,c,cpp nmap <silent> <A-t> :CocList -I symbols<CR>
au filetype go,python,c,cpp nmap <silent> <A-y> :CocList outline<CR>
au filetype go,python,c,cpp imap <silent> <C-l> <Plug>(coc-snippets-expand)
au filetype go,python,c,cpp nmap <silent> <leader>ac  <Plug>(coc-codeaction)
au filetype go,python,c,cpp nmap <silent> <leader>qf  <Plug>(coc-fix-current)
au filetype go,python,c,cpp command! -nargs=0 Format :call CocAction('format')
au filetype go,python,c,cpp command! -nargs=? Fold :call CocAction('fold', <f-args>)
au filetype go,python,c,cpp command! -nargs=0 OR :call CocAction('runCommand', 'editor.action.organizeImport')
au filetype go,python,c,cpp nmap <silent> <leader>f <Plug>(coc-format-selected)
au filetype go,python,c,cpp nmap <silent> <leader>a <Plug>(coc-codeaction-selected)
au filetype go,python,c,cpp inoremap <silent><expr> <C-@> coc#refresh()
au filetype go,python,c,cpp inoremap <silent><expr> <TAB>
      \ pumvisible() ? coc#_select_confirm() :
      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()

function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
endfunction

let g:coc_snippet_next = '<tab>'

let g:user_emmet_leader_key = "<C-Z>"

imap <silent> <C-_> <Esc><plug>NERDCommenterInvert i
map <silent> <C-_> <plug>NERDCommenterInvert

nmap <silent> <C-e> :Vista<CR>
nmap <silent> <C-q> :NERDTreeToggle<CR>

nmap <silent> <leader>gd <Plug>(git-p-diff-preview)
nmap <silent> <leader>gb <Plug>(git-p-i-blame)
nmap <silent> <leader>gg :G<CR>
nmap <silent> <leader>gl :Glog<CR>

au filetype lisp vmap <F5> :ReplSend<CR>
au filetype lisp map <F2> :Repl<CR>

map ga <Plug>(EasyAlign)
