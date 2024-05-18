"-----------------------------------------------------------------------------
"                                *fzf.vim*
"-----------------------------------------------------------------------------
Shortcut! <leader>fa   (fzf.vim)  :Ag! <C-R><C-W><CR>  [PATH] preview   | " :Ag [PATTERN] ag search result (ctrl-A to select all, ctrl-D to deselect all) word
Shortcut! <leader>fA   (fzf.vim)  :Ag! <C-R><C-A><CR>  [PATH] preview   | " :Ag [PATTERN] ag search result (ctrl-A to select all, ctrl-D to deselect all) WORD
Shortcut! <leader>fr   (fzf.vim)  :Rg! <C-R><C-W><CR>  [PATH]           | " :Rg [PATTERN] rg search result (ctrl-A to select all, ctrl-D to deselect all) word
Shortcut! <leader>fR   (fzf.vim)  :Rg! <C-R><C-A><CR>  [PATH]           | " :Rg [PATTERN] rg search result (ctrl-A to select all, ctrl-D to deselect all) WORD
Shortcut! <leader>fz   (fzf.vim)  :FZF<CR>             [PATH]           | " Look for files under current directory
Shortcut! <leader>ff   (fzf.vim)  :FZF<CR>             [PATH]           | " Look for files under current directory
Shortcut! <leader>fg   (fzf.vim)  :FZFFzm<CR>                           | " jump to specify directory by fzf-marks
Shortcut! <leader>fG   (fzf.vim)  :GFiles?<CR>                preview   | " Git files (git status)          open git file that has changes
Shortcut! <leader>fb   (fzf.vim)  :Buffers<CR>         [PATH] preview   | " Open buffers                    open buffer
Shortcut! <leader>fB   (fzf.vim)  :GFiles<CR>          [OPTS] preview   | " Git files (git ls-files)        open git file (tracked by git)
Shortcut! <leader>fl   (fzf.vim)  :BLines<CR>         [QUERY]           | " Lines in the current buffer     expose line in buffer
Shortcut! <leader>fL   (fzf.vim)  :Lines<CR>          [QUERY]           | " Lines in loaded buffers         expose line in any buffer
Shortcut! <leader>ft   (fzf.vim)  :BTags<CR>          [QUERY] preview   | " Tags in the current buffer    ; expose tag in buffer
Shortcut! <leader>fT   (fzf.vim)  :Tags<CR>           [QUERY] preview   | " Tags in the project (ctags -R); expose tag in any buffer
Shortcut! <leader>fm   (fzf.vim)  :Marks<CR>                            | " Marks                           expose mark in buffer
Shortcut! <leader>fM   (fzf.vim)  :Maps<CR>                             | " Normal mode mappings            trigger mapping / keybinding / shortcut
Shortcut! <leader>fj   (fzf.vim)  :Jumps<CR>                            | " Jumps                           Jumps
Shortcut! <leader>fw   (fzf.vim)  :Windows<CR>                          | " Windows                         expose window in any tab
Shortcut! <leader>fh   (fzf.vim)  :History<CR>                preview   | " Open buffers history            reopen file from history
Shortcut! <leader>f:   (fzf.vim)  :History:<CR>                         | " Command history                 repeat command from history
Shortcut! <leader>f/   (fzf.vim)  :History/<CR>                         | " Search history                  repeat search from history
Shortcut! <leader>f?   (fzf.vim)  :Helptags<CR>                         | " Help tags                       open help topic
Shortcut! <leader>fs   (fzf.vim)  :Snippets<CR>                         | " Snippets (UltiSnips)            snippets
Shortcut! <leader>fc   (fzf.vim)  :Commits <CR>  [LOG_OPTS]   preview   | " Git commits (requires fugitive.vim) browse git log
Shortcut! <leader>fC   (fzf.vim)  :BCommits<CR>  [LOG_OPTS]   preview   | " Git commits (requires fugitive.vim) browse git log for buffer
Shortcut! <leader>f;   (fzf.vim)  :Commands<CR>                         | " Commands                            run command from menu
Shortcut! <leader>fS   (fzf.vim)  :call fzf#sonictemplate#run()<CR>     | " template (sonictemplate)
Shortcut! <leader>f.   (fzf.vim.ext) :FZFNeigh<CR>                      | " open file under buffer's directory
Shortcut! :Filetypes<CR>                                                | " File types                          open help topic
Shortcut! :Colors<CR>                                                   | " apply colorscheme                    apply filetype


