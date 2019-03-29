" `:set nocompatible` is not needed as it's done automatically when a .vimrc
" is found, so only explicitly set it when it's not set, as it has many side
" effects
if &compatible
  set nocompatible
endif

filetype plugin indent on
syntax on

" fix for rendering issue with theme background colors highlighting lines
let &t_ut=""

" unmap the space key's default binding and set it up as our leader key
nnoremap <space> <Nop>
let mapleader=" "

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" disable default plugins
"""

" let g:netrw_altv         = 1
" let g:netrw_banner       = 1
" let g:netrw_browse_split = 1
" let g:netrw_cursor       = 3
" let g:netrw_preview      = 1
" let g:netrw_winsize      = -60
let g:loaded_2html_plugin      = 1
let g:loaded_getscript         = 1
let g:loaded_getscriptPlugin   = 1
let g:loaded_gzip              = 1
let g:loaded_logipat           = 1
let g:loaded_logiPat           = 1
let g:loaded_matchit           = 1
let g:loaded_matchparen        = 1
let g:loaded_netrw             = 1
let g:loaded_netrwFileHandlers = 1
let g:loaded_netrwPlugin       = 1
let g:loaded_netrwSettings     = 1
let g:loaded_rrhelper          = 1
let g:loaded_spellfile_plugin  = 1
let g:loaded_sql_completion    = 1
let g:loaded_syntax_completion = 1
let g:loaded_tar               = 1
let g:loaded_tarPlugin         = 1
let g:loaded_vimball           = 1
let g:loaded_vimballPlugin     = 1
let g:loaded_zip               = 1
let g:loaded_zipPlugin         = 1
let g:vimsyn_embed             = 1

set encoding=utf-8

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" appearance
"""

let g:nord_cursor_line_number_background = 1
let g:nord_italic = 1
let g:nord_italic_comments = 1
let g:nord_underline = 1
set background=dark
set cursorline

" show non printable characters
set list
if has('multi_byte') && &encoding ==# 'utf-8'
  let &listchars = 'tab:▸ ,extends:❯,precedes:❮,nbsp:±'
else
  let &listchars = 'tab:> ,extends:>,precedes:<,nbsp:.'
endif

" search highlighting
set hlsearch
set incsearch

" buffer's side column
set number
set numberwidth=4
set relativenumber
set signcolumn=yes

" completion
set completeopt=menu,preview,noselect

" current buffer information
set cmdheight=2
set display=lastline
set laststatus=2
set noshowmode
set report=0
set ruler
set shortmess=aFc
set showcmd
set title

" editing behaviour
set autoindent
set backspace=indent,eol,start
set expandtab
set shiftround
set shiftwidth=2
set smarttab
set softtabstop=2
set tabstop=2
set wrapscan

" buffer management
set hidden

" window splitting
set splitbelow
set splitright

" rendering performance
set lazyredraw
set synmaxcol=200

" backups
set updatetime=500
set backup
set backupdir=$HOME/.vim/files/backup/
set backupext=-vimbackup
set backupskip=
set directory=$HOME/.vim/files/swap/
set updatecount=100
set undofile
set undodir=$HOME/.vim/files/undo/

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" abbreviations
"""

" spelling errors
iabbrev adn and
iabbrev waht what
iabbrev tehn then

" shortcuts
iabbrev @@    me@geoffwhatley.com

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" neovim
"""

if has('nvim')
  " use the system version of python2 to avoid complexity of managing both
  " with `asdf`
  let g:python_host_prog = expand('/usr/bin/python2') 
  " explicitly use our `asdf` managed python version 
  let g:python3_host_prog = expand('~/.asdf/shims/python3') 
  
  " use our hacky root package.json installed neovim instead of the expected
  " global installation location
  let g:node_host_prog = expand('~/node_modules/neovim')
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" veonim
"""

if exists('veonim')
  let g:vn_font = 'Operator Mono'
  let g:vn_font_size = 14
  let g:vn_line_height = '1.5'
  let g:vn_explorer_ignore_dirs = ['.git', '.history']
  let g:vn_explorer_ignore_files = ['.DS_Store']
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" oni
"""

