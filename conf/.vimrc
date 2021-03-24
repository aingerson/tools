set number
set incsearch
color enzyme
nnoremap <space> :nohlsearch<CR>
nnoremap <silent> <F5> :let _s=@/ <Bar> :%s/\s\+$//e <Bar> :let @/=_s <Bar> :nohl <Bar> :unlet _s <CR>

nmap <C-]> :cs find g <C-R>=expand("<cword>")<CR><CR>
nmap <C-_>s :cs find s <C-R>=expand("<cword>")<CR><CR>
nmap <C-_>g :cs find g <C-R>=expand("<cword>")<CR><CR>
nmap <C-_>c :cs find c <C-R>=expand("<cword>")<CR><CR>
nmap <C-_>t :cs find t <C-R>=expand("<cword>")<CR><CR>
nmap <C-_>e :cs find e <C-R>=expand("<cword>")<CR><CR>
nmap <C-_>f :cs find f <C-R>=expand("<cfile>")<CR><CR>
nmap <C-_>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
nmap <C-_>d :cs find d <C-R>=expand("<cword>")<CR><CR>

" Persistent Undo
function! PersistentUndo()
	let vim_dir = $HOME . '/.vim'
	if has("persistent_undo")
		let undo_dir = expand(vim_dir . '/undodir')
		call system('mkdir -p ' . undo_dir)
		let &undodir = undo_dir	    " where to save undo histories
		set undofile                " Save undo's after file closes
		set undolevels=1000         " How many undos
		set undoreload=10000        " number of lines to save for undo
	else
		echo "warning: no persistent undo!"
	endif
endfunction

call PersistentUndo()
