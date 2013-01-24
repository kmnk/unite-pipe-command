" File:    pipecommand.vim
" Author:  kmnk <kmnknmk+vim@gmail.com>
" Version: 0.1.0
" Copyright: Copyright (C) 2013- kmnk
" License: MIT Licence {{{
"     Permission is hereby granted, free of charge, to any person obtaining
"     a copy of this software and associated documentation files (the
"     "Software"), to deal in the Software without restriction, including
"     without limitation the rights to use, copy, modify, merge, publish,
"     distribute, sublicense, and/or sell copies of the Software, and to
"     permit persons to whom the Software is furnished to do so, subject to
"     the following conditions:
"     The above copyright notice and this permission notice shall be
"     included in all copies or substantial portions of the Software.
"
"     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
"     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
"     MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
"     IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
"     CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
"     TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
"     SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
" }}}

let s:save_cpo = &cpo
set cpo&vim

function! unite#sources#pipecommand#define()"{{{
  return s:source
endfunction"}}}

let s:source = {
\ 'name' : 'pipecommand',
\ 'description' : '',
\}

function! s:source.gather_candidates(args, context)"{{{
  if len(pipecommand#list()) > 0
    call unite#print_message(printf('[pipecommand] %s', pipecommand#pipe()))
  else
    call unite#print_message('[pipecommand]')
  endif

  let candidates = map(pipecommand#commands(), '{
\   "word"   : printf("[%s] %s", v:val.name, v:val.command),
\   "source" : s:source.name,
\   "kind"   : s:source.name,
\   "action__name" : v:val.name,
\   "action__command" : v:val.command,
\ }')

  return candidates
endfunction"}}}

function! s:source.change_candidates(args, context)
  if !strlen(a:context.input)
    return []
  endif
  return [{
\   "word"   : "> add inputed command > " . a:context.input,
\   "source" : s:source.name,
\   "kind"   : s:source.name . '_add',
\   "action__command" : a:context.input,
\ }]
endfunction

" local functions {{{
" }}}

let &cpo = s:save_cpo
unlet s:save_cpo
" __END__
