function! nvim_treesitter#statusline(...) abort
  return luaeval("require'nvim-treesitter'.statusline(_A)", get(a:, 1, {}))
endfunction

function! nvim_treesitter#foldexpr() abort
    let l:lastbuftick = get(b:, 'nvim_treesitter_lastbuftick', -1)
    let l:buftick = nvim_buf_get_changedtick(0)
    if l:lastbuftick != l:buftick
      let b:nvim_treesitter_lastbuftick = l:buftick
	  let b:nvim_treesitter_folds = luaeval("require('nvim-treesitter.fold').get_folds()")
    endif
    let l:folds = get(b:, 'nvim_treesitter_folds', [])
    if len(folds) >= v:lnum
      return l:folds[v:lnum - 1]
    endif
    return 0
endfunction

function! nvim_treesitter#installable_parsers(arglead, cmdline, cursorpos) abort
  return join(luaeval("require'nvim-treesitter.parsers'.available_parsers()") + ['all', 'maintained'], "\n")
endfunction

function! nvim_treesitter#installed_parsers(arglead, cmdline, cursorpos) abort
  return join(luaeval("require'nvim-treesitter.info'.installed_parsers()") + ['all', 'maintained'], "\n")
endfunction

function! nvim_treesitter#available_modules(arglead, cmdline, cursorpos) abort
  return join(luaeval("require'nvim-treesitter.configs'.available_modules()"), "\n")
endfunction

function! nvim_treesitter#available_query_groups(arglead, cmdline, cursorpos) abort
  return join(luaeval("require'nvim-treesitter.query'.available_query_groups()"), "\n")
endfunction

function! nvim_treesitter#indent() abort
	return luaeval(printf('require"nvim-treesitter.indent".get_indent(%d)', v:lnum))
endfunction
