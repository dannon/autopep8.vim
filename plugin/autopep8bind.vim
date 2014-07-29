""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" autopep8bind.vim
" Author: Dannon Baker <dannon.baker@gmail.com>
" Version: 1.0
" Last Change: 12-10-2013
" Usage:
" Use visual mode to select range of lines and then
" use <C-a> to apply autopep8 to those lines.
"
" Changelog:
"  1.0 - initial upload
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if !has('python')
    s:ErrMsg( "Error: Required vim compiled with +python" )
    finish
endif

python << EOF
import vim
import autopep8

def ap8(r):
    """returns fixed lines"""
    r_0, r_1 = vim.current.range.start, vim.current.range.end
    lines = '\n'.join(r)
    fixedlines = autopep8.fix_code(lines)
    fl = fixedlines.split('\n')
    fl = [x.encode('utf-8') for x in fl] # Force to utf-8
    return fl

EOF

autocmd FileType python,scons vnoremap <C-a> :python vim.current.range[:] = ap8(vim.current.range)<CR>
