" Setting up plugins using dein.vim

let s:dein_dir = expand('~/.cache/dein')
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

if &runtimepath !~# '/dein.vim'
  if !isdirectory(s:dein_repo_dir)
    execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
  endif
  execute 'set runtimepath^=' . fnamemodify(s:dein_repo_dir, ':p')
endif

if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)

  call dein#add('Shougo/dein.vim')

  call dein#add('vim-airline/vim-airline', {'depends': ['vim-airline-themes']})
  call dein#add('vim-airline/vim-airline-themes')
  call dein#add('PeterRincker/vim-argumentative')
  call dein#add('tpope/vim-commentary', {'on_map': 'gc'})
  call dein#add('ctrlpvim/ctrlp.vim')
  call dein#add('Shougo/denite.nvim')
  call dein#add('Shougo/deoplete.nvim')
  call dein#add('zchee/deoplete-jedi', {'depends': 'deoplete'})
  call dein#add('tbodt/deoplete-tabnine', {'build': './install.sh'})
  call dein#add('ryanoasis/vim-devicons')
  call dein#add('dracula/vim', {'name': 'dracula'})
  call dein#add('Lokaltog/vim-easymotion', {'on_map': '<Plug>(easymotion'})
  call dein#add('tommcdo/vim-exchange', {'on_map' : {'n' : 'cx', 'x' : 'X'}})
  call dein#add('Konfekt/FastFold')
  call dein#add('tpope/vim-fugitive')
  call dein#add('rbong/vim-flog')
  call dein#add('airblade/vim-gitgutter')
  call dein#add('junegunn/goyo.vim', {'on_cmd': ['Goyo']})
  call dein#add('vim-scripts/IndexedSearch')
  call dein#add('rjayatilleka/vim-insert-char', {'on_map': {'n': '<space>'}})
  call dein#add('davidhalter/jedi-vim', {'on_ft': 'python'})
  call dein#add('Glench/Vim-Jinja2-Syntax', {'on_ft': 'jinja'})
  call dein#add('elzr/vim-json', {'on_ft': 'json'})
  call dein#add('AndrewRadev/linediff.vim', {'on_cmd': ['Linediff', 'LinediffMerge']})
  call dein#add('terryma/vim-multiple-cursors', {'on_map': ['<F6>', 'g<c-n>']})
  call dein#add('simnalamburt/vim-mundo')
  call dein#add('Shougo/neomru.vim', {'depends': 'denite'})
  call dein#add('kassio/neoterm')
  call dein#add('Shougo/neoyank.vim', {'depends': 'denite'})
  call dein#add('scrooloose/nerdtree', {'on_cmd': ['NERDTree', 'NERDTreeToggle']})
  call dein#add('Xuyuanp/nerdtree-git-plugin', {'depends': 'nerdtree'})
  call dein#add('arcticicestudio/nord-vim')
  call dein#add('tmsvg/pear-tree', {'on_event': 'InsertEnter'})
  call dein#add('python-mode/python-mode', {'rev': 'develop', 'on_ft': 'python'})
  call dein#add('tpope/vim-repeat', {'on_map' : '.'})
  call dein#add('dahu/SearchParty')
  call dein#add('tmhedberg/SimpylFold', {'on_ft': 'python'})
  call dein#add('mhinz/vim-startify')
  call dein#add('lambdalisue/suda.vim')
  call dein#add('tpope/vim-surround', {'on_map': {'n' : ['cs', 'ds', 'ys'], 'x' : 'S'}, 'depends' : 'vim-repeat'})
  call dein#add('wellle/targets.vim')
  call dein#add('bronson/vim-trailing-whitespace')
  call dein#add('tpope/vim-unimpaired')
  call dein#add('tmux-plugins/vim-tmux')
  call dein#add('christoomey/vim-tmux-navigator')
  call dein#add('jmcantrell/vim-virtualenv', {'on_ft': 'python'})

  call dein#end()

  call dein#remote_plugins()
  call dein#save_state()
endif

if dein#check_install()
  call dein#install()
endif

filetype off
filetype plugin indent on
syntax on


"" Remapping <leader>

let mapleader = ","
let maplocalleader = "`"


"" Setting options

" Better copy & paste
set pastetoggle=<F2>
if system('uname -s') == "Darwin\n"
  set clipboard-=unnamedplus
else
  set clipboard+=unnamedplus
endif

" Open all new splits on the right and below
set splitright
set splitbelow

" Mouse
set mouse=a

" Sane backspace
set bs=2

" Lets go wild
set wildmenu
set wildmode=full

set history=700
set undolevels=700

" Tab and space formatting
set tabstop=4
set softtabstop=4
set shiftwidth=4
set shiftround
set expandtab

" Search
set hlsearch
set incsearch
set ignorecase
set smartcase

" No backups
set nobackup
set nowritebackup
set noswapfile

set updatetime=2000

" Displaying line wrap
set showbreak=↪

" Line numbers
set number
set tw=80
set nowrap
set fo-=t

set completeopt=longest,menuone

set nofoldenable

set relativenumber

" Colors
let $NVIM_TUI_ENABLE_TRUE_COLOR=1
" set termguicolors
let g:nord_italic = 1
let g:nord_underline = 1
let g:nord_italic_comments = 1
let g:nord_uniform_diff_background = 1
let g:nord_bold_vertical_split_line = 1
color nord

set colorcolumn=+1
hi ColorColumn guibg=#323642
" Reverse IncSearch to have better highlighting with SearchParty.
hi clear IncSearch
hi IncSearch cterm=reverse gui=reverse
hi TermCursorNC guifg=#2e997b guibg=#2e997b cterm=reverse gui=reverse

"" Mappings

" A logical mapping for 'Y'
nnoremap Y y$

" To change : to ; to make life easier
nnoremap ; :
vnoremap ; :

" And the reverse because that is used for repeating the last 'f' search
nnoremap : ;
vnoremap : ;

" Python specific mapping
if system('uname -s') == "Darwin\n"
  " OSX
  " iterm2 cant capture control+enter
  " so change the profile by adding a key mapping that would send `Alt/Meta + c`
  " on pressing `Ctrl + Enter`
  "inoremap <C-M> <Esc>o
  inoremap <Leader><M-c> <Esc>A:<Esc>o
  nnoremap <Leader><M-c> A:<Esc>o
else
  inoremap <C-J> <Esc>o
  inoremap <Leader><C-J> <Esc>A:<Esc>o
  nnoremap <Leader><C-J> A:<Esc>o
endif
" enter spaces after comma to avoid E231
" %s/,\([^\s ]\)/, \1/g

" Adding parameters to functions
nnoremap <leader>i i,<space>
nnoremap <leader>a a,<space>

" Quicksave command
noremap <C-Z> :update<CR>
vnoremap <C-Z> <C-C>:update<CR>
inoremap <C-Z> <C-O>:update<CR>

" Paste the selected text after the last line of the selected text
" This is useful in the visual line mode
vnoremap <leader>p y`>p

" Quick movements
nnoremap H ^
nnoremap L g_
vnoremap H ^
vnoremap L g_

" Quick quit command
noremap <Leader>e :quit<CR>
noremap <Leader>E :q!<CR>
noremap <Leader>q :qa<CR>
noremap <Leader>Q :qa!<CR>

" Bind Ctrl+<movement> keys to move around the windows
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-l> <c-w>l
nnoremap <c-h> <c-w>h

" Now you can use Ctrl+w then h/j/k/l for shifting splits around
nnoremap <c-w>j <c-w>J
nnoremap <c-w>k <c-w>K
nnoremap <c-w>l <c-w>L
nnoremap <c-w>h <c-w>H

" Shift the rest of the line up or down
nnoremap <Leader>o Do<C-R>"<Esc>
nnoremap <Leader>O DO<C-R>"<Esc>

" Open all buffers as tabs
nnoremap <Leader>t :tab all<CR>

" Open all buffers as vertical splits
nnoremap <Leader>v :vert ba<CR>

" Jump to the next occurance of the character under the cursor
nnoremap <Leader>f yl:normal f<C-r>"<CR>

" A saner approach to horizontal scrolling
nnoremap <A-l> zl
nnoremap <A-h> zh<c-h>

nnoremap Q @q

vnoremap < <gv
vnoremap > >gv

nmap gV `[v`]

map! <C-F> <Esc>gUiw`]a

