syntax enable

scriptencoding utf-8
set encoding=utf-8

set smartindent
set expandtab
set smarttab
set smartindent
set splitright
set splitbelow
set hlsearch
set incsearch
set showmode
set ignorecase
set smartcase
set nowrap
set number
set ruler
set list
set tabstop=8
set wildmenu
set formatoptions +=mM
set laststatus=2
set cmdheight=2
set showcmd
set listchars=tab:>-,extends:<,trail:-,eol:<
set notitle
set showmatch matchtime=1
set clipboard=unnamed
set autoread

filetype off
filetype plugin indent off

runtime macros/matchit.vim

if has('vim_starting')
    set runtimepath+=~/.vim/bundle/neobundle.vim
endif
call neobundle#begin(expand('~/.vim/bundle/'))
NeoBundleFetch 'Shougo/neobundle.vim'
NeoBundle 'Shougo/vimproc.vim', {
            \     'build' : {
            \         'windows' : 'tools\\update-dll-mingw',
            \         'cygwin' : 'make -f make_cygwin.mak',
            \         'mac' : 'make -f make_mac.mak',
            \         'unix' : 'make -f make_unix.mak',
            \     }
            \ }
NeoBundle 'Shougo/neocomplcache.vim'
NeoBundle 'Shougo/unite.vim', {
            \     'depends': ['Shougo/vimproc.vim']
            \ }
NeoBundle 'Shougo/vimfiler.vim', {
            \     'depends': ['Shougo/unite.vim']
            \ }
NeoBundle 'Shougo/neosnippet'
NeoBundle 'Shougo/neosnippet-snippets', {
            \     'depends': ['Shougo/neosnippet.vim']
            \ }
NeoBundle 'itchyny/lightline.vim'
NeoBundle 'Shougo/vimshell.vim', {
            \     'depends': ['Shougo/vimproc.vim']
            \ }
NeoBundle 'jpalardy/vim-slime'
NeoBundle 'thinca/vim-visualstar'
NeoBundle 'sudo.vim'
NeoBundle 'thinca/vim-quickrun'
NeoBundleLazy 'vimtaku/hl_matchit.vim.git', {
            \     'autoload': {
            \         'filetypes': ['vim', 'verilog', 'html']
            \     }
            \ }
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'kana/vim-altr'
NeoBundle 'tyru/caw.vim'
NeoBundleLazy 'qnighy/llvm.vim', {
            \     'autoload': {
            \         'filetypes': ['llvm']
            \     }
            \ }
NeoBundleLazy 'mattn/emmet-vim', {
            \     'autoload': {
            \         'filetypes': ['html']
            \     }
            \ }
NeoBundleLazy 'groenewege/vim-less', {
            \     'autoload': {
            \         'filetypes': ['less']
            \     }
            \ }
NeoBundleLazy 'pangloss/vim-javascript', {
            \     'autoload': {
            \         'filetypes': ['javascript']
            \     }
            \ }
NeoBundleLazy 'rcmdnk/vim-markdown', {
            \     'autoload': {
            \         'filetypes': ['markdown']
            \     }
            \ }
NeoBundleLazy 'derekwyatt/vim-scala', {
            \     'autoload': {
            \         'filetypes': ['scala']
            \     }
            \ }
NeoBundleLazy 'dag/vim2hs', {
            \     'autoload': {
            \         'filetypes': ['haskell']
            \     }
            \ }
NeoBundleLazy 'eagletmt/neco-ghc', {
            \     'depends': [ 'Shougo/neocomplcache.vim' ],
            \     'autoload': {
            \         'filetypes': ['haskell']
            \     }
            \ }

call neobundle#end()
NeoBundleCheck

let g:neocomplcache_enable_at_startup = 1
let g:neocomplcache_force_overwrite_completefunc = 1
let g:neocomplcache_enable_smart_case = 1
let g:neocomplcache_enable_underbar_completion = 1
let g:neocomplcache_min_syntax_length = 3
inoremap <expr><Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr><C-h> neocomplcache#close_popup()

imap <expr><CR> !pumvisible() ? "\<CR>" :
            \ neosnippet#expandable() ? "\<Plug>(neosnippet_expand)" :
            \ neocomplcache#close_popup()

let g:lightline = {
            \     'colorscheme': 'wombat',
            \     'active': {
            \         'left': [
            \             ['mode', 'paste'],
            \             ['readonly', 'filename', 'modified']
            \         ],
            \         'right': [
            \             ['lineinfo'],
            \             ['persent'],
            \             ['fileformat', 'fileencoding', 'filetype']
            \         ]
            \     },
            \     'component_function': {
            \         'filename': 'VimrcLightLineFileName'
            \     },
            \     'component_expand': {
            \         'readonly': 'VimrcLightLineReadOnly'
            \     },
            \     'component_type': {
            \         'readonly': 'error'
            \     }
            \ }

function! VimrcLightLineFileName()
    if &ft == 'vimfiler'
        return vimfiler#get_status_string()
    elseif &ft == 'unite'
        return unite#get_status_string()
    elseif &ft == 'vimshell'
        return vimshell#get_status_string()
    elseif expand('%') == ''
        return '[No Name]'
    else
        return expand('%')
    endif
endfunction

let g:unite_force_overwrite_statusline = 0
let g:vimfiler_force_overwrite_statusline = 0
let g:vimfiler_as_default_explorer = 1

noremap <silent> <Space>ff :<C-u>VimFilerBufferDir<CR>
noremap <silent> <Space>fs :<C-u>VimFilerBufferDir -split -horizontal<CR>
noremap <silent> <Space>fv :<C-u>VimFilerBufferDir -split<CR>
let g:vimshell_prompt_expr = 'getcwd()." $ "'
let g:vimshell_prompt_pattern = '^\f\+\$ '

nmap <Leader>a <Plug>(altr-forward)
nmap <Leader>b <Plug>(altr-back)

augroup VimAltrVimrcCommands
    autocmd!
    autocmd Filetype c call altr#define('%.c', '%.h')
    autocmd Filetype cpp call altr#define('%.cc', '%.h', '%.c')
    autocmd Filetype cpp call altr#define('src/%.cc', 'src/%.h', 'test/src/%_test.cc')
augroup END

noremap <CR> o<Esc>
cnoremap <C-a> <Home>
inoremap <C-a> <Home>
cnoremap <C-e> <End>
inoremap <C-e> <End>
cnoremap <C-f> <Right>
inoremap <C-f> <Right>
cnoremap <C-b> <Left>
inoremap <C-b> <Left>
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
nnoremap <silent> <Esc><Esc> :<C-u>nohlsearch<CR>
nnoremap <silent> gc :<C-u>tabnew<CR>
nnoremap gn gt
nnoremap gp gT
nnoremap <silent> gx :<C-u>tabclose<CR>

filetype plugin indent on
