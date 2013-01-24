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

function! unite#kinds#pipecommand#define()"{{{
  return s:kind
endfunction"}}}

let s:kind = {
\ 'name' : 'pipecommand',
\ 'default_action' : 'push',
\ 'action_table' : {},
\ 'alias_table' : {},
\}

let s:kind.action_table.push = {
\ 'description' : 'push this command',
\ 'is_selectable' : 0,
\ 'is_quit' : 0,
\ 'is_invalidate_cache' : 1,
\ 'is_listed' : 1,
\}
function! s:kind.action_table.push.func(candidate)"{{{
  call pipecommand#push(a:candidate.action__name, a:candidate.action__command)
endfunction"}}}
let s:kind.alias_table.add = 'push'

let s:kind.action_table.pop = {
\ 'description' : 'pop last command',
\ 'is_selectable' : 0,
\ 'is_quit' : 0,
\ 'is_invalidate_cache' : 1,
\ 'is_listed' : 1,
\}
function! s:kind.action_table.pop.func(candidate)"{{{
  call pipecommand#pop()
endfunction"}}}
let s:kind.alias_table.undo = 'pop'

let s:kind.action_table.remove = {
\ 'description' : 'remove this command',
\ 'is_selectable' : 0,
\ 'is_quit' : 0,
\ 'is_invalidate_cache' : 1,
\ 'is_listed' : 1,
\}
function! s:kind.action_table.remove.func(candidate)"{{{
  call pipecommand#remove(a:candidate.action__name)
endfunction"}}}
let s:kind.alias_table.delete = 'remove'

let s:kind.action_table.rename = {
\ 'description' : 'rename this command',
\ 'is_selectable' : 0,
\ 'is_quit' : 0,
\ 'is_invalidate_cache' : 1,
\ 'is_listed' : 1,
\}
function! s:kind.action_table.rename.func(candidate)"{{{
  let name = input("input this command's new name: ", a:candidate.action__name)
  call pipecommand#rename(a:candidate.action__name, name)
endfunction"}}}

let s:kind.action_table.echo = {
\ 'description' : 'echo result',
\ 'is_selectable' : 0,
\ 'is_quit' : 1,
\ 'is_invalidate_cache' : 0,
\ 'is_listed' : 1,
\}
function! s:kind.action_table.echo.func(candidate)"{{{
  echo pipecommand#run()
  call pipecommand#clear()
endfunction"}}}

let s:kind.action_table.view = {
\ 'description' : 'view result on new buffer',
\ 'is_selectable' : 0,
\ 'is_quit' : 1,
\ 'is_invalidate_cache' : 0,
\ 'is_listed' : 1,
\}
function! s:kind.action_table.view.func(candidate)"{{{
  call pipecommand#view(pipecommand#run())
  call pipecommand#clear()
endfunction"}}}

let s:kind.action_table.yank = {
\ 'description' : 'yank result to register',
\ 'is_selectable' : 0,
\ 'is_quit' : 1,
\ 'is_invalidate_cache' : 0,
\ 'is_listed' : 1,
\}
function! s:kind.action_table.yank.func(candidate)"{{{
  call pipecommand#yank(pipecommand#run())
  call pipecommand#clear()
endfunction"}}}

let s:kind.action_table.register = {
\ 'description' : 'register piped commands',
\ 'is_selectable' : 0,
\ 'is_quit' : 0,
\ 'is_invalidate_cache' : 1,
\ 'is_listed' : 1,
\}
function! s:kind.action_table.register.func(candidate)"{{{
  let name = input("input this command's name: ")
  let command = pipecommand#pipe()
  call pipecommand#register(name, command)
  echo printf('register command "%s" as "%s"', command, name)
  call pipecommand#clear()
endfunction"}}}

" local functions {{{
" }}}

let &cpo = s:save_cpo
unlet s:save_cpo
" __END__