" Save a file that has been openned without root permission and requires it
" cnoremap w!! w !sudo tee > /dev/null %
cnoremap w!! w suda://%

" Swapping <c-p> with <up> in ex mode (and the companions)
cnoremap <c-p> <up>
cnoremap <up> <c-p>
cnoremap <c-n> <down>
cnoremap <down> <c-n>

" Tab navigation
nnoremap <Leader>n <esc>:tabprevious<CR>
nnoremap <Leader>m <esc>:tabnext<CR>

" Python toggle True/False
nnoremap <Leader><Leader>t ciwTrue<Esc>
nnoremap <Leader><Leader>f ciwFalse<Esc>

" Terminal mode
tnoremap <Esc> <C-\><C-n>
tnoremap ,n <C-\><C-n>:tabprevious<CR>
tnoremap ,m <C-\><C-n>:tabnext<CR>


"" Autocmds

" Automatic reloading of .vimrc
autocmd! bufwritepost ~/.config/nvim/init.vim source %

" Place the cursor at the same position that it was at before the previous exit
au BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exe "norm $"|endif|endif

" Open help in a right vertical split
autocmd FileType help wincmd L

" Quick exit from quickfix
autocmd FileType qf silent! nnoremap <buffer> q :q<CR>

" Quick exit from quickfix
autocmd FileType qf set switchbuf+=usetab,newtab

" Format JSON files
au FileType json exe ":silent %! python -m json.tool"

" Format XML files
au FileType xml exe ":silent 1,$!xmllint --format --recover - 2>/dev/null"

" LaTex options
autocmd FileType plaintex set fo+=t
autocmd FileType plaintex setlocal spell spelllang=en_us

" Enter insert on terminal buffer
au BufEnter * if &buftype == 'terminal' | :startinsert | endif

" disable tabNine for init.vim
autocm FileType vim
  \ call deoplete#custom#option('ignore_sources', {'_': ['tabnine']})


"" Custom functionality

" Navigation to the last visited tab
let g:lasttab = 1
nnoremap <leader>z :exec "tabn ".g:lasttab<CR>
au TabLeave * let g:lasttab = tabpagenr()

" Replace the current 'word' (variable name) with the content of the defualt
" register and retain that in the default register.
function! PasteWithRetain(mode)
  if a:mode == 'n'
    normal! viw
  elseif a:mode == 'v'
    normal! gv
  endif
  if col(".") == col("$") - 1
    normal! "_dp
  else
    normal! "_dP
  endif
endfunction
nnoremap <localleader>p :call PasteWithRetain('n')<CR>
vnoremap <localleader>p :call PasteWithRetain('v')<CR>

" to wrap text, use ' :Wrap '
command! -nargs=* Wrap set wrap linebreak nolist

" Jump to the next or previous line that has the same level or a lower
" level of indentation than the current line.
"
" exclusive (bool)  :  true: Motion is exclusive
"                      false: Motion is inclusive
" fwd (bool)        :  true: Go to next line
"                      false: Go to previous line
" lowerlevel (bool) :  true: Go to line with lower indentation level
"                      false: Go to line with the same indentation level
" skipblanks (bool) :  true: Skip blank lines
"                      false: Don't skip blank lines
function! NextIndent(exclusive, fwd, lowerlevel, skipblanks)
  let line = line('.')
  let column = col('.')
  let lastline = line('$')
  let indent = indent(line)
  let stepvalue = a:fwd ? 1 : -1
  while (line > 0 && line <= lastline)
    let line = line + stepvalue
    if ( ! a:lowerlevel && indent(line) == indent ||
          \ a:lowerlevel && indent(line) < indent)
      if (! a:skipblanks || strlen(getline(line)) > 0)
        if (a:exclusive)
          let line = line - stepvalue
        endif
        exe line
        exe "normal " column . "|"
        return
      endif
    endif
  endwhile
