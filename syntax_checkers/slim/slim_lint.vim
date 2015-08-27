"============================================================================
"File:        slim_lint.vim
"Description: Syntax checking plugin for syntastic.vim
"============================================================================

if exists('g:loaded_syntastic_slim_lint_checker')
    finish
endif
let g:loaded_syntastic_slim_lint_checker = 1

let s:save_cpo = &cpo
set cpo&vim

function! SyntaxCheckers_slim_lint_IsAvailable() dict
    if !executable(self.getExec())
        return 0
    endif
    return syntastic#util#versionIsAtLeast(self.getVersion(), [0, 12, 0])
endfunction

function! SyntaxCheckers_slim_lint_GetLocList() dict
    let makeprg = self.makeprgBuild({ 'args_after': '--reporter default' })

    let errorformat = '%f:%l [%t] %m'

    let loclist = SyntasticMake({
        \ 'makeprg': makeprg,
        \ 'errorformat': errorformat,
        \ 'subtype': 'Style'})

    return loclist
endfunction

call g:SyntasticRegistry.CreateAndRegisterChecker({
    \ 'filetype': 'slim',
    \ 'name': 'slim_lint'})

let &cpo = s:save_cpo
unlet s:save_cpo

" vim: set sw=4 sts=4 et fdm=marker:
