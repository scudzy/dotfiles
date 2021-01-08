let s:Promise = vital#fern#import('Async.Promise')
let s:AsyncLambda = vital#fern#import('Async.Lambda')

function! fern#mapping#mark_children#init(disable_default_mappings) abort
  nnoremap <buffer><silent> <Plug>(fern-action-mark-children:set:node)    :<C-u>call <SID>call('mark_children_set', { -> 1 })<CR>
  nnoremap <buffer><silent> <Plug>(fern-action-mark-children:unset:node)  :<C-u>call <SID>call('mark_children_unset', { -> 1 })<CR>
  nnoremap <buffer><silent> <Plug>(fern-action-mark-children:toggle:node) :<C-u>call <SID>call('mark_children_toggle', { -> 1 })<CR>
  nnoremap <buffer><silent> <Plug>(fern-action-mark-children:set:leaf)    :<C-u>call <SID>call('mark_children_set', { n -> n.status is# 0 })<CR>
  nnoremap <buffer><silent> <Plug>(fern-action-mark-children:unset:leaf)  :<C-u>call <SID>call('mark_children_unset', { n -> n.status is# 0 })<CR>
  nnoremap <buffer><silent> <Plug>(fern-action-mark-children:toggle:leaf) :<C-u>call <SID>call('mark_children_toggle', { n -> n.status is# 0 })<CR>
  nnoremap <buffer><silent> <Plug>(fern-action-mark-children:set:branch)    :<C-u>call <SID>call('mark_children_set', { n -> n.status isnot# 0 })<CR>
  nnoremap <buffer><silent> <Plug>(fern-action-mark-children:unset:branch)  :<C-u>call <SID>call('mark_children_unset', { n -> n.status isnot# 0 })<CR>
  nnoremap <buffer><silent> <Plug>(fern-action-mark-children:toggle:branch) :<C-u>call <SID>call('mark_children_toggle', { n -> n.status isnot# 0 })<CR>

  " Alias
  nmap <buffer> <Plug>(fern-action-mark-children:set) <Plug>(fern-action-mark-children:set:node)
  nmap <buffer> <Plug>(fern-action-mark-children:unset) <Plug>(fern-action-mark-children:unset:node)
  nmap <buffer> <Plug>(fern-action-mark-children:toggle) <Plug>(fern-action-mark-children:toggle:node)
  nmap <buffer> <Plug>(fern-action-mark-children:node) <Plug>(fern-action-mark-children:toggle:node)
  nmap <buffer> <Plug>(fern-action-mark-children:leaf) <Plug>(fern-action-mark-children:toggle:leaf)
  nmap <buffer> <Plug>(fern-action-mark-children:branch) <Plug>(fern-action-mark-children:toggle:branch)
  nmap <buffer> <Plug>(fern-action-mark-children) <Plug>(fern-action-mark-children:toggle)
endfunction

function! s:call(name, ...) abort
  return call(
        \ 'fern#mapping#call',
        \ [funcref(printf('s:map_%s', a:name))] + a:000,
        \)
endfunction

function! s:map_mark_children_set(helper, condition) abort
  let node = a:helper.sync.get_cursor_node()
  if node is# v:null
    return s:Promise.reject('no node found on a cursor line')
  endif
  let h = a:helper
  let m = a:helper.fern.marks
  return a:helper.async.expand_node(node.__key)
        \.then({ -> h.async.get_child_nodes(node.__key) })
        \.then(s:AsyncLambda.filter_f({ n -> a:condition(n) }))
        \.then(s:AsyncLambda.map_f({ n -> n.__key }))
        \.then(s:AsyncLambda.map_f({ k -> h.async.set_mark(k, 1) }))
        \.then({ -> h.async.redraw() })
endfunction

function! s:map_mark_children_unset(helper, condition) abort
  let node = a:helper.sync.get_cursor_node()
  if node is# v:null
    return s:Promise.reject('no node found on a cursor line')
  endif
  let h = a:helper
  let m = a:helper.fern.marks
  return a:helper.async.expand_node(node.__key)
        \.then({ -> h.async.get_child_nodes(node.__key) })
        \.then(s:AsyncLambda.filter_f({ n -> a:condition(n) }))
        \.then(s:AsyncLambda.map_f({ n -> n.__key }))
        \.then(s:AsyncLambda.map_f({ k -> h.async.set_mark(k, 0) }))
        \.then({ -> h.async.redraw() })
endfunction

function! s:map_mark_children_toggle(helper, condition) abort
  let node = a:helper.sync.get_cursor_node()
  if node is# v:null
    return s:Promise.reject('no node found on a cursor line')
  endif
  let h = a:helper
  let m = a:helper.fern.marks
  return a:helper.async.expand_node(node.__key)
        \.then({ -> h.async.get_child_nodes(node.__key) })
        \.then(s:AsyncLambda.filter_f({ n -> a:condition(n) }))
        \.then(s:AsyncLambda.map_f({ n -> n.__key }))
        \.then(s:AsyncLambda.map_f({ k -> h.async.set_mark(k, index(m, k) is# -1) }))
        \.then({ -> h.async.redraw() })
endfunction