endfunction

" Moving back and forth between lines of same or lower indentation.
nnoremap <silent> <leader>k :call NextIndent(0, 0, 0, 1)<CR>
nnoremap <silent> <leader>j :call NextIndent(0, 1, 0, 1)<CR>
vnoremap <silent> <leader>k <Esc>:call NextIndent(0, 0, 0, 1)<CR>m'gv''
vnoremap <silent> <leader>j <Esc>:call NextIndent(0, 1, 0, 1)<CR>m'gv''
onoremap <silent> <leader>k :call NextIndent(0, 0, 0, 1)<CR>
onoremap <silent> <leader>j :call NextIndent(0, 1, 0, 1)<CR>


" -----------------------------------------------------------------------------
" Plugin specific config
"------------------------------------------------------------------------------

" airline
let g:airline_theme='nord'
let g:airline_powerline_fonts=1
let g:airline_inactive_collapse=0
let g:airline#extensions#hunks#enabled = 0
let g:airline#extensions#tabline#enabled=1
let g:airline#extensions#tabline#show_buffers = 0
let g:airline#extensions#tabline#tab_nr_type=2
let g:airline#extensions#tabline#show_splits=1
let g:airline#extensions#tabline#show_close_button=0
let g:airline#extensions#tabline#excludes = ['term://']

" ctrlp
let g:ctrlp_max_height = 15
set wildignore+=*.pyc

" denite
autocmd FileType denite call s:denite_settings()
function! s:denite_settings() abort
  nnoremap <silent><buffer><expr> <CR> denite#do_map('do_action')
  nnoremap <silent><buffer><expr> <tab> denite#do_map('choose_action')
  nnoremap <silent><buffer><expr> o denite#do_map('do_action', 'open')
  nnoremap <silent><buffer><expr> q denite#do_map('quit')
  nnoremap <silent><buffer><expr> i denite#do_map('open_filter_buffer')
  nnoremap <silent><buffer><expr> t denite#do_map('do_action', 'tabswitch')
  nnoremap <silent><buffer><expr> v denite#do_map('do_action', 'vsplit')
  nnoremap <silent><buffer><expr> s denite#do_map('do_action', 'split')
  nnoremap <nowait> <silent><buffer><expr> y denite#do_map('do_action', 'yank')
  nnoremap <silent><buffer><expr> <Space> denite#do_map('toggle_select').'j'
endfunction

autocmd FileType denite-filter call s:denite_filter_settings()
function! s:denite_filter_settings() abort
  imap <silent><buffer> <C-o> <Plug>(denite_filter_quit)
  inoremap <silent><buffer><expr> <C-i> denite#do_map('do_action')

  call deoplete#custom#buffer_option('auto_complete', v:false)
endfunction

call denite#custom#kind('file', 'default_action', 'tabopen')

call denite#custom#var('grep', 'command', ['ag'])
call denite#custom#var('grep', 'default_opts', ['-i', '--vimgrep'])
call denite#custom#var('grep', 'recursive_opts', [])
call denite#custom#var('grep', 'pattern_opt', [])
call denite#custom#var('grep', 'separator', ['--'])
call denite#custom#var('grep', 'final_opts', [])

call denite#custom#filter('matcher_ignore_globs', 'ignore_globs',
  \ [ '.git/', '.ropeproject/', '__pycache__/*', '*.pyc', 'node_modules/',
  \   'venv/', 'images/', '*.min.*', 'img/', 'fonts/', '*.png'])

