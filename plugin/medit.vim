if exists("g:loaded_medit") || &cp
  finish
endif

let g:loaded_medit = '0.0.2' " version number

function! s:open_register_win(register)
  if has('nvim')
    call s:open_float()
  else
    call s:open_split()
  endif
  call s:assign_mappings(a:register)
endfunction

function! s:assign_mappings(register)
  " make these configurable
  exe 'nnoremap <silent><buffer> q :call <SID>yank_n_close("'. a:register. '")<Cr>'
  nnoremap <buffer> <esc> :close<Cr>
endfunction

function! s:open_split()
  split
  noswapfile hide enew
  setlocal buftype=nofile
  setlocal bufhidden=hide
  setlocal noswapfile
  setlocal nobuflisted
endfunction

function! s:open_float()
    let buf = nvim_create_buf(v:false, v:true)
    let width = &columns / 3
    let height = 3
    let opts = { 'relative': 'win',
               \ 'row': (&lines - height) / 2,
               \ 'col': (&columns - width) / 2,
               \ 'width': width,
               \ 'height': height,
               \ 'style': 'minimal'
               \}
    call nvim_open_win(buf, v:true, opts)
endfunction

function! s:yank_n_close(register)
  let new_macro = getline('.')
  if !s:is_in(s:read_only_regs(), a:register)
    exe 'let @' . a:register . "= l:new_macro"
    echom "Macro " . a:register . " = " . new_macro
  endif
  close
endfunction

function! s:is_in(list, element)
  return (index(a:list, a:element) != -1)
endfunction


function! s:read_only_regs()
  return ['%', '.', ':', '#']
endfunction

function! OpenRegisterWindow(register)
  " TODO: try to preserve clipboard too?
  " TODO: check to see if the register is valid
  call s:open_register_win(a:register)

  " Thanks @lsaville !
  let reg_contents = getreg(a:register)
  if reg_contents != ""
    execute 'normal! "'. a:register . "pgg"
  endif
endfunction


nnoremap <silent><expr> <Plug>MEdit ":call OpenRegisterWindow('" . nr2char(getchar()) . "')<Cr>"
if !exists("g:medit_no_mappings") || ! g:medit_no_mappings
  nmap <Leader>q <Plug>MEdit
endif
