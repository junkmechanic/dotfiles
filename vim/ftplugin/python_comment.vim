" commenting and uncommenting lines in python using <Leader>c and <Leader><A-c>
nnoremap <Leader>c :s/^/# <CR>:nohl<CR>
nnoremap <Leader><A-c> :s/^# /<CR>:nohl<CR>
xnoremap <Leader>c :s/^/# <CR>:nohl<CR>
xnoremap <Leader><A-c> :s/^# /<CR>:nohl<CR>

" The following is an example of how to map to a spacific mode among the visual
" modes. Here I have mapped only to the Visual-Block mode using the ternary
" expr1.
"xnoremap <expr> <leader>c mode() ==# "\<C-V>" ? ":s/^/#\<CR>:nohl<CR>" : ""