call denite#custom#var('file/rec', 'command',
  \ ['ag', '--follow', '--nocolor', '--nogroup', '-g', ''])

call denite#custom#option('_',
  \ {
  \   'statusline': v:false,
  \   'vertical_preview': v:true,
  \   'direction': 'botright',
  \   'split': 'floating_relative_cursor',
  \   'winwidth': &columns / 1.5,
  \   'prompt': '❯',
  \ })

nnoremap <silent><LocalLeader>r :<C-u>Denite -resume -refresh<CR>
nnoremap <silent><LocalLeader>f :<C-u>Denite -start-filter file/rec file_mru<CR>
nnoremap <silent><LocalLeader>h :<C-u>Denite -start-filter file/rec:~/devbench/<CR>
nnoremap <silent><LocalLeader>b :<C-u>Denite -default_action=tabswitch buffer<CR>
nnoremap <silent><LocalLeader>y :<C-u>Denite -default-action=append neoyank<CR>
nnoremap <silent><LocalLeader>c :<C-u>Denite command_history<CR>
nnoremap <silent><LocalLeader>g :<C-u>DeniteCursorWord -default_action=tabswitch grep:.<CR>

function! Denite_vgrep(search_string)
  let l:escaped_str = substitute(a:search_string, " ", "\\\\\\\\s", "g")
  exec 'Denite -default_action=tabswitch grep:.:-Q:'.l:escaped_str
endfunction
vnoremap <silent><LocalLeader>g y:call Denite_vgrep('<C-R><C-R>"')<CR>

" deoplete
let g:deoplete#enable_at_startup = 1
call deoplete#custom#option('smart_case', v:true)
" for auto selection of the first menu entry
set completeopt+=noinsert
" auto delimiter (for example in paths) and removing auto-paranthesis addition
call deoplete#custom#source('_', 'converters',
    \ ['converter_auto_delimiter', 'converter_remove_paren', 'converter_remove_overlap'])
" fully fuzzy matching
call deoplete#custom#source('_', 'matchers',
    \ ['matcher_length', 'matcher_full_fuzzy'])
inoremap <expr><C-g>     deoplete#undo_completion()
inoremap <expr><C-l>     deoplete#refresh()
inoremap <silent><expr> <TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <silent><expr> <S-TAB> pumvisible() ? "\<C-p>" : "\<S-TAB>"

" if you dont want deoplete to intrude on your editing, you can disable it on
" startup (use the option above) and use the following mapping to trigger it
" with <TAB>
" inoremap <silent><expr> <TAB>
"     \ pumvisible() ? "\<C-n>" :
"     \ <SID>check_back_space() ? "\<TAB>" :
"     \ deoplete#mappings#manual_complete()
" function! s:check_back_space() abort "{{{
"     let col = col('.') - 1
"     return !col || getline('.')[col - 1]  =~ '\s'
" endfunction"}}}

" easymotion
let g:EasyMotion_do_mapping = 0
let g:EasyMotion_smartcase = 1
nmap <leader>s <Plug>(easymotion-s2)
vmap <leader>s <Plug>(easymotion-s2)
nmap <localleader>j <Plug>(easymotion-j)
vmap <localleader>j <Plug>(easymotion-j)
nmap <localleader>k <Plug>(easymotion-k)
vmap <localleader>k <Plug>(easymotion-k)
nmap <leader><leader>n <Plug>(easymotion-next)
vmap <leader><leader>n <Plug>(easymotion-next)
nmap <leader><leader>p <Plug>(easymotion-prev)
vmap <leader><leader>p <Plug>(easymotion-prev)

" FastFold
let g:vimsyn_folding = 'af'
let g:xml_syntax_folding = 1
let g:javaScript_fold = 1
let g:sh_fold_enabled= 7
let g:ruby_fold = 1
let g:r_syntax_folding = 1
nmap <F5> <Plug>(FastFoldUpdate)

" goyo
let g:goyo_width = 100
function! s:goyo_enter()
  let b:quitting = 0
  let b:quitting_bang = 0
  autocmd QuitPre <buffer> let b:quitting = 1
  cabbrev <buffer> q! let b:quitting_bang = 1 <bar> q!
endfunction

function! s:goyo_leave()
  " Quit Vim if this is the only remaining buffer
  if b:quitting && len(filter(range(1, bufnr('$')), 'buflisted(v:val)')) == 1
    if b:quitting_bang
      qa!
    else
      qa
    endif
  endif
endfunction

autocmd! User GoyoEnter call <SID>goyo_enter()
autocmd! User GoyoLeave call <SID>goyo_leave()

" jedi-vim
set noshowmode
let g:jedi#use_splits_not_buffers = "right"
" let g:jedi#use_tabs_not_buffers = 1
let g:jedi#show_call_signatures = "2"
let g:jedi#usages_command = "<leader>ju"
let g:jedi#goto_command = "<leader>jc"
let g:jedi#goto_assignments_command = "<leader>ja"
let g:jedi#documentation_command = "<leader>jd"
let g:jedi#goto_stubs_command = ""
" disable jedi completions since deoplete-jedi handles that
let g:jedi#completions_enabled=0

" multiple_cursors
let g:multi_cursor_use_default_mapping=0
let g:multi_cursor_start_key='<F6>'
let g:multi_cursor_start_word_key='g<C-n>'
let g:multi_cursor_next_key='<C-n>'
let g:multi_cursor_prev_key='<C-p>'
let g:multi_cursor_skip_key='<C-x>'
let g:multi_cursor_quit_key='<Esc>'

" neoterm
let g:neoterm_autoinsert=1
let g:neoterm_default_mod='vertical'
nnoremap <S-F5> :w<CR>:T python %<CR>
nnoremap <S-F6> :w<CR>:T ptipython -i %<CR>
nnoremap <S-F7> :w<CR>:T ptipython<CR>
nnoremap <S-F8> :w<CR>:Topen<CR>
nnoremap <localleader>t :tab Tnew<CR>

" nerdtree
" `:NERDTreeFind` to locate the file in the dir tree
" `:NERDTree %` to open the dir tree that the current file is in
nnoremap <localleader>n :NERDTreeToggle<CR>
nnoremap <localleader>m :NERDTree %<CR>
let NERDTreeIgnore = ['\~$', '\.pyc$']

" pear-tree
let g:pear_tree_smart_openers = 1
let g:pear_tree_smart_closers = 1
let g:pear_tree_smart_backspace = 1
let g:pear_tree_repeatable_expand = 0
imap <M-n> <Plug>(PearTreeJump)

" python-mode
let g:pymode_rope = 0
let g:pymode_doc = 0
let g:pymode_python = 'python3'
let g:pymode_lint_ignore = ["E501", "E302"]
let g:pymode_lint_checkers = ['pyflakes', 'pep8']
let g:pymode_breakpoint = 0
let g:pymode_syntax = 1

" SearchParty
let g:searchparty_load_user_maps = 0
let g:searchparty_visual_find_sets_search = 2
nmap <silent> <C-t>                <Plug>SearchPartyHighlightToggle
nmap <silent> <c-n>                <Plug>SearchPartyHighlightClear
nmap <silent> <leader>rm           <Plug>SearchPartyMultipleReplace
nmap <silent> <leader>*            <Plug>SearchPartyHighlightWord
nmap <silent> <leader>g*           <Plug>SearchPartyHighlightWORD
nmap <silent> z/                   <Plug>SearchPartyToggleAutoHighlightWord
nmap <silent> <leader><leader>/    <Plug>SearchPartySetSearch
xmap <silent> *                    <Plug>SearchPartyVisualFindNext
xmap <silent> #                    <Plug>SearchPartyVisualFindPrev
xmap          &                    <Plug>SearchPartyVisualSubstitute
nmap          <leader>fow          <Plug>SearchPartyMashFOWToggle


" source local settings
source ~/.config/nvim/local_config.vim
