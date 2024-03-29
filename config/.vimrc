" This config is targeted for Vim 8.0+ and expects you to have Plug installed.
" curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
"    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
" -----------------------------------------------------------------------------

" -----------------------------------------------------------------------------
" Plugins
" -----------------------------------------------------------------------------

" Specify a directory for plugins.
call plug#begin('~/.vim/plugged')

Plug '907th/vim-auto-save'
Plug 'djoshea/vim-autoread'
Plug 'vim-scripts/auto_autoread.vim'
Plug 'vitalstarorg/multiplayer.vim'

Plug 'godlygeek/tabular' | Plug 'plasticboy/vim-markdown'
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() } }
"Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app & yarn install' }

" Languages and file types.
"Plug 'chrisbra/csv.vim'
"Plug 'ekalinin/dockerfile.vim'
"Plug 'elixir-editors/vim-elixir'
"Plug 'elzr/vim-json'
"Plug 'Glench/Vim-Jinja2-Syntax'
"Plug 'lifepillar/pgsql.vim'
"Plug 'othree/html5.vim'
"Plug 'pangloss/vim-javascript'
"Plug 'tmux-plugins/vim-tmux'
"Plug 'tpope/vim-git'
"Plug 'vim-python/python-syntax'
"Plug 'vim-ruby/vim-ruby'
"Plug 'wgwoods/vim-systemd-syntax'

call plug#end()

" -----------------------------------------------------------------------------
" Status line
" -----------------------------------------------------------------------------

" Heavily inspired by: https://github.com/junegunn/dotfiles/blob/master/vimrc
function! s:statusline_expr()
  let mod = "%{&modified ? '[+] ' : !&modifiable ? '[x] ' : ''}"
  let ro  = "%{&readonly ? '[RO] ' : ''}"
  let ft  = "%{len(&filetype) ? '['.&filetype.'] ' : ''}"
  let fug = "%{exists('g:loaded_fugitive') ? fugitive#statusline() : ''}"
  let sep = ' %= '
  let pos = ' %-12(%l : %c%V%) '
  let pct = ' %P'

  return '[%n] %f %<'.mod.ro.ft.fug.sep.pos.'%*'.pct
endfunction

let &statusline = s:statusline_expr()
let &statusline .= multiplayer_statusline#Get()

" -----------------------------------------------------------------------------
" Color settings
" -----------------------------------------------------------------------------

"colorscheme gruvbox
colorscheme desert
" For Gruvbox to look correct in terminal Vim you'll want to source a palette
" script that comes with the Gruvbox plugin.
"
" Add this to your ~/.profile file:
"   source "$HOME/.vim/plugged/gruvbox/gruvbox_256palette.sh"

" Gruvbox comes with both a dark and light theme.
set background=dark

" Gruvbox has 'hard', 'medium' (default) and 'soft' contrast options.
let g:gruvbox_contrast_light='soft'

" This needs to come last, otherwise the colors aren't correct.
syntax on

" -----------------------------------------------------------------------------
" Basic Settings
"   Research any of these by running :help <setting>
" -----------------------------------------------------------------------------

"let mapleader=" "
"let maplocalleader=" "

"set autoindent
set autoread
set backspace=indent,eol,start
set backupdir=/tmp//,.
"set clipboard=unnamedplus
"set clipboard=unnamed
"set colorcolumn=80
set complete-=i
set completeopt=menuone,preview
set cryptmethod=blowfish2
set directory=/tmp//,.
set encoding=utf-8
set expandtab smarttab
set formatoptions=tcqrn1
set hidden
set hlsearch
set ignorecase
set incsearch
set laststatus=2
set lazyredraw
set matchpairs+=<:> " Use % to jump between pairs
set modelines=2
set mouse=r
set nocompatible
set noerrorbells visualbell t_vb=
set noshiftround
set nospell
set nostartofline
"set number relativenumber
set regexpengine=1
set ruler
set scrolloff=3
set shiftwidth=2
set showcmd
set showmatch
set showmode
set smartcase
set softtabstop=2
set spelllang=en_us
set splitbelow
set splitright
set tabstop=2
set textwidth=0
set ttimeout
set ttyfast
set ttymouse=sgr
set undodir=/tmp//,.
set virtualedit=block
set whichwrap=b,s,<,>
set wildmenu
set wildmode=full
set wrap

runtime! macros/matchit.vim

" -----------------------------------------------------------------------------
" MC customization
" -----------------------------------------------------------------------------
"set autoread | autocmd CursorHold * checktime | call feedkeys("lh")
set autoread | autocmd CursorHold * checktime

" automatically leave insert mode after 'updatetime' milliseconds of inaction
au CursorHoldI * stopinsert

" set 'updatetime' to 15 seconds when in insert mode
au InsertEnter * let updaterestore=&updatetime | set updatetime=15000
au InsertLeave * let &updatetime=updaterestore

function! SearchMdHeading(prefix)
  let heading = input('Heading: ')
  let term = a:prefix . heading
  "execute "normal! /".term."\<enter>"
  call search(term)
  "let @/ = term
  execute "normal! /^##* <CR>Nzt"
endfunction

let mapleader = "\\"
" nnoremap <Leader>[ :call SearchMdHeading("##\\s*")<CR>
nnoremap <leader>' :MarkdownPreview<CR>
nnoremap <leader>; :set number! relativenumber!<CR>
nnoremap <Leader>0 o<ESC>:. ! echo "\#\#\#\#" "$(date +'\%y\%m\%d')"<CR>
nnoremap <Leader>9 o<ESC>:. ! echo "\#\#\#\#" "$(date --date='next Sunday' +'\%y\%m\%d') >"<CR>
nnoremap <Leader>- o<ESC>:. ! open -a "Google Chrome"; cliclick kd:cmd t:dc ku:cmd kp:tab,tab,tab,space; echo -n "- [$(pbpaste)]"; cliclick kd:cmd t:lc ku:cmd; echo -n "($(pbpaste))"; cliclick kd:cmd kp:tab ku:cmd<CR><CR><CR>
nnoremap <Leader>= /```<CR>kmmN"*y'm:!c=$(pbpaste);h=$(echo "$c" \| head -1 \| sed -ne "s/\`\`\` *\(.*\)/\\1/p"); echo "$c" \| tail -n +2 \| $h<CR><CR>
  "trying to execute this block of code - in progress
nnoremap <Leader>\| :Vexplore!<CR>
nnoremap <Leader>[ :call SearchMdHeading("##*\\s*")<CR>
nnoremap <Leader>] :/#* >>>]<CR>/^###* <CR>Nztn
nnoremap <Leader>b o<ESC>i```bash<CR><CR>```<ESC>k
nnoremap <Leader>/ :.s/^\(\s*-\)\(.*\)/\1\~\~\2\~\~/<CR>:noh<CR>j
nnoremap <Leader>i :/#* >>>Inspiration<CR>/^###* <CR>Nzt

nnoremap <Leader><Right>
      \ :.w ! IFS= read -r line;
      \ c=$(echo $line \| sed -ne "s/^\#@\(.*\)/\\1/p");
      \ if [ -n "$c" ]; then eval "$c";
      \ else line=$(echo $line \| sed "s/;/\\\\;/g");
      \ eval 'tmux send-keys -t {right-of} "$line" C-m';
      \ fi;<CR><CR><Down>
nnoremap <Leader><Down>
      \ :.w ! IFS= read -r line;
      \ c=$(echo $line \| sed -ne "s/^\#@\(.*\)/\\1/p");
      \ if [ -n "$c" ]; then eval "$c";
      \ else line=$(echo $line \| sed "s/;/\\\\;/g");
      \ eval 'tmux send-keys -t {down-of} "$line" C-m';
      \ fi;<CR><CR><Down>
nnoremap <Leader><Up>
      \ :.w ! IFS= read -r line;
      \ c=$(echo $line \| sed -ne "s/^\#@\(.*\)/\\1/p");
      \ if [ -n "$c" ]; then eval "$c";
      \ else line=$(echo $line \| sed "s/;/\\\\;/g");
      \ eval 'tmux send-keys -t {up-of} "$line" C-m';
      \ fi;<CR><CR><Down>
nnoremap <Leader><Left>
      \ :.w ! IFS= read -r line;
      \ c=$(echo $line \| sed -ne "s/^\#@\(.*\)/\\1/p");
      \ if [ -n "$c" ]; then eval "$c";
      \ else line=$(echo $line \| sed "s/;/\\\\;/g");
      \ eval 'tmux send-keys -t {left-of} "$line" C-m';
      \ fi;<CR><CR><Down>

highlight Search cterm=NONE ctermfg=grey ctermbg=blue

" -----------------------------------------------------------------------------
" Basic mappings
" -----------------------------------------------------------------------------

" Seamlessly treat visual lines as actual lines when moving around.
noremap j gj
noremap k gk
noremap <Down> gj
noremap <Up> gk
inoremap <Down> <C-o>gj
inoremap <Up> <C-o>gk

" Navigate around splits with a single key combo.
nnoremap <C-l> <C-w><C-l>
nnoremap <C-h> <C-w><C-h>
nnoremap <C-k> <C-w><C-k>
nnoremap <C-j> <C-w><C-j>

" Cycle through splits.
nnoremap <S-Tab> <C-w>w

" Press * to search for the term under the cursor or a visual selection and
" then press a key below to replace all instances of it in the current file.
nnoremap <Leader>r :%s///g<Left><Left>
nnoremap <Leader>rc :%s///gc<Left><Left><Left>

" The same as above but instead of acting on the whole file it will be
" restricted to the previously visually selected range. You can do that by
" pressing *, visually selecting the range you want it to apply to and then
" press a key below to replace all instances of it in the current selection.
xnoremap <Leader>r :s///g<Left><Left>
xnoremap <Leader>rc :s///gc<Left><Left><Left>

" Type a replacement term and press . to repeat the replacement again. Useful
" for replacing a few instances of the term (comparable to multiple cursors).
nnoremap <silent> s* :let @/='\<'.expand('<cword>').'\>'<CR>cgn
xnoremap <silent> s* "sy:let @/=@s<CR>cgn

" Clear search highlights.
map <Leader><Space> :let @/=''<CR>

" Format paragraph (selected or not) to 80 character lines.
nnoremap <Leader>g gqap
xnoremap <Leader>g gqa

" Prevent x from overriding what's in the clipboard.
noremap x "_x
noremap X "_x

" Prevent selecting and pasting from overwriting what you originally copied.
xnoremap p pgvy

" Keep cursor at the bottom of the visual selection after you yank it.
"vmap y ygv<Esc>

" Eliminate issues where you accidentally hold shift for too long with :w.
command! W write

" Toggle spell check.
map <F5> :setlocal spell!<CR>

" Toggle quickfix window.
function! QuickFix_toggle()
    for i in range(1, winnr('$'))
        let bnum = winbufnr(i)
        if getbufvar(bnum, '&buftype') == 'quickfix'
            cclose
            return
        endif
    endfor

    copen
endfunction
nnoremap <silent> <Leader>c :call QuickFix_toggle()<CR>

" Convert the selected text's title case using the external tcc script.
"   Requires: https://github.com/nickjj/title-case-converter
vnoremap <Leader>tc c<C-r>=system('tcc', getreg('"'))[:-2]<CR>

" -----------------------------------------------------------------------------
" Basic autocommands
" -----------------------------------------------------------------------------

" Reduce delay when switching between modes.
augroup NoInsertKeycodes
  autocmd!
  autocmd InsertEnter * set ttimeoutlen=0
  autocmd InsertLeave * set ttimeoutlen=500
augroup END

" Auto-resize splits when Vim gets resized.
autocmd VimResized * wincmd =

" Update a buffer's contents on focus if it changed outside of Vim.
au FocusGained,BufEnter * :checktime

" Unset paste on InsertLeave.
autocmd InsertLeave * silent! set nopaste

" Make sure all types of requirements.txt files get syntax highlighting.
autocmd BufNewFile,BufRead requirements*.txt set syntax=python

" ----------------------------------------------------------------------------
" Basic commands
" ----------------------------------------------------------------------------

" Add all TODO items to the quickfix list relative to where you opened Vim.
function! s:todo() abort
  let entries = []
  for cmd in ['git grep -niIw -e TODO -e FIXME 2> /dev/null',
            \ 'grep -rniIw -e TODO -e FIXME . 2> /dev/null']
    let lines = split(system(cmd), '\n')
    if v:shell_error != 0 | continue | endif
    for line in lines
      let [fname, lno, text] = matchlist(line, '^\([^:]*\):\([^:]*\):\(.*\)')[1:3]
      call add(entries, { 'filename': fname, 'lnum': lno, 'text': text })
    endfor
    break
  endfor

  if !empty(entries)
    call setqflist(entries)
    copen
  endif
endfunction

command! Todo call s:todo()

" Profile Vim by running this command once to start it and again to stop it.
function! s:profile(bang)
  if a:bang
    profile pause
    noautocmd qall
  else
    profile start /tmp/profile.log
    profile func *
    profile file *
  endif
endfunction

command! -bang Profile call s:profile(<bang>0)

" -----------------------------------------------------------------------------
" Plugin settings, mappings and autocommands
" -----------------------------------------------------------------------------

" .............................................................................
" junegunn/fzf.vim
" .............................................................................

let $FZF_DEFAULT_OPTS = '--bind ctrl-a:select-all'

" Launch fzf with CTRL+P.
nnoremap <silent> <C-p> :FZF -m<CR>

" Map a few common things to do with FZF.
nnoremap <silent> <Leader><Enter> :Buffers<CR>
nnoremap <silent> <Leader>l :Lines<CR>

function! s:build_quickfix_list(lines)
  call setqflist(map(copy(a:lines), '{ "filename": v:val }'))
  copen
  cc
endfunction

" CTRL+Q (combined with CTRL+A) to put search results into the quickfix.
" CTRL+Y to copy the highlighted file path to the clipboard.
let g:fzf_action = {
  \ 'ctrl-q': function('s:build_quickfix_list'),
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit',
  \ 'ctrl-y': {lines -> setreg('*', join(lines, "\n"))}}

" .............................................................................
" scrooloose/nerdtree
" .............................................................................

let g:NERDTreeShowHidden=1
let g:NERDTreeAutoDeleteBuffer=1

" Open nerd tree at the current file or close nerd tree if pressed again.
nnoremap <silent> <expr> <Leader>n g:NERDTree.IsOpen() ? "\:NERDTreeClose<CR>" : bufexists(expand('%')) ? "\:NERDTreeFind<CR>" : "\:NERDTree<CR>"

" .............................................................................
" ntpeters/vim-better-whitespace
" .............................................................................

let g:strip_whitespace_confirm=1
let g:strip_whitespace_on_save=1

" .............................................................................
" Konfekt/FastFold
" .............................................................................

"let g:fastfold_savehook=1
"let g:fastfold_fold_command_suffixes =  ['x','X','a','A','o','O','c','C']
"let g:fastfold_fold_movement_commands = [']z', '[z', 'zj', 'zk']
"let g:markdown_folding = 1
"let g:tex_fold_enabled = 1
"let g:vimsyn_folding = 'af'
"let g:xml_syntax_folding = 1
"let g:javaScript_fold = 1
"let g:sh_fold_enabled= 7
"let g:ruby_fold = 1
"let g:perl_fold = 1
"let g:perl_fold_blocks = 1
"let g:r_syntax_folding = 1
"let g:rust_fold = 1
"let g:php_folding = 1

" .............................................................................
" plasticboy/vim-markdown
" .............................................................................

let g:vim_markdown_new_list_item_indent = 2
let g:vim_markdown_strikethrough = 1
"let g:vim_markdown_math = 1
let g:vim_markdown_folding_disabled = 1
autocmd FileType markdown let b:sleuth_automatic=0
autocmd FileType markdown set conceallevel=0
autocmd FileType markdown normal zR

let g:vim_markdown_frontmatter=1

" .............................................................................
" 907th/vim-auto-save/markdown-preview.nvim
" .............................................................................

let g:auto_save = 1  " enable AutoSave on Vim startup
let g:auto_save_silent = 0  " do not display the auto-save notification
let g:auto_save_events = ["InsertLeave", "TextChanged"]
let g:auto_save_write_all_buffers = 1  " write all open buffers as if you would use :wa

" .............................................................................
" iamcco/markdown-preview.nvim
" .............................................................................

let g:mkdp_refresh_slow=0
"let g:mkdp_markdown_css='/Users/man/.vim/wr-markdown.css'
let g:mkdp_port = $MD_PORT
let g:mkdp_auto_close = 0
let g:mkdp_echo_preview_url = 1
let g:mkdp_preview_options = {
    \ 'mkit': {},
    \ 'katex': {},
    \ 'uml': {},
    \ 'maid': {},
    \ 'disable_sync_scroll': 0,
    \ 'sync_scroll_type': 'relative',
    \ 'hide_yaml_meta': 1,
    \ 'sequence_diagrams': {},
    \ 'flowchart_diagrams': {}
    \ }

" .............................................................................
" rolf007/multiplayer.vim
" .............................................................................

let g:multiplayer_auto_connect = 'n'
let g:multiplayer_name = $USER
