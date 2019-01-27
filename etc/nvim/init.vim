" Setting up plugins using dein.vim

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

if dein#check_install(['vimproc.vim'])
  call dein#install(['vimproc.vim'])
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
set termguicolors
set colorcolumn=+1
let $NVIM_TUI_ENABLE_TRUE_COLOR=1
hi ColorColumn guibg=#323642
" Reverse IncSearch to have better highlighting with SearchParty.
hi clear IncSearch
hi IncSearch cterm=reverse gui=reverse

color synthwave

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

" Open a new line and stay in Normal mode. (Gives a meaning to Enter as well)
" It has been reported that this might interfere with the command line normal
" mode. Since I havent faced any problems with it as yet, I dont mind keeping
" this mapping. In case, that ever needs to be done, possibly the expr should
" be used (see below for example) along with the modes that need to be
" excluded (check http://vimdoc.sourceforge.net/htmldoc/eval.html#mode() )
"nnoremap <Leader><CR> O<Esc>
nnoremap <CR> o<Esc>

" Quicksave command
noremap <C-Z> :update<CR>
vnoremap <C-Z> <C-C>:update<CR>
inoremap <C-Z> <C-O>:update<CR>

" Paste the selected text after the last line of the selected text
" This is useful in the visual line mode
vnoremap <leader>p y`>p

" Delete to buffer 'd' instead of the default buffer
nnoremap <expr> <leader>dw (v:register == '+') ? '"ddw' : '"'.v:register.'dw'
nnoremap <expr> <leader>dd (v:register == '+') ? '"ddd' : '"'.v:register.'dd'
vnoremap <expr> <leader>d (v:register == '+') ? '"dd' : '"'.v:register.'d'

" Quick movements
nnoremap H ^
nnoremap L g_
vnoremap H ^
vnoremap L g_
nnoremap J 3j
nnoremap K 3k
vnoremap J 3j
vnoremap K 3k

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

vnoremap < <gv
vnoremap > >gv

" Save a file that has been openned without root permission and requires it
cnoremap w!! w !sudo tee > /dev/null %

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

" Since the quickfix window is not modifiable, the global mapping for <CR>
" overwrites the default quickfix <CR> behaviour to jump to the specified
" line/buffer. So the following buffer local mapping would remap <CR> to behave
" as intended.
autocmd FileType qf silent! nnoremap <buffer> <CR> <CR>
" The same goes for windows opened as vim ft
autocmd FileType vim silent! nnoremap <buffer> <CR> <CR>

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
nnoremap <silent> <leader><leader>k :call NextIndent(0, 0, 0, 1)<CR>
nnoremap <silent> <leader><leader>j :call NextIndent(0, 1, 0, 1)<CR>
vnoremap <silent> <leader><leader>k <Esc>:call NextIndent(0, 0, 0, 1)<CR>m'gv''
vnoremap <silent> <leader><leader>j <Esc>:call NextIndent(0, 1, 0, 1)<CR>m'gv''
onoremap <silent> <leader><leader>k :call NextIndent(0, 0, 0, 1)<CR>
onoremap <silent> <leader><leader>j :call NextIndent(0, 1, 0, 1)<CR>


" -----------------------------------------------------------------------------
" Plugin specific config
"------------------------------------------------------------------------------

" airline config
let g:airline_theme='synthwave'
let g:airline#extensions#tabline#enabled=1
let g:airline_powerline_fonts=1
let g:airline#extensions#tabline#show_buffers = 0
let g:airline#extensions#tabline#tab_nr_type=2
let g:airline#extensions#tabline#show_splits=1
let g:airline_inactive_collapse=0
let g:airline#extensions#tabline#show_close_button=0
let g:airline#extensions#tabline#excludes = ['term://']

" For autopairs flymode activation
let g:AutoPairsFlyMode = 1
let g:AutoPairsShortcutToggle = ''
" <CR> trigger will be launched manually after deoplete
let g:AutoPairsMapCR = 0
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
call deoplete#custom#source('_', 'converters',
    \ ['converter_auto_delimiter', 'converter_remove_paren', 'converter_remove_overlap'])
" fully fuzzy matching
call deoplete#custom#source('_', 'matchers',
    \ ['matcher_length', 'matcher_full_fuzzy'])
inoremap <expr><C-g>     deoplete#undo_completion()
inoremap <expr><C-l>     deoplete#refresh()
inoremap <silent><expr> <TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <silent><expr> <S-TAB> pumvisible() ? "\<C-p>" : "\<S-TAB>"
imap <expr><CR> pumvisible() ? deoplete#close_popup() : "\<CR>\<Plug>AutoPairsReturn"

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

" easymotion options
let g:EasyMotion_smartcase = 1
nmap <leader>s <Plug>(easymotion-s2)
vmap <leader>s <Plug>(easymotion-s2)
nmap <leader>j <Plug>(easymotion-j)
vmap <leader>j <Plug>(easymotion-j)
nmap <leader>k <Plug>(easymotion-k)
vmap <leader>k <Plug>(easymotion-k)
nmap <leader><leader>n <Plug>(easymotion-next)
vmap <leader><leader>n <Plug>(easymotion-next)
nmap <leader><leader>p <Plug>(easymotion-prev)
vmap <leader><leader>p <Plug>(easymotion-prev)

" fakeclip options
let g:vim_fakeclip_tmux_plus=1

" hardtime on startup
let g:hardtime_default_on = 1
let g:hardtime_maxcount = 2
let g:hardtime_ignore_buffer_patterns = ["NERD.*", ".*\.txt"]
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
" why dont you try using `cgn`
let g:multi_cursor_use_default_mapping=0
let g:multi_cursor_start_key='<F6>'
let g:multi_cursor_start_word_key='g<C-n>'
let g:multi_cursor_next_key='<C-n>'
let g:multi_cursor_prev_key='<C-p>'
let g:multi_cursor_skip_key='<C-x>'
let g:multi_cursor_quit_key='<Esc>'

" neoterm options
let g:neoterm_autoinsert=1
let g:neoterm_default_mod='vertical'
nnoremap <S-F5> :w<CR>:T python %<CR>
nnoremap <S-F6> :w<CR>:T ptipython -i %<CR>
nnoremap <S-F7> :w<CR>:T ptipython<CR>
nnoremap <S-F8> :w<CR>:Topen<CR>
nnoremap <localleader>t :tab Tnew<CR>

" NERDTree options
" `:NERDTreeFind` to locate the file in the dir tree
" `:NERDTree %` to open the dir tree that the current file is in
nnoremap <localleader>n :NERDTreeToggle<CR>
nnoremap <localleader>m :NERDTree %<CR>
let NERDTreeIgnore = ['\~$', '\.pyc$']

" Settings for python-mode
let g:pymode_rope = 0
let g:pymode_doc = 0
let g:pymode_python = 'python3'
let g:pymode_lint_ignore = ["E501", "E302"]
let g:pymode_lint_checkers = ['pyflakes', 'pep8']
let g:pymode_breakpoint = 0
let g:pymode_syntax = 1

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

" Denite options
call denite#custom#option('_', {
  \ 'prompt': '❯',
  \ 'empty': 0,
  \ 'winheight': 16,
  \ 'short_source_names': 1,
  \ 'vertical_preview': 1,
  \ 'direction': 'dynamicbottom',
  \ })

let insert_mode_mappings = [
  \  ['jj', '<denite:enter_mode:normal>', 'noremap'],
  \  ['qq', '<denite:quit>', 'noremap'],
  \  ['<Esc>', '<denite:enter_mode:normal>', 'noremap'],
  \  ['<C-N>', '<denite:assign_next_matched_text>', 'noremap'],
  \  ['<C-P>', '<denite:assign_previous_matched_text>', 'noremap'],
  \  ['<C-Y>', '<denite:redraw>', 'noremap'],
  \  ['<C-J>', '<denite:move_to_next_line>', 'noremap'],
  \  ['<C-K>', '<denite:move_to_previous_line>', 'noremap'],
  \  ['<C-G>', '<denite:insert_digraph>', 'noremap'],
  \  ['<C-T>', '<denite:input_command_line>', 'noremap'],
  \ ]

let normal_mode_mappings = [
  \   ["'", '<denite:toggle_select_down>', 'noremap'],
  \   ['<C-n>', '<denite:jump_to_next_source>', 'noremap'],
  \   ['<C-p>', '<denite:jump_to_previous_source>', 'noremap'],
  \   ['v', '<denite:do_action:vsplit>', 'noremap'],
  \   ['s', '<denite:do_action:split>', 'noremap'],
  \ ]

for m in insert_mode_mappings
  call denite#custom#map('insert', m[0], m[1], m[2])
endfor
for m in normal_mode_mappings
  call denite#custom#map('normal', m[0], m[1], m[2])
endfor

nnoremap <silent><LocalLeader>r :<C-u>Denite -resume -refresh<CR>
nnoremap <silent><LocalLeader>f :<C-u>Denite -default-action=tabopen file_rec file_mru<CR>
nnoremap <silent><LocalLeader>h :<C-u>Denite -default-action=tabopen file_rec:~/<CR>
nnoremap <silent><LocalLeader>y :<C-u>Denite -default-action=append -mode=normal neoyank<CR>
nnoremap <silent><LocalLeader>g :<C-u>DeniteCursorWord -default-action=tabopen -mode=normal grep:.<CR>
nnoremap <silent><LocalLeader>o :<C-u>Denite -buffer-name=outline -direction=botright -split=vertical -winwidth=45 outline<CR>
nnoremap <silent><LocalLeader>c :<C-u>Denite command_history<CR>
nnoremap <silent><LocalLeader>b :<C-u>Denite -default_action=switch buffer<CR>

function! Denite_vgrep(search_string)
  let l:escaped_str = substitute(a:search_string, " ", "\\\\\\\\s", "g")
  exec 'Denite -buffer-name=vgrep_auto -default-action=tabopen grep:.:-iHn:'.l:escaped_str
endfunction
vnoremap <silent><LocalLeader>v y:call Denite_vgrep('<C-R><C-R>"')<CR>


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

" Unite options
" function! Unite_vgrep(search_string, auto)
"   let l:escaped_str = substitute(a:search_string, " ", "\\\\\\\\s", "g")
"   if a:auto
"     exec 'Unite -buffer-name=vgrep_auto -default-action=tabopen grep:.:-iHn:'.l:escaped_str
"   else
"     exec 'Unite -buffer-name=vgrep -default-action=tabopen grep::-iHn:'.l:escaped_str
"   endif
" endfunction
" nnoremap <leader>uf :Unite -buffer-name=file_rec -default-action=tabopen -start-insert file_rec/neovim<CR>
" nnoremap <leader>uh :Unite -buffer-name=file_rec -default-action=tabopen -start-insert file_rec/neovim:/home/ankur/<CR>
" nnoremap <leader>um :Unite -buffer-name=mru -default-action=tabopen -start-insert neomru/file<CR>
" nnoremap <leader>uy :Unite -buffer-name=yank -default-action=append history/yank<CR>
" nnoremap <leader>ug :Unite -buffer-name=grep_auto -default-action=tabopen grep:.:-iHn:<C-R><C-W><CR>
" nnoremap <leader>uG :Unite -buffer-name=grep -default-action=tabopen grep<CR>
" nnoremap <leader>uo :Unite -buffer-name=outline -direction=botright -vertical -winwidth=45 outline<CR>
" vnoremap <leader>uv y:call Unite_vgrep('<C-R><C-R>"', 1)<CR>
" vnoremap <leader>uV y:call Unite_vgrep('<C-R><C-R>"', 0)<CR>
" nnoremap <leader>ur :UniteResume<CR>
" nnoremap <leader>ul :Unite -buffer-name=locate -default-action=tabopen -start-insert locate<CR>
" nnoremap <leader>/ :Unite -buffer-name=line -start-insert line<CR>

" Start NerdTree automatically if vim is started without specifying any files
" autocmd StdinReadPre * let s:std_in=1
" autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

" The following is an example of how to map to a specific mode among the visual
" modes. Here I have mapped only to the Visual-Block mode using the ternary
" expr1.
"xnoremap <expr> <leader>c mode() ==# "\<C-V>" ? ":s/^/#\<CR>:nohl<CR>" : ""
