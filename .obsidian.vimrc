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

"noremap u i
"noremap U I

"
"nmap n j
"nmap e k
"nmap i <Right>

nmap K 7k
nmap J 7j
nmap H 7h
nmap L 7l
"

nmap cw caw
"nmap f w



vmap K 7k
vmap J 7j
vmap H 7h
vmap L 7l



" noremap l :undo<cr>
