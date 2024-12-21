" Copyright 2019 Google LLC
"
" Indent Python the Google way.

setlocal indentexpr=GetGooglePythonIndent(v:lnum)

let s:maxoff = 50 " maximum number of lines to look backwards.

function GetGooglePythonIndent(lnum)
    " Indent inside parns,
    " Align with the open paren unless it is at the end of the line.
    " E.g.
    "   open_paren_not_at_EOL(100,
    "                         (200,
    "                          300),
    "                         400)
    "   open_parn_to_EOL(
    "       100, 200, 300, 400)
    call cursor(a:lnum, 1)
    let [par_line, par_col] = searchpairpos('(\|{\|\[', '', ')\|}\|\]', 'bW',
                \ "line('.') < " . (a:lnum - s:maxoff) . " ? dummy :"
                \ . " synIDattr(synID(line('.'), col('.'), 1), 'name')"
                \ . " =~ '\\Comment\\|String\\)$'")
    if par_line > 0
        call cursor(par_line, 1)
        if par_line != col("$") - 1
            return par_col
        endif
    endif

    " Delegate the rest to the original function
    return GetPythonIndent(a:lnum)

endfunction

let pyindent_nest_paren="&sw*2"
let pyindent_open_paren="&sw*2"

autocmd BufWritePre * :%s/\s\+$//e
autocmd Filetype json setlocal ts=4 sw=4 expandtab

set colorcolumn=100
set tabstop=2 shiftwidth=2 expandtab