if exists('g:gui_oni')
  " oni specific
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" plugins via `vim-plug`
"""

" auto install `vim-plug`
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" cleaner conditional plugins via a custom function. example usage:
" Plug 'benekastah/neomake', Cond(has('nvim'), { 'on' 'Neomake' })
function! Cond(cond, ...)
  let opts = get(a:000, 0, {})
  return a:cond ? opts : extend(opts, { 'on': [], 'for': [] })
endfunction

call plug#begin('~/.vim/plugged')
  " behaviour
  Plug 'sheerun/vim-polyglot'
  " Plug 'jiangmiao/auto-pairs'
  " Plug 'tpope/vim-commentary'

  " searching
  Plug 'junegunn/fzf.vim'

  " autocomplete
  Plug 'tpope/vim-fugitive'
  Plug 'w0rp/ale'
  Plug 'neoclide/coc.nvim', { 'do': { -> coc#util#install() } }
  " Plug 'kabbamine/zeavim.vim'

  " editor ui
  Plug 'arcticicestudio/nord-vim'
  Plug 'cocopon/iceberg.vim'
  Plug 'itchyny/lightline.vim'
  Plug 'jeffkreeftmeijer/vim-numbertoggle'
  " Plug 'ap/vim-buftabline'

call plug#end()


" custom command to upgrade vim-plug after updating plugins
command! PU PlugUpdate | PlugUpgrade

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" coc.nvim
"""

" use tab for triggering completion and cycling through our completion list
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()

" use <S-TAB> for cycling backwards through the completion list if visible
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1] =~# '\s'
endfunction

" use <C-,> to trigger completion
inoremap <silent><expr> <C-,> coc#refresh()

" use <CR> to confirm completion if available, otherwise <C-g>u breaks our undo
" undo chain at the current position. CoC only does snippet insertion and
" editing on confirmation
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" use [c and ]c to navigate diagnostics
nnoremap <silent> [c <Plug>(coc-diagnostic-prev)
nnoremap <silent> ]c <Plug>(coc-diagnostic-next)

" remap keys for gotos
nnoremap <silent> gd <Plug>(coc-definition)
nnoremap <silent> gy <Plug>(coc-type-definition)
nnoremap <silent> gi <Plug>(coc-implementation)
nnoremap <silent> gr <Plug>(coc-references)

" use K to show the documentation in a preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim', 'help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" highlight symbol under the cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" remap for reaming the current word
nnoremap <leader>rn <Plug>(coc-rename)

" format the selection region
xnoremap <leader>f <Plug>(coc-format-selected)
nnoremap <leader>f <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  
  " setup formatexpr specific filetype(s)
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')

  " update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" run our codeAction of selected region, ex: `<leader>aap` for current
" paragraph
xnoremap <leader>a <Plug>(coc-codeaction-selected)
nnoremap <leader>a <Plug>(coc-codeaction-selected)

" run our codeAction on the current line
nnoremap <leader>ac <Plug>(coc-codeaction)

" autofix problem of the currnet line
nnoremap <leader>qf <Plug>(coc-fix-current)

" use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

"use `:Fold` to fold the current buffer
command! -nargs=? Fold :call CocAction('fold, <f-args>)

let g:lightline = {
  \ 'colorscheme': '16color',
  \ 'active': {
  \   'left': [ ['mode', 'paste'],
  \             ['cocstatus', 'readonly', 'filename', 'modified'] ]
  \ },
  \ 'component_function': {
  \   'cocstatus': 'coc#status'
  \ },
  \ }

" using CocList
" show all diagnostics
nnoremap <silent> ,a :<C-u>CocList diagnostics<CR>

" manage extensions
nnoremap <silent> ,c :<C-u>CocList extensions<CR>

" find symbol in current document
nnoremap <silent> ,e :<C-u>CocList outline<CR>

" search workspace symbols
nnoremap <silent> ,s :<C-u>CocList -I symbols<CR>

" do default action for next item
nnoremap <silent> ,j :<C-u>CocNext<CR>

" do default action for previous item
nnoremap <silent> ,k :<C-u>CocPrevious<CR>

" resume latest coc list
nnoremap <silent> ,p :<C-u>CocListResume<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" keymappings
"""

" remove our arrow key mappings
nnoremap <left>   <Nop>
nnoremap <down>   <Nop>
nnoremap <right>  <Nop>
nnoremap <up>     <Nop>
inoremap <left>   <Nop>
inoremap <down>   <Nop>
inoremap <right>  <Nop>
inoremap <up>     <Nop>

" load our vim config file for editing
nnoremap <leader>ev :vsplit $MYVIMRC<CR>

" reload our vim config
nnoremap <leader>sv :source $MYVIMRC<CR>

" keymappings for fzf.vim
nnoremap <C-f> :Files<CR>
nnoremap <C-g> :Rg<CR>

" shift lines up and down with - and _
" nnoremap <leader>_ ddp
" nnoremap <leader>- ddkkp

" uppercase the current word
" nnoremap <leader>u viw<S-u><ESC>
" inoremap <leader>u <ESC>viw<S-u><ESC>i

" quote the current word
nnoremap <leader>" viw<ESC>a"<ESC>bi"<ESC>lel
nnoremap <leader>' viw<ESC>a'<ESC>bi'<ESC>lel

colorscheme nord