" Mapping selecting mappings
nmap <leader><tab> <plug>(fzf-maps-n)
xmap <leader><tab> <plug>(fzf-maps-x)
omap <leader><tab> <plug>(fzf-maps-o)

" Insert mode completion
imap <c-x>k <plug>(fzf-complete-word)
imap <c-x>f <plug>(fzf-complete-path)
imap <c-x>l <plug>(fzf-complete-line)

" Enable per-command history.
" CTRL-N and CTRL-P will be automatically bound to next-history and
" previous-history instead of down and up. If you don't like the change,
" explicitly bind the keys to down and up in your $FZF_DEFAULT_OPTS.
let g:fzf_history_dir = '~/.local/share/fzf-history'


"-----------------------------------------------------------------------------
"                                *F1~F12*
"-----------------------------------------------------------------------------
Shortcut! <F2>  (FF)   number
Shortcut! <F3>  (FF)   list
Shortcut! <F4>  (FF)   relativenumber
Shortcut! <F5>  (FF)   ccompile
Shortcut! <F6>  (FF)   format
Shortcut! <F7>  (FF)   SyntasticToggleMode(lint)
Shortcut! <F8>  (FF)   MaximizerToggle
Shortcut! <F9>  (FF)   FloatermNext
Shortcut! <F10> (FF)    FloatermToggle
Shortcut! <F11> (FF)    single file tags
Shortcut! <F12> (FF)    project file tags

Shortcut! <leader><F1>  (FF)    quickfix_toggle
Shortcut! <leader><F2>  (FF)    TagbarToggle
Shortcut! <leader><F3>  (FF)    NERDTreeRefreshRoot
Shortcut! <leader><F4>  (FF)    VimRegEdit
Shortcut! <leader><F5>  (FF)    crun
Shortcut! <leader><F6>  (FF)    format
Shortcut! <leader><F7>  (FF)    SyntasticToggleMode(lint)
Shortcut! <leader><F8>  (FF)    Windows
Shortcut! <leader><F10> (FF)    REPLToggle
Shortcut! <leader><F11> (FF)    Gutentags

"-----------------------------------------------------------------------------
"                                *shortcut*
"-----------------------------------------------------------------------------
Shortcut! <leader>fx  (FF)   shortcut
Shortcut! <leader>fX  (FF)   source ~/.vim/shortcut.vim

