" I like using H and L for beginning/end of line
"noremap l u


exmap togglefold obcommand editor:toggle-fold
nmap tt :togglefold



" Quickly remove search highlights
nmap \ :nohl

" Yank to system clipboard
set clipboard=unnamed

" Go back and forward with Ctrl+O and Ctrl+I a啊染色体
" (make sure to remove default Obsidian shortcuts for these to work)
exmap back obcommand app:go-back
nmap <C-o> :back
exmap forward obcommand app:go-forward
nmap <C-i> :forward

noremap u i
noremap U I

nnoremap n j
nnoremap e k

nnoremap l u

nnoremap E 5k
nnoremap N 5j
nnoremap H 5h
nnoremap I 5l

nnoremap i l

nnoremap f w

vmap n j
vmap e k
vmap i l

vmap E 5k
vmap N 5j
vmap H 5h
vmap I 5l
