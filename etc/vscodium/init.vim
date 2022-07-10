let s:dein_dir = expand('~/.cache/vscodium-dein')
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
    call dein#add('asvetliakov/vim-easymotion')
    call dein#add('rjayatilleka/vim-insert-char')
    call dein#add('machakann/vim-highlightedyank')

    call dein#end()

    call dein#remote_plugins()
    call dein#save_state()
  endif
  
  if dein#check_install()
    call dein#install()
  endif

" leader!
let mapleader = ","
let maplocalleader = "`"

" To change : to ; to make life easier
nnoremap ; :
vnoremap ; :

" And the reverse because that is used for repeating the last 'f' search
nnoremap : ;
vnoremap : ;

" save file with vim mapping
noremap <C-z> <Cmd>call VSCodeCall('workbench.action.files.save')<CR>

" close active editor
noremap <Leader>e <Cmd>Quit<CR>

" Tab navigation
nnoremap <Leader>n <Cmd>Tabprevious<CR>
nnoremap <Leader>m <Cmd>Tabnext<CR>

" Paste the selected text after the last line of the selected text
" This is useful in the visual line mode
vnoremap <leader>p y`>p

" Quick movements
nnoremap H ^
nnoremap L g_
vnoremap H ^
vnoremap L g_

" sticky selection after indentation
vnoremap < <gv
vnoremap > >gv

" comments
xmap gc  <Plug>VSCodeCommentary
nmap gc  <Plug>VSCodeCommentary
omap gc  <Plug>VSCodeCommentary
nmap gcc <Plug>VSCodeCommentaryLine

" easymotion
let g:EasyMotion_do_mapping = 0
let g:EasyMotion_smartcase = 1
nmap <leader>s <Plug>(easymotion-s2)
vmap <leader>s <Plug>(easymotion-s2)
nmap <localleader>j <Plug>(easymotion-j)
vmap <localleader>j <Plug>(easymotion-j)
nmap <localleader>k <Plug>(easymotion-k)
vmap <localleader>k <Plug>(easymotion-k)