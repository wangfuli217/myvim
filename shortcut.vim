"-----------------------------------------------------------------------------
" NEXT AND PREVIOUS                               *fzf.vim*
"-----------------------------------------------------------------------------
Shortcut! <leader>fa   (fzf.vim)  :Ag! <C-R><C-W><CR>  [PATH] preview   | " :Ag [PATTERN] ag search result (ctrl-A to select all, ctrl-D to deselect all) word
Shortcut! <leader>fA   (fzf.vim)  :Ag! <C-R><C-A><CR>  [PATH] preview   | " :Ag [PATTERN] ag search result (ctrl-A to select all, ctrl-D to deselect all) WORD
Shortcut! <leader>fr   (fzf.vim)  :Rg! <C-R><C-W><CR>  [PATH]           | " :Rg [PATTERN] rg search result (ctrl-A to select all, ctrl-D to deselect all) word
Shortcut! <leader>fR   (fzf.vim)  :Rg! <C-R><C-A><CR>  [PATH]           | " :Rg [PATTERN] rg search result (ctrl-A to select all, ctrl-D to deselect all) WORD
Shortcut! <leader>fz   (fzf.vim)  :FZF<CR>             [PATH]           | " Look for files under current directory
Shortcut! <leader>ff   (fzf.vim)  :FZF<CR>             [PATH]           | " Look for files under current directory
Shortcut! <leader>fg   (fzf.vim)  :FZFFzm<CR>                           | " jump to specify directory by fzf-marks
Shortcut! <leader>fG   (fzf.vim)  :GFiles?<CR>                preview   | " Git files (git status)          open git file that has changes
Shortcut! <leader>fb   (fzf.vim)  :Buffers<CR>         [PATH] preview   | " Open buffers
Shortcut! <leader>fB   (fzf.vim)  :GFiles<CR>          [OPTS] preview   | " Git files (git ls-files)
Shortcut! <leader>fl   (fzf.vim)  :BLines<CR>         [QUERY]           | " Lines in the current buffer     expose line in buffer
Shortcut! <leader>fL   (fzf.vim)  :Lines<CR>          [QUERY]           | " Lines in loaded buffers         expose line in any buffer
Shortcut! <leader>ft   (fzf.vim)  :BTags<CR>          [QUERY] preview   | " Tags in the current buffer    ; expose tag in buffer
Shortcut! <leader>fT   (fzf.vim)  :Tags<CR>           [QUERY] preview   | " Tags in the project (ctags -R); expose tag in any buffer
Shortcut! <leader>fm   (fzf.vim)  :Marks<CR>                            | " Marks                           expose mark in buffer
Shortcut! <leader>fM   (fzf.vim)  :Maps<CR>                             | " Normal mode mappings            trigger mapping / keybinding / shortcut
Shortcut! <leader>fj   (fzf.vim)  :Jumps<CR>                            | " Jumps
Shortcut! <leader>fw   (fzf.vim)  :Windows<CR>                          | " Windows                         expose window in any tab
Shortcut! <leader>fh   (fzf.vim)  :History<CR>                preview   | " Open buffers history            reopen file from history
Shortcut! <leader>f:   (fzf.vim)  :History:<CR>                         | " Command history                 repeat command from history
Shortcut! <leader>f/   (fzf.vim)  :History/<CR>                         | " Search history                  repeat search from history
Shortcut! <leader>f?   (fzf.vim)  :Helptags<CR>                         | " Help tags                       open help topic
Shortcut! <leader>fs   (fzf.vim)  :Snippets<CR>                         | " Snippets (UltiSnips)
Shortcut! <leader>fc   (fzf.vim)  :Commits <CR>  [LOG_OPTS]   preview   | " Git commits (requires fugitive.vim) browse git log
Shortcut! <leader>fC   (fzf.vim)  :BCommits<CR>  [LOG_OPTS]   preview   | " Git commits (requires fugitive.vim) browse git log for buffer
Shortcut! <leader>f;   (fzf.vim)  :Commands<CR>                         | " Commands                            run command from menu
Shortcut! <leader>fS   (fzf.vim)  :call fzf#sonictemplate#run()<CR>     | " template (sonictemplate)
Shortcut! <leader>f.   (fzf.vim.ext) :FZFNeigh<CR>                      | " open file under buffer's directory
Shortcut! :Filetypes<CR>                                                | " File types                          open help topic
Shortcut! :Colors<CR>                                                   | " apply colorscheme                    apply filetype
Shortcut! :execute 'Files' expand('%:h')<CR>                            | " open file under buffer's directory
Shortcut! :execute 'GFiles' expand('%:h')<CR>                           | " open git file under buffer's directory

" Enable per-command history.
" CTRL-N and CTRL-P will be automatically bound to next-history and
" previous-history instead of down and up. If you don't like the change,
" explicitly bind the keys to down and up in your $FZF_DEFAULT_OPTS.
let g:fzf_history_dir = '~/.local/share/fzf-history'

"-----------------------------------------------------------------------------
" NEXT AND PREVIOUS                               *fugitive* (fugitive)
"-----------------------------------------------------------------------------
Shortcut :call feedkeys(':GMove '.expand('%'), 't')<CR>   (fugitive)  git mv: rename file
Shortcut :call feedkeys(':GMove! '.expand('%'), 't')<CR>  (fugitive)  git mv -f: rename file forcefully
Shortcut :Git blame<CR>                                   (fugitive)  git blame: who changed which line
Shortcut :Git commit<CR>                                  (fugitive)  git commit: record new commit
Shortcut :Git commit --amend<CR>                          (fugitive)  git commit --amend
Shortcut :Git commit --amend --reuse-message=HEAD<CR>     (fugitive)  git commit --amend --reuse-message=HEAD
Shortcut :Gdiffsplit<CR>                                  (fugitive)  git diff: show changes against repository
Shortcut :Gedit<CR>                                       (fugitive)  return to editing git buffer
Shortcut :Gread<CR>                                       (fugitive)  git checkout: revert buffer to repository
Shortcut :Gread!<CR>                                      (fugitive)  git checkout -f: revert buffer to repository forcefully
Shortcut :Gstatus<CR>                                     (fugitive)  open git status window
Shortcut :Gwrite<CR>                                      (fugitive)  git add: stage all changes in buffer
Shortcut :Gwrite!<CR>                                     (fugitive)  git add -f: stage all changes in buffer forcefully
Shortcut bdelete<CR>:GRemove<Bar>                         (fugitive)  git rm: delete file from repository
Shortcut :GRemove!<Bar>bdelete<CR>                        (fugitive)  git rm -f: delete file from repository forcefully
