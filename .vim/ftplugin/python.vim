let g:autopep8_disable_show_diff=1
let g:autopep8_on_save = 1

let g:python_highlight_all = 1

nnoremap <buffer> <F9> :exec '!ipython --pdb' shellescape(@%, 1)<cr>
vmap <buffer> <F9> :exec '!ipython --pdb' shellescape("$(@%)", 1)<cr>