"-----------------------------------------------------------------------------
"                                *fugitive*
"-----------------------------------------------------------------------------
Shortcut! :call feedkeys(':GMove '.expand('%'), 't')<CR>   (fugitive)  git mv: rename file
Shortcut! :call feedkeys(':GMove! '.expand('%'), 't')<CR>  (fugitive)  git mv -f: rename file forcefully
Shortcut! :Git blame<CR>                                   (fugitive)  git blame: who changed which line
Shortcut! :Git commit<CR>                                  (fugitive)  git commit: record new commit
Shortcut! :Git commit --amend<CR>                          (fugitive)  git commit --amend
Shortcut! :Git commit --amend --reuse-message=HEAD<CR>     (fugitive)  git commit --amend --reuse-message=HEAD
Shortcut! :Gdiffsplit<CR>                                  (fugitive)  git diff: show changes against repository
Shortcut! :Gedit<CR>                                       (fugitive)  return to editing git buffer
Shortcut! :Gread<CR>                                       (fugitive)  git checkout: revert buffer to repository
Shortcut! :Gread!<CR>                                      (fugitive)  git checkout -f: revert buffer to repository forcefully
Shortcut! :Gstatus<CR>                                     (fugitive)  open git status window
Shortcut! :Gwrite<CR>                                      (fugitive)  git add: stage all changes in buffer
Shortcut! :Gwrite!<CR>                                     (fugitive)  git add -f: stage all changes in buffer forcefully
Shortcut! :GRemove<Bar>bdelete<CR>                         (fugitive)  git rm: delete file from repository
Shortcut! :GRemove!<Bar>bdelete<CR>                        (fugitive)  git rm -f: delete file from repository forcefully
Shortcut! :<C-U>call <SID>git_grep_prompt('-Pi')<CR>       (fugitive) git grep: search repository
Shortcut! :<C-U>call <SID>git_grep_register('-Pi')<CR>     (fugitive) git grep: search repository for Vim search pattern
Shortcut! :<C-U>call <SID>git_grep_cursor('-Pi')<CR>       (fugitive) git grep: search repository for word under cursor


Shortcut (fugitive) git grep: search repository
      \ nnoremap <silent> <Space>/G :<C-U>call <SID>git_grep_prompt('-Pi')<CR>
      \|nnoremap <silent> <Space>/g :<C-U>call <SID>git_grep_prompt('-P')<CR>

Shortcut (fugitive) git grep: search repository for Vim search pattern
      \ nnoremap <silent> <Space>?G :<C-U>call <SID>git_grep_register('-Pi')<CR>
      \|nnoremap <silent> <Space>?g :<C-U>call <SID>git_grep_register('-P')<CR>

Shortcut (fugitive) git grep: search repository for word under cursor
      \ nnoremap <silent> <Space>*G :<C-U>call <SID>git_grep_cursor('-Pi')<CR>
      \|nnoremap <silent> <Space>*g :<C-U>call <SID>git_grep_cursor('-P')<CR>

function! s:git_grep_prompt(git_grep_flags) abort
  " store cursor position in jumplist so user can press <C-O> to go back
  silent! normal! m'n`'
  let grep_regex = input("git grep ". a:git_grep_flags." ")
  call s:git_grep(a:git_grep_flags, grep_regex)
endfunction

function! s:git_grep_cursor(git_grep_flags) abort
  let grep_regex = expand('<cword>')
  call s:git_grep(a:git_grep_flags, grep_regex)
endfunction

function! s:git_grep_register(git_grep_flags) abort
  let vim_regex = @/
  let grep_regex = substitute(grep_regex, '\\[vVmM]', '', 'g') " :help /magic
  let grep_regex = substitute(grep_regex, '\\[<>]', '\\b', 'g') " word boundary
  call s:git_grep(a:git_grep_flags, grep_regex)
endfunction

function! s:git_grep(git_grep_flags, grep_regex) abort
  -tabnew
  execute 'Ggrep --quiet '. a:git_grep_flags .' '. fnameescape(a:grep_regex)
  " translate grep(1) regex into Vim syntax; see :help eregex-functions
  let vim_regex = E2v(a:grep_regex)
  " E2v() won't handle \b - https://github.com/othree/eregex.vim/issues/28
  let vim_regex = substitute(vim_regex, '\\b', '\\(\\<\\|\\>\\)', 'g')
  let @/ = vim_regex
endfunction

"-----------------------------------------------------------------------------
"                                *Goyo*
"-----------------------------------------------------------------------------
Shortcut! :Goyo<CR>                                      (goyo)      toggle distraction-free writing mode

"-----------------------------------------------------------------------------
"                                *Shortcut*
"-----------------------------------------------------------------------------
Shortcut! :Limelight!!<CR>                              (limelight) toggle enhancement for distraction-free writing mode


"-----------------------------------------------------------------------------
"                                *colorscheme*
"-----------------------------------------------------------------------------
