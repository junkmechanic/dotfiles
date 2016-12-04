" Setting up plugins using dein.vim

if &compatible
  set nocompatible
endif

let s:dein_dir = expand('~/.cache/dein')
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'
let s:toml = '~/.config/nvim/dein.toml'
let s:lazy_toml = '~/.config/nvim/dein_lazy.toml'

if &runtimepath !~# '/dein.vim'
  if !isdirectory(s:dein_repo_dir)
    execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
  endif
  execute 'set runtimepath^=' . fnamemodify(s:dein_repo_dir, ':p')
endif

if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)

  call dein#load_toml(s:toml, {'lazy': 0})
  call dein#load_toml(s:lazy_toml, {'lazy': 0})

  call dein#end()
  call dein#save_state()
endif

if dein#check_install(['vimproc'])
  call dein#install(['vimproc'])
endif

if dein#check_install()
  call dein#install()
endif

filetype off
filetype plugin indent on
syntax on


"" Remapping <leader>

let mapleader = ","


"" Setting options

" Better copy & paste
set pastetoggle=<F2>
set clipboard+=unnamedplus

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
set colorcolumn=+1

set completeopt=longest,menuone

set nofoldenable

set relativenumber

" Colors
let $NVIM_TUI_ENABLE_TRUE_COLOR=1
set termguicolors
color onedark
hi ColorColumn guibg=#323642
" I dont like that onedark changes the IncSearch group. I prefer to have it
" reversed to have better highlighting with SearchParty.
hi clear IncSearch
hi IncSearch cterm=reverse gui=reverse


"" Mappings

" A logical mapping for 'Y'
nnoremap Y y$

" To change : to ; to make life easier
nnoremap ; :
vnoremap ; :

" And the reverse because that is used for repeating the last 'f' search
nnoremap : ;
vnoremap : ;

" Quick movements in insert mode <Potentially dangerous>
inoremap Ii <Esc>I
inoremap Aa <Esc>A
inoremap Oo <Esc>O
inoremap Cc <Esc>C
inoremap Ss <Esc>S
inoremap Dd <Esc>dd
inoremap Uu <Esc>u
inoremap <C-J> <Esc>o
" Python specific mapping
inoremap <Leader><C-J> <Esc>A:<Esc>o
nnoremap <Leader><C-J> A:<Esc>o

" Adding parameters to functions
nnoremap <leader>i i,<space>
nnoremap <leader>a a,<space>

" Open a new line and stay in Normal mode. (Gives a meaning to Enter as well)
" It has been reported that this might interfere with the command line normal
" mode. Since I havent faced any problems with it as yet, I dont mind keeping
" this mapping. In case, that ever needs to be done, possibly the expr should
" be used (see below for example) along with the modes that need to be
" excluded (check http://vimdoc.sourceforge.net/htmldoc/eval.html#mode())
"nnoremap <Leader><CR> O<Esc>
nnoremap <CR> o<Esc>

" Quicksave command
noremap <C-Z> :update<CR>
vnoremap <C-Z> <C-C>:update<CR>
inoremap <C-Z> <C-O>:update<CR>

" Paste the selected text after the last line of the selected text
" This is useful in the visual line mode
vnoremap <leader>P y`>p

" Delete to buffer 'd' instead of the default buffer
nnoremap <expr> <leader>dw (v:register == '+') ? '"ddw' : '"'.v:register.'dw'
nnoremap <expr> <leader>dd (v:register == '+') ? '"ddd' : '"'.v:register.'dd'
vnoremap <expr> <leader>d (v:register == '+') ? '"dd' : '"'.v:register.'d'

" Quick movements
nnoremap H ^
nnoremap L g_
nnoremap J 6j
nnoremap K 6k

" Quick quit command
noremap <Leader>e :quit<CR>  " Quit current window
noremap <Leader>E :q!<CR>    " Quit current window without saving
noremap <Leader>q :qa<CR>    " Quit all windows
noremap <Leader>Q :qa!<CR>   " Quit all windows window saving

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

" Jump to the next occurance of the character under the cursor
nnoremap <Leader>f yl:normal f<C-r>"<CR>

" A saner approach to horizontal scrolling
nnoremap <A-l> zl
nnoremap <A-h> zh<c-h>

vnoremap < <gv
vnoremap > >gv

" Save a file that has been openned without root permission and requires it
cnoremap w!! w !sudo tee > /dev/null %

" Tab navigation
nnoremap <Leader>n <esc>:tabprevious<CR>
nnoremap <Leader>m <esc>:tabnext<CR>

" Python toggle True/False
nnoremap <Leader><Leader>t ciwTrue<Esc>
nnoremap <Leader><Leader>f ciwFalse<Esc>

" Terminal mode
tnoremap <Esc> <C-\><C-n>


"" Autocmds

" Automatic reloading of .vimrc
autocmd! bufwritepost ~/.config/nvim/init.vim source %

" Place the cursor at the same position that it was at before the previous exit
au BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exe "norm $"|endif|endif

" Open help in a right vertical split
autocmd FileType help wincmd L

" Since the quickfix window is not modifiable, the global mapping for <CR>
" overwrites the default quickfix <CR> behaviour to jump to the specified
" line/buffer. So the following buffer local mapping would remap <CR> to behave
" as intended.
autocmd FileType qf silent! nnoremap <buffer> <CR> <CR>

" Quick exit from quickfix
autocmd FileType qf silent! nnoremap <buffer> q :q<CR>

" Format JSON files
au FileType json exe ":silent %! python -m json.tool"

" Format XML files
au FileType xml exe ":silent 1,$!xmllint --format --recover - 2>/dev/null"

" LaTex options
autocmd FileType plaintex set fo+=t
autocmd FileType plaintex set spell spelllang=en_us

" Enter insert on terminal buffer
au BufEnter * if &buftype == 'terminal' | :startinsert | endif


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
nnoremap <leader>p :call PasteWithRetain('n')<CR>
vnoremap <leader>p :call PasteWithRetain('v')<CR>

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
nnoremap <silent> <leader>K :call NextIndent(0, 0, 1, 1)<CR>
nnoremap <silent> <leader>J :call NextIndent(0, 1, 1, 1)<CR>
vnoremap <silent> <leader>k <Esc>:call NextIndent(0, 0, 0, 1)<CR>m'gv''
vnoremap <silent> <leader>j <Esc>:call NextIndent(0, 1, 0, 1)<CR>m'gv''
vnoremap <silent> <leader>K <Esc>:call NextIndent(0, 0, 1, 1)<CR>m'gv''
vnoremap <silent> <leader>J <Esc>:call NextIndent(0, 1, 1, 1)<CR>m'gv''
onoremap <silent> <leader>k :call NextIndent(0, 0, 0, 1)<CR>
onoremap <silent> <leader>j :call NextIndent(0, 1, 0, 1)<CR>
onoremap <silent> <leader>K :call NextIndent(1, 0, 1, 1)<CR>
onoremap <silent> <leader>J :call NextIndent(1, 1, 1, 1)<CR>


" -----------------------------------------------------------------------------
" Plugin specific config
"------------------------------------------------------------------------------

" airline config
let g:airline_theme='onedark'
let g:airline#extensions#tabline#enabled=1
let g:airline_powerline_fonts=1
let g:airline#extensions#tabline#tab_nr_type=2
let g:airline#extensions#tabline#show_splits=1
let g:airline_inactive_collapse=0
let g:airline#extensions#tabline#show_close_button=0
let g:airline#extensions#tabline#excludes = ['term://']

" For autopairs flymode activation
let g:AutoPairsFlyMode = 1
let g:AutoPairsShortcutToggle = ''
" The shortcuts for autopairs
" <CR>  : Insert new indented line after return if cursor in blank brackets or quotes.
" <BS>  : Delete brackets in pair
" <M-p> : Toggle Autopairs (g:AutoPairsShortcutToggle)
" <M-e> : Fast Wrap (g:AutoPairsShortcutFastWrap)
" <M-n> : Jump to next closed pair (g:AutoPairsShortcutJump)
" <M-b> : BackInsert (g:AutoPairsShortcutBackInsert)

" Settings for ctrlp
let g:ctrlp_max_height = 15
set wildignore+=*.pyc
nnoremap <leader><C-p> :CtrlPMRU<CR>

" deoplete options
let g:deoplete#enable_at_startup = 1
let g:deoplete#enable_smart_case = 1
" for auto selection of the first menu entry
set completeopt+=noinsert
" auto delimiter (for example in paths) and removing auto-paranthesis addition
call deoplete#custom#set('_', 'converters', ['converter_auto_delimiter', 'converter_remove_paren', 'converter_remove_overlap'])
" fully fuzzy matching
call deoplete#custom#set('_', 'matchers', ['matcher_length', 'matcher_full_fuzzy'])
inoremap <silent><expr> <TAB> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <silent><expr> <S-TAB> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr><C-g>     deoplete#undo_completion()
inoremap <expr><C-l>     deoplete#refresh()
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function() abort
  return pumvisible() ? deoplete#close_popup() : "\<CR>"
endfunction
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

" dragvisuals
vmap  <expr>  <LEFT>   DVB_Drag('left')
vmap  <expr>  <RIGHT>  DVB_Drag('right')
vmap  <expr>  <DOWN>   DVB_Drag('down')
vmap  <expr>  <UP>     DVB_Drag('up')

" easymotion options
let g:EasyMotion_smartcase = 1
nmap s <Plug>(easymotion-s2)
vmap s <Plug>(easymotion-s2)
nmap <leader><leader>n <Plug>(easymotion-next)
vmap <leader><leader>n <Plug>(easymotion-next)
nmap <leader><leader>p <Plug>(easymotion-prev)
vmap <leader><leader>p <Plug>(easymotion-prev)

" fakeclip options
let g:vim_fakeclip_tmux_plus=1

" hardtime on startup
let g:hardtime_default_on = 1
let g:hardtime_maxcount = 2
let g:hardtime_ignore_buffer_patterns = ["NERD.*"]
let g:hardtime_ignore_quickfix = 1
let g:hardtime_allow_different_key = 1

" use Space and any character to insert that character at the position of the
" cursor. Enter a number before spcae to include that many characters.
nnoremap <SPACE> :<C-U>call InsertChar#insert(v:count1)<CR>

" jedi-vim options
set noshowmode
let g:jedi#use_splits_not_buffers = "right"
let g:jedi#show_call_signatures = "2"
let g:jedi#usages_command = "<leader>ju"
let g:jedi#goto_command = "<leader>jc"
let g:jedi#goto_assignments_command = "<leader>ja"
let g:jedi#documentation_command = "<leader>jd"
" disable jedi completions since deoplete-jedi handles that
let g:jedi#completions_enabled=0

" Multiple cursors setup
let g:multi_cursor_use_default_mapping=0
let g:multi_cursor_start_key='<F6>'
let g:multi_cursor_start_word_key='g<C-n>'
let g:multi_cursor_next_key='<C-n>'
let g:multi_cursor_prev_key='<C-p>'
let g:multi_cursor_skip_key='<C-x>'
let g:multi_cursor_quit_key='<Esc>'

" neoterm options
let g:neoterm_position='vertical'
let g:neoterm_autoinsert=1
nnoremap <S-F5> :w<CR>:T python %<CR>
nnoremap <S-F6> :w<CR>:T ptipython -i %<CR>
nnoremap <S-F7> :w<CR>:T ptipython<CR>
nnoremap <S-F8> :w<CR>:Topen<CR>
function! SendToNeoterm(mode)
  if len(g:neoterm.instances) == 1
    exec 'TREPLSetTerm 1'
  endif
  if a:mode == 'n'
    exec 'TREPLSendLine'
  elseif a:mode == 'v'
    exec 'TREPLSendSelection'
  endif
endfunction
nnoremap <leader>s :call SendToNeoterm('n')<CR>
vnoremap <leader>s :call SendToNeoterm('v')<CR>

" NERDTree options
nnoremap <leader><C-n> :NERDTreeToggle<CR>
let NERDTreeIgnore = ['\~$', '\.pyc$']

" Settings for python-mode
let g:pymode_rope = 0
let g:pymode_doc = 0
let g:pymode_lint_ignore = "E501,E302"
let g:pymode_lint_checkers = ['pyflakes', 'pep8']
let g:pymode_breakpoint = 0
let g:pymode_syntax = 1
let g:pymode_syntax_builtin_objs = 0
let g:pymode_syntax_builtin_funcs = 0
let g:pymode_run_bind = "<S-e>"

" SearchParty options
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

" Unite options
autocmd FileType unite call s:unite_my_settings()
function! s:unite_my_settings()
  imap <buffer> jj <Plug>(unite_insert_leave)
  imap <buffer> qq <Plug>(unite_exit)
  nnoremap <buffer><expr> s unite#smart_map('v', unite#do_action('vsplit'))
endfunction
function! Unite_vgrep(search_string, auto)
  let l:escaped_str = substitute(a:search_string, " ", "\\\\\\\\s", "g")
  if a:auto
    exec 'Unite -buffer-name=vgrep_auto -default-action=tabopen grep:.:-iHn:'.l:escaped_str
  else
    exec 'Unite -buffer-name=vgrep -default-action=tabopen grep::-iHn:'.l:escaped_str
  endif
endfunction
nnoremap <leader>uf :Unite -buffer-name=file_rec -default-action=tabopen -start-insert file_rec/neovim<CR>
nnoremap <leader>uh :Unite -buffer-name=file_rec -default-action=tabopen -start-insert file_rec/neovim:/home/ankur/<CR>
nnoremap <leader>um :Unite -buffer-name=mru -default-action=tabopen -start-insert neomru/file<CR>
nnoremap <leader>uy :Unite -buffer-name=yank -default-action=append history/yank<CR>
nnoremap <leader>ug :Unite -buffer-name=grep_auto -default-action=tabopen grep:.:-iHn:<C-R><C-W><CR>
nnoremap <leader>uG :Unite -buffer-name=grep -default-action=tabopen grep<CR>
nnoremap <leader>uo :Unite -buffer-name=outline -direction=botright -vertical -winwidth=45 outline<CR>
vnoremap <leader>uv y:call Unite_vgrep('<C-R><C-R>"', 1)<CR>
vnoremap <leader>uV y:call Unite_vgrep('<C-R><C-R>"', 0)<CR>
nnoremap <leader>ur :UniteResume<CR>
nnoremap <leader>ul :Unite -buffer-name=locate -default-action=tabopen -start-insert locate<CR>
nnoremap <leader>/ :Unite -buffer-name=line -start-insert line<CR>


"" Deprecated functionality

" map sort function to a key
" vnoremap <Leader>s :sort<CR>

" Jump to the first/last tab
" nnoremap <Leader><Leader>n <esc>:tabfirst<CR>
" nnoremap <Leader><Leader>m <esc>:tablast<CR>

" Meta/Alt key combinations
" The <m-alpha> have been set by vim-fixkey
" let c='0'
" while c <= '9'
"   exec "set <A-".c.">=\e".c
"   exec "imap \e".c." <A-".c.">"
"   let c = nr2char(1+char2nr(c))
" endw
" set ttimeout ttimeoutlen=5

" jumping tabs by number
" let n = 1
" while n <= 9
"     exec 'nnoremap <A-' . n . '> ' . n . 'gt'
"     let n = n + 1
" endwhile

" Start NerdTree automatically if vim is started without specifying any files
" autocmd StdinReadPre * let s:std_in=1
" autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

" The following is an example of how to map to a specific mode among the visual
" modes. Here I have mapped only to the Visual-Block mode using the ternary
" expr1.
"xnoremap <expr> <leader>c mode() ==# "\<C-V>" ? ":s/^/#\<CR>:nohl<CR>" : ""
