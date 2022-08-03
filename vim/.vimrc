set wrap linebreak nolist
set encoding=utf-8
autocmd InsertLeave * write
" augroup remember_folds
"   autocmd!
"   autocmd BufWinLeave * mkview
"   autocmd BufWinEnter * silent! loadview
" augroup END

syntax on
set textwidth=0
set colorcolumn=+1

" Tab completion
" will insert tab at beginning of line,
" will use completion if not at beginning
set wildmode=list:longest,list:full
function! InsertTabWrapper()
    let col = col('.') - 1
    if !col || getline('.')[col - 1] !~ '\k'
        return "\<Tab>"
    else
        return "\<C-p>"
    endif
endfunction
inoremap <Tab> <C-r>=InsertTabWrapper()<CR>
inoremap <S-Tab> <C-n>
set hidden
set noerrorbells
set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set smartindent
set nu
set ignorecase
set smartcase
set noswapfile
" set spell
" set viminfo='100,<500,s10,h,!
" autocmd VimEnter * SessionOpenLast

" function! MakeSession(overwrite)
"   let b:sessiondir = $HOME . "/.vim/sessions" . getcwd()
"   if (filewritable(b:sessiondir) != 2)
"     exe 'silent !mkdir -p ' b:sessiondir
"     redraw!
"   endif
"   let b:filename = b:sessiondir . '/session.vim'
"   if a:overwrite == 0 && !empty(glob(b:filename))
"     return
"   endif
"   exe "mksession! " . b:filename
" endfunction

" function! LoadSession()
"   let b:sessiondir = $HOME . "/.vim/sessions" . getcwd()
"   let b:sessionfile = b:sessiondir . "/session.vim"
"   if (filereadable(b:sessionfile))
"     exe 'source ' b:sessionfile
"   else
"     echo "No session loaded."
"   endif
" endfunction

" " Adding automatons for when entering or leaving Vim
" if(argc() == 0)
"   au VimEnter * nested :call LoadSession()
"   au VimLeave * :call MakeSession(1)
" else
"   au VimLeave * :call MakeSession(0)
" endif


"undo file conf
set undofile
set undodir=~/.vim/vimundo

set incsearch
set relativenumber
"
" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=50

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

"set colorcolumn=71
"highlight ColorColumn ctermbg=0 guibg=lightgrey
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')
Plug 'christoomey/vim-tmux-navigator'
Plug 'dracula/vim', {'as': 'dracula'}
Plug 'joshdick/onedark.vim'
Plug 'cocopon/iceberg.vim'
Plug 'dense-analysis/ale'
Plug 'puremourning/vimspector'  
Plug 'morhetz/gruvbox'
Plug 'tpope/vim-fugitive'
Plug 'leafgarland/typescript-vim'
Plug 'vim-utils/vim-man'
Plug 'ycm-core/YouCompleteMe'
Plug 'lyuts/vim-rtags'
Plug 'mbbill/undotree'
Plug 'vim-python/python-syntax'
Plug 'sheerun/vim-polyglot'
Plug 'jiangmiao/auto-pairs'
Plug 'overcache/NeoSolarized'
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}

call plug#end()

let g:python_highlight_all = 0
set nocompatible
syntax enable
set termguicolors
set background=light
colorscheme NeoSolarized
"colorscheme iceberg 
"colorscheme solarized
"colorscheme gruvbox 
"colorscheme dracula
if executable('rg')
    let g:rg_derive_root='true'
endif

let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']
let mapleader = " "

let g:netrw_browse_split = 2
let g:netrw_banner = 0
let g:netrw_winsize = 25

let g:ctrlp_use_caching = 0

nnoremap <leader>h :wincmd h<CR>
nnoremap <leader>j :wincmd j<CR>

nnoremap <leader>k :wincmd k<CR>
nnoremap <leader>l :wincmd l<CR>

nnoremap <leader>u :UndotreeShow<CR>
nnoremap <Leader>ps :Rg<SPACE>

nnoremap <leader>pv :wincmd v<bar> :Ex <bar> :vertical resize 30<CR>
nnoremap <silent> <Leader>> :vertical resize +5<CR>

nnoremap <silent> <Leader>< :vertical resize -5<CR>
nnoremap <silent> <Leader>- :resize -5<CR>
nnoremap <silent> <Leader>+ :resize +5<CR>
nnoremap <silent> <Leader>= :resize<CR>

nnoremap <leader>ov :exe ':silent !code %'<CR>:redraw!<CR>
nnoremap <leader>od :exe ':silent !xdg-open %'<CR>:redraw!<CR>
"Clear highlights on hitting ESC twice
nnoremap <silent> <Esc><Esc> :noh<CR> :call clearmatches()<CR>
"remapping space to leader+space  in normal mode
nnoremap <silent> <Leader><Space> i<Space><Esc>

noremap ,v :split<enter>
nnoremap ,s :vsplit<enter>
nnoremap ,r <C-w>r 
nnoremap ,x <C-w>c 
nnoremap ,o <C-w>o
noremap ,t :tabnew<enter>
noremap ,X :tabclose<enter>
noremap ,Q :qa<enter>
noremap ,q :q<enter>
noremap <C-A> ggVG

" Go to tab by number
noremap <leader>1 1gt
noremap <leader>2 2gt
noremap <leader>3 3gt
noremap <leader>4 4gt
noremap <leader>5 5gt
noremap <leader>6 6gt
noremap <leader>9 :tablast<cr>
noremap <leader>0 :tabfirst<cr>

nnoremap <silent> <Leader>sov :source ~/.vimrc<CR>

"run shell scripts
autocmd FileType sh nnoremap <leader>rs :exec '!sh' shellescape(@%, 1)<cr>


set autoread
if ! exists("g:CheckUpdateStarted")
    let g:CheckUpdateStarted=1
    call timer_start(1,'CheckUpdate')
endif
function! CheckUpdate(timer)
    silent! checktime
    call timer_start(1000,'CheckUpdate')
endfunction
au CursorHold,CursorHoldI * checktime
au FocusGained,BufEnter * :checktime

""Deleted nerd tree
""nerd treee settings "
""map <C-n> :NERDTreeToggle<CR>
"nnoremap <Leader>n :NERDTreeToggle<CR>
"nnoremap <silent> <Leader>v :NERDTreeFind<CR>

"autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

"let NERDTreeMinimalUI = 1
"let NERDTreeDirArrows = 1

"run C file
"let mycommand = ':!gcc % -o %< && echo "%<" && [ $(pwd) == "." ] && %< || ./%< '
"nnoremap <silent> <Leader>cc :!clear && gcc % <CR>
"nnoremap <Leader>rc :!clear && gcc % -o %< && ./%< && read <CR>
autocmd FileType c
   \ set makeprg=gcc\ -Wall\ %\ -o\ out |
   \ nnoremap <Leader>rc :w!<cr>:make<cr>:!./out

autocmd FileType cpp
   \ nnoremap <Leader>rc :w <CR> :!g++ -std=c++17 % && ./a.out <CR>

"templated settings
"source ~/.vim/templates/py_config/py.vim
"source ~/.vim/templates/cpp_config/cp.vim

"ale settings for pthon
let g:ale_linters = {'pthon':['flake8', 'pydocstyle', 'bandit', 'mypy']}
let g:ale_fixers = {'*': [], 'python': ['black', 'isort']}
let g:ale_fix_on_save = 1

au BufLeave ~/.vimrc :source ~/.vimrc
"gvim specifics
if has('gui_running')
    set belloff=all
    " cd PyPrograms/CP/
    set guioptions-=T  " no toolbar
    set guioptions-=m  " no menubar
    colorscheme default
    if has('gui_win32')
    set guifont=DejaVu_Sans_Mono:h4:cANSI
    else
        set guifont=Source\ Code\ Pro\ Italic\ 17
        " set guifont=DejaVu\ Sans\ Mono\ 16
    endif
endif
if has('title') && (has('gui_running') || &title)
    set titlestring=
    set titlestring+=%f
    set titlestring+=%h%m%r%w
    set titlestring+=\ -\ %{v:progname}
    set titlestring+=\ -\ %{substitute(getcwd(),\ $HOME,\ '~',\ '')}
endif
set clipboard=unnamedplus
" When editing a file, always jump to the last cursor position
autocmd BufReadPost *
\ if line("'\"") > 0 && line ("'\"") <= line("$") |
\   exe "normal g'\"" |
\ endif
" to toggle youcompleteme
" let g:loaded_youcompleteme = 1

"" Let clangd fully control code completion
let g:ycm_clangd_uses_ycmd_caching = 0
" Use installed clangd, not YCM-bundled clangd which doesn't get updates.
let g:ycm_clangd_binary_path = exepath("clangd")
let g:ycm_autoclose_preview_window_after_insertion = 1
let g:ycm_global_ycm_extra_conf = '~/.vim/plugged/ycm_extra_conf.py'

"vimspector config
" let g:vimspector_enable_mappings = 'HUMAN'
" nmap <leader>dd :call vimspector#Launch()<CR>
" nmap <leader>dx :VimspectorReset<CR>
" nmap <leader>de :VimspectorEval
" nmap <leader>dw :VimspectorWatch
" nmap <leader>do :VimspectorShowOutput

autocmd FileType cpp setlocal commentstring=//\ %s

" //indentation method
augroup vimrc
  au BufReadPre * setlocal foldmethod=indent
  au BufWinEnter * if &fdm == 'indent' | setlocal foldmethod=manual | endif
augroup END

" "
" inoremap { {<CR>}<Esc>ko
" inoremap (  ()<Left>
" inoremap [  []<Left>
" inoremap "  ""<Left>
" inoremap <expr> )  strpart(getline('.'), col('.')-1, 1) == ")" ? "\<Right>" : ")"
" inoremap <expr> ' strpart(getline('.'), col('.')-1, 1) == "\'" ? "\<Right>" : "\'\'\<Left>"
"support for markdown files
autocmd BufNewFile,BufFilePre,BufRead *.md set filetype=markdown.pandoc
