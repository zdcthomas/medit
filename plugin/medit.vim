if exists("g:loaded_medit") || &cp
  finish
endif

let g:loaded_medit = '0.0.1' " version number

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
  exe 'nnoremap <buffer> q :call s:yank_n_close("'. a:register. '")<Cr>'
  nnoremap <buffer> <esc> :close<Cr>
endfunction

function! s:open_split()
  split enew
endfunction

function! s:open_float()
    let buf = nvim_create_buf(v:false, v:true)
    " 90% of the height
    let height = 2
    " 60% of the height
    let width = float2nr(&columns * 0.5)
    " horizontal position (centralized)
    let horizontal = float2nr((&columns - width) / 3)
    " vertical position (one line down of the top)
      let vertical = float2nr(virtcol('.'))
    let opts = {
          \ 'relative': 'editor',
          \ 'row': vertical,
          \ 'col': horizontal,
          \ 'width': width,
          \ 'height': height,
          \ 'style': 'minimal'
          \ }
    call nvim_open_win(buf, v:true, opts)
endfunction

function! s:yank_n_close(register)
  exe 'let @' . a:register . "= getline('.')"
  close
endfunction

function! OpenMacroWindow(register)
  call s:open_register_win(a:register)
  execute 'normal! "'. a:register . "pgg"
endfunction


" Is this how this works?
"<Plug>MEdit
nnoremap <expr> <Plug>MEdit ":call OpenMacroWindow('" . nr2char(getchar()) . "')<Cr>"
if !exists("g:medit_no_mappings") || ! g:medit_no_mappings
  nmap <Leader>q <Plug>MEdit
endif
