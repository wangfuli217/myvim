
" https://vimjc.com/vim-commands-and-vim-mapping-conf.html 常用Vim命令及实用Vim按键映射配置

" nnoremap         <F5> :update<CR>:source %<CR>
" nnoremap <leader><F5> :update<CR>:source %<CR>

" [vim-dispatch] 异步执行+语法糖和命令 :term make异步调用make
" makeprg 用于设置执行:make时使用那个命令行程序 --> term make
" errorformat 可以定义一些便于识别的错误格式
" compiler 用于指定其他的编译器插件,它也会修改编译器的输出格式
"autocmd FileType cpp   set makeprg="g++ -Wall -Wextra -std=c++11 ". expand("%") . " && ./a.out"
""    autocmd FileType c      set makeprg="gcc\ -Wall\ -o\ %<\ %"<CR>
autocmd FileType lua    set makeprg="lua ".expand("%")
autocmd FileType python set makeprg="python ".expand("%")
autocmd FileType bash   set makeprg="bash ".expand("%")
autocmd FileType sh     set makeprg="bash ".expand("%")
autocmd FileType perl   set makeprg=perl\ -c\ %\ $* errorformat=%f:%l:%m
" augroup END
" autocmd FileType c          set makeprg="gcc\ '%'\ -o\ '%:r'\ -std=gnu99\ -Wall"
autocmd FileType python     set makeprg=echo\ OK
autocmd FileType c          set makeprg=gcc\ -g\ -Wall\ -Wno-sign-compare\ %
" autocmd FileType cpp        set makeprg=g++\ -g\ -Wall\ -Wno-sign-compare\ %

autocmd Filetype sh set equalprg=shfmt\ -i\ 2
autocmd Filetype python set equalprg=yapf
autocmd Filetype javascript,javascript.jsx set equalprg=prettier\ --parser=babylon
autocmd Filetype json set equalprg=prettier\ --parser=json
autocmd Filetype css,scss,less set equalprg=prettier\ --parser=css
autocmd Filetype yaml set equalprg=prettier\ --parser=yaml
autocmd Filetype markdown set equalprg=tidy-markdown
autocmd Filetype c,cpp set equalprg=clang-format\ --style=Google
autocmd FileType cpp,java setlocal equalprg=astyle\ -A1sCSNLYpHUEk1xjcn
autocmd Filetype html set equalprg=html-beautify\ --indent-size=2\ --no-preserve-newlines\ -
autocmd Filetype xml set equalprg=xmllint\ --format\ -

autocmd BufEnter * lcd %:p:h   " change to directory of current file automatically
nnoremap <c-x><c-o> <c-o><CR>  " termial in windows
nnoremap <c-x><c-i> <c-i><CR>  " termial in windows

autocmd BufWritePost *tmux.conf !tmux source-file %

" Hex read
nmap <leader>hr :%!xxd<CR> :set filetype=xxd<CR>

" Hex write
nmap <leader>hw :%!xxd -r<CR> :set binary<CR> :set filetype=xxd<CR>

nmap <leader>g* :noautocmd vimgrep -n /<C-R><C-W>/j **/*<CR>:cwin<CR>      # 搜索光标下word单词 递归目录
nmap <leader>g# :noautocmd vimgrep -n /<C-R><C-W>/j *   <CR>:cwin<CR>      # 搜索光标下word单词 本目录
nmap <leader>g% :noautocmd vimgrep -n /<C-R><C-W>/j %   <CR>:cwin<CR>      # 搜索光标下word单词 本文件
nmap <leader>sf :noautocmd vimgrep -n /\<<C-R><C-W>\>/j %   <CR>:cwin<CR>  # 搜索光标下word单词 递归目录
nmap <leader>sd :noautocmd vimgrep -n /\<<C-R><C-W>\>/j *   <CR>:cwin<CR>  # 搜索光标下word单词 本目录
nmap <leader>sr :noautocmd vimgrep -n /\<<C-R><C-W>\>/j **/*<CR>:cwin<CR>  # 搜索光标下word单词 本文件
nmap <leader>ss :noautocmd vimgrep -n /<C-r>//j **/*<CR>:cwin<CR>          # 搜索刚搜索单词
nmap <leader>sF :noautocmd vimgrep -n /\<<C-R><C-A>\>/j %   <CR>:cwin<CR>  # 搜索光标下word单词 递归目录
nmap <leader>sD :noautocmd vimgrep -n /\<<C-R><C-A>\>/j *   <CR>:cwin<CR>  # 搜索光标下word单词 本目录
nmap <leader>sR :noautocmd vimgrep -n /\<<C-R><C-A>\>/j **/*<CR>:cwin<CR>  # 搜索光标下word单词 本文件
" :argdo
" :bufdo
" :tabdo
" :windo
" :map <c-x>; :map <c-a>; :map <c-c>; :map <c-\>; :map \;

let g:which_key_map =  {}
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" recently used or append
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap <Tab> %
vnoremap <Tab> %
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" F1-F12 显示方式 和 <leader>F1-F12 插件窗口  快捷键 F5编译/执行 <leader>F5执行
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""" F1-F12 快捷键
" 代码显示
nnoremap <F2> :set nu!   nu?<CR>
nnoremap <F3> :set list! list?<CR>
nnoremap <F4> :set relativenumber! relativenumber?<CR>

" :set makeprg=gcc\ -Wall\ -omain\ main.c
" :make -> :compiler! helloworld -> compiler/helloworld.vim
augroup ccompile
    autocmd Filetype c      nnoremap   <F5> <Esc>:w<CR>:!gcc % -std=gnu99 -g -o %< -pthread -lrt -lm -O1 <CR>
    autocmd Filetype cpp    nnoremap   <F5> <Esc>:w<CR>:!g++ % -std=c++11 -g -o %< -pthread -lrt -lm -O1 <CR>
    autocmd Filetype python nnoremap   <F5> <Esc>:w<CR>:!ipython  % <CR>
    autocmd Filetype java   nnoremap   <F5> <Esc>:w<CR>:!javac % <CR>
    autocmd Filetype sh     nnoremap   <F5> <Esc>:w<CR>:term bash  % <CR>
    autocmd Filetype perl   nnoremap   <F5> <Esc>:w<CR>:term perl % <CR>
    autocmd Filetype lua    nnoremap   <F5> <Esc>:w<CR>:term lua   % <CR>
    autocmd Filetype js     nnoremap   <F5> <Esc>:w<CR>:term node  % <CR>
    autocmd Filetype vim    nnoremap   <F5> <Esc>:w<CR>:source % <CR>
augroup END

augroup crun
    autocmd Filetype c    nnoremap <leader><F5> <Esc>:!gcc % -std=gnu99 -g -o %< -pthread -lrt -lm -O1 <CR>:! ./%< <CR>
    autocmd Filetype cpp  nnoremap <leader><F5> <Esc>:!g++ % -std=c++11 -g -o %< -pthread -lrt -lm -O1 <CR>:! ./%< <CR>
    autocmd Filetype java nnoremap <leader><F5> <ESC>:!javac % <CR>:java %< <CR>
    autocmd Filetype sh   nnoremap <leader><F5> <Esc>:w<CR>:vert term bash  % <CR>
    autocmd Filetype perl nnoremap <leader><F5> <Esc>:w<CR>:vert terminal perl  % <CR>
    autocmd Filetype lua  nnoremap <leader><F5> <Esc>:w<CR>:vert term lua   % <CR>
    autocmd Filetype js   nnoremap <leader><F5> <Esc>:w<CR>:vert term node  % <CR>
    autocmd Filetype vim  nnoremap <leader><F5> <Esc>:w<CR>:source % <CR>
augroup END

" redefine F1-F12 hotkey
if filereadable(".vimenv")
    source ./.vimenv
    nnoremap <c-x><c-k> :CMakeHelpPopup <C-R>=expand("<cword>")<CR><CR>  "<c-c> quit popup
endif

" +[-ljson-c] + [-O1 -fsanitize=address -fno-omit-frame-pointer]
" nnoremap   <F5> <Esc>:w<CR>:!clang % -std=gnu99 -ljson-c -g -o %< -pthread -lrt -lm -O1 -fsanitize=address -fno-omit-frame-pointer <CR>
" nnoremap <leader><F5> <Esc>:!clang % -std=gnu99 -ljson-c -g -o %< -pthread -lrt -lm -O1 -fsanitize=address -fno-omit-frame-pointer <CR>:! ./%< <CR>

augroup snippets
    autocmd Filetype text  nnoremap <c-a>k <Esc>:vs ~/.vim/plugged/vim-snippets/snippets/_.snippets<CR><CR>
    autocmd Filetype c     nnoremap <c-a>k <Esc>:vs ~/.vim/plugged/vim-snippets/snippets/c.snippets<CR><CR>
    autocmd Filetype cpp   nnoremap <c-a>k <Esc>:vs ~/.vim/plugged/vim-snippets/snippets/cpp.snippets<CR><CR>
    autocmd Filetype java  nnoremap <c-a>k <Esc>:vs ~/.vim/plugged/vim-snippets/snippets/java.snippets<CR><CR>
    autocmd Filetype sh    nnoremap <c-a>k <Esc>:vs ~/.vim/plugged/vim-snippets/snippets/sh.snippets<CR><CR>
    autocmd Filetype perl  nnoremap <c-a>k <Esc>:vs ~/.vim/plugged/vim-snippets/snippets/perl.snippets<CR><CR>
    autocmd Filetype lua   nnoremap <c-a>k <Esc>:vs ~/.vim/plugged/vim-snippets/snippets/lua.snippets<CR><CR>
    autocmd Filetype vim   nnoremap <c-a>k <Esc>:vs ~/.vim/plugged/vim-snippets/snippets/vim.snippets<CR><CR>
    autocmd Filetype cmake nnoremap <c-a>k <Esc>:vs ~/.vim/plugged/vim-snippets/snippets/cmake.snippets<CR><CR>

    autocmd Filetype text  nnoremap <c-a><c-k> <Esc>:vs ~/.vim/vim-mysnippet<CR><CR>
    autocmd Filetype c     nnoremap <c-a><c-k> <Esc>:vs ~/.vim/vim-mysnippet/c<CR><CR>
    autocmd Filetype perl  nnoremap <c-a><c-k> <Esc>:vs ~/.vim/vim-mysnippet/perl<CR><CR>
    autocmd Filetype sh    nnoremap <c-a><c-k> <Esc>:vs ~/.vim/vim-mysnippet/sh<CR><CR>
    autocmd Filetype cmake nnoremap <c-a><c-k> <Esc>:vs ~/.vim/vim-mysnippet/cmake<CR><CR>
    autocmd Filetype lua   nnoremap <c-a><c-k> <Esc>:vs ~/.vim/vim-mysnippet/lua<CR><CR>
    autocmd Filetype make  nnoremap <c-a><c-k> <Esc>:vs ~/.vim/vim-mysnippet/make<CR><CR>

    autocmd Filetype c     nnoremap <c-x>k      <Esc>:Man  <C-R>=expand("<cword>")<CR><CR>
    autocmd Filetype c     nnoremap <c-x><c-k>  <Esc>:Vman <C-R>=expand("<cword>")<CR><CR>
    autocmd Filetype perl  nnoremap <c-x>k      :Perldoc<CR>
    autocmd Filetype perl  nnoremap <c-x><c-k>  :Perldoc<CR>
    autocmd Filetype cmake nnoremap <c-x>k      <Esc>:CMakeHelpPopup <C-R>=expand("<cword>")<CR><CR>
    autocmd Filetype cmake nnoremap <c-x><c-k>  <Esc>:CMakeHelpPopup <C-R>=expand("<cword>")<CR><CR>
augroup END

" 代码格式化
augroup format
    autocmd Filetype c     nnoremap <F6> :FixWhitespace<CR>:Autoformat<CR>:ClangFormat<CR>:w!<CR>:!dos2unix %<CR>
    autocmd Filetype cpp   nnoremap <F6> :FixWhitespace<CR>:Autoformat<CR>:ClangFormat<CR>:w!<CR>:!dos2unix %<CR>
    autocmd Filetype sh    nnoremap <F6> :FixWhitespace<CR>:Autoformat<CR>:shfmt -l -w -i 2 -ci % <CR>:w!<CR>:!dos2unix %<CR>
augroup END
nnoremap <F6> :FixWhitespace<CR>:Autoformat<CR>:w!<CR>:!dos2unix %<CR>

" 静态代码扫描
augroup format
    " autocmd Filetype c     nnoremap <F7> <ESC>:new|read !cppcheck   --std=c99 --enable=warning,style -v #<CR>
    " autocmd Filetype sh    nnoremap <F7> <ESC>:new|read !shellcheck #<CR>
    " autocmd Filetype perl  nnoremap <F7> <ESC>:new|read !perlcritic #<CR>
    autocmd Filetype c     nnoremap <F7> :!cppcheck   --std=c99 --enable=warning,style -v %<CR>
    autocmd Filetype sh    nnoremap <F7> :!shellcheck %<CR>
    autocmd Filetype perl  nnoremap <F7> :!perlcritic %<CR>
augroup END
nnoremap <F7> :SyntasticToggleMode<CR><CR>

nnoremap <F8> :edit! %<CR>
nnoremap <F9> :set paste! paste?<CR>
nnoremap <F10> :set hlsearch! hlsearch?<CR>
nnoremap <F11> :PreviewTag<cr>
inoremap <F11> <c-o>:PreviewTag<cr>

set background=dark         " Assume a dark background
" Allow to trigger background
function! ToggleBG()
    let s:tbg = &background
    " Inversion
    if s:tbg == "dark"
        set background=light
    else
        set background=dark
    endif
endfunction
noremap <F12> :call ToggleBG()<CR>


" 自说明帮助
nnoremap <leader><F1> :e $MYVIMRC<CR>
" 扩展窗口
nnoremap <leader><F2> :Tagbar<CR>
nnoremap <leader><F3> :NERDTreeRefreshRoot<CR>:NERDTreeToggle<CR>
nnoremap <leader><F4> :CtrlPMixed<CR>
nnoremap <leader><F6> :AV<CR>
nnoremap <leader><F7> :MundoToggle<CR>
nnoremap <leader><F8> :TigOpenCurrentFile<CR>
nnoremap <leader><F9> :TigOpenProjectRootDir<CR>
nnoremap <leader><F10> :vert terminal<CR>
nnoremap <leader><F11> <Esc>:w<CR>:!ctags --language-force=sh % <CR>:set ft=sh<CR>:set tags=./tags<CR>

let g:which_key_map['h'] = {
            \ 'name' : '+F1-F12' ,
            \ 'F1' :   ['help', 'vimhelp'],
            \ 'F2' :   ['set nu!', 'toggle number'],
            \ 'F3' :   ['set list!', 'toggle list'],
            \ 'F4' :   ['set wrap!', 'toggle wrap'],
            \ 'F5' :   ['Compile', 'compile c/cpp java'] ,
            \ 'F6' :   [':Autoformat', 'Autoformat'],
            \ 'F7' :   [':SyntasticToggleMode', 'SyntasticToggleMode'],
            \ 'F8' :   ['edit! %', 'update buffer'],
            \ 'F9' :   ['set paste!', 'toggle paste'],
            \ 'F10' :  ['set hlsearch!', 'toggle hlsearch'],
            \ 'F11' :  [':PreviewTag', 'switch Tag definition'],
            \ 'F12' :  ['ToggleBG', 'toggle background'],
            \ '\F1' :  [':e $MYVIMRC', 'reread $MYVIMRC'],
            \ '\F2' :  [':Tagbar', 'better Taglist'],
            \ '\F3' :  [':NERDTreeToggle', 'NERDTreeToggle'],
            \ '\F4' :  [':CtrlPMixed', 'CtrlP'],
            \ '\F5' :  ['Run', 'run perl lua bash c/c++ vimscript'],
            \ '\F6' :  [':AV', 'switch header/source'],
            \ '\F7' :  [':MundoToggle','undo list'],
            \ '\F8' :  [':TigOpenCurrentFile','Tig@CurrentFile'],
            \ '\F9' :  [':TigOpenProjectRootDir','Tig@RootDir'],
            \ '\F10' : [':vert terminal', 'vertical terminal'],
            \ '\F11' : [':shnote', 'ctags ft=sh add=tags'],
            \ '\F12' : ['TODO', 'TODO'],
            \ }
nnoremap <silent> <c-x><c-h>    :WhichKey! which_key_map.h<CR>
nnoremap <silent> <c-x>h        :WhichKey! which_key_map.h<CR>

"""" 跳转再优化
" 把下一个查找匹配项所在的行显示在屏幕的最中间
nnoremap <silent> n nzz
nnoremap <silent> N Nzz
nnoremap <silent> * *zz
nnoremap <silent> # #zz
nnoremap <silent> g* g*zz
" 代码跳转后居中 + 多选择跳转:nmap <c-]> g<c-]>
nnoremap <silent> <c-]> g<c-]>zz
nnoremap <silent> <c-o> g<c-o>zz
nnoremap <silent> <c-i> g<c-i>zz
" 执行删除<silent> 操作时插入断点 Ctrl-G u (类似commit的操作)
" inoremap <silent> <silent> <c-u> <c-g>u<c-u>
" inoremap <silent> <c-w> <c-g>u<c-w>
" inoremap <silent> , ,<c-g>u
" inoremap <silent> . .<c-g>u
" inoremap <silent> / /<c-g>u
" inoremap <silent> \ \<c-g>u
" inoremap <silent> ; ;<c-g>u
" inoremap <silent> : :<c-g>u
" inoremap <silent> ' '<c-g>u
" inoremap <silent> " "<c-g>u
" inoremap <silent> [ [<c-g>u
" inoremap <silent> ] ]<c-g>u
" inoremap <silent> { {<c-g>u
" inoremap <silent> } }<c-g>u
" 开启折行显示选项时,按屏幕行移动

" \j 与下行连接
nnoremap <silent> \j @="Jj"<CR>
nnoremap <silent> <expr> \j "Jj"
nnoremap <silent> j gj
nnoremap <silent> k gk
" Makes gj/gk move by virtual lines when used without a count, and by physical lines when used with a count.
" nnoremap <silent> <expr> j (v:count == 0 ? 'gj' : 'j')
" nnoremap <silent> <expr> k (v:count == 0 ? 'gk' : 'k')

"""" 命令转快捷键
" 将命令行命令:q :w映射成\q \w
" Quit
inoremap <C-Q>     <esc>:q<cr>
nnoremap <C-Q>     :q<cr>
vnoremap <C-Q>     <esc>
nnoremap <leader>q :q<cr>
nnoremap <leader>Q :qa!<cr>
" Save
inoremap <C-s>     <C-O>:update<cr>
nnoremap <leader>s :update<cr>
nnoremap <leader>w :update<cr>

nnoremap <leader>w :w<CR>       " \w == :w
nnoremap <leader>m m,           " \m == m,

" Repeat last substitution, including flags, with &.
nnoremap & :&&<CR>
xnoremap & :&&<CR>

" 编辑copy paste
nnoremap <leader>sa ggVG"       " select All
vnoremap < <gv                  " > 用于增加缩进
vnoremap > >gv                  " < 用于减少缩进
vnoremap <leader>y "+           | " Linux粘贴板
" vnoremap <leader>y "*         | " Windows粘贴板
nnoremap <leader>v "+p          | " Linux粘贴板 粘贴
inoremap <leader>v <esc>"+p     | " Linux粘贴板 粘贴
vnoremap <leader>v "+p          | " Linux粘贴板 粘贴
nnoremap <leader>c "+y          | " Linux粘贴板 复制
vnoremap <leader>c "+y          | " Linux粘贴板 复制
""" Some shortcuts for system clipboards
noremap <leader>d "+d
noremap <leader>D "*d
noremap <leader>p "+p
noremap <leader>P "*p
noremap <leader>y "+y
noremap <leader>Y "*y
"" END editing keybindings

" Yank from the cursor to the end of the line, to be consistent with C and D.
nnoremap Y y$

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" remove space; remove ^M; remove tab; remove all; \sh shell file type
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" \rs                 一键去除全部尾部空白
imap <leader>rs <esc>:let _s=@/<bar>:%s/\s\+$//e<bar>:let @/=_s<bar>:nohl<cr>
nmap <leader>rs :let _s=@/<bar>:%s/\s\+$//e<bar>:let @/=_s<bar>:nohl<cr>
vmap <leader>rs <esc>:let _s=@/<bar>:%s/\s\+$//e<bar>:let @/=_s<bar>:nohl<cr>

" \rm                 一键去除全部 ^M 字符
imap <leader>rm <esc>:%s/<c-v><c-m>//g<cr>
nmap <leader>rm :%s/<c-v><c-m>//g<cr>
vmap <leader>rm <esc>:%s/<c-v><c-m>//g<cr>

" \rt                 一键替换全部 Tab 为空格
nmap <leader>rt <esc>:retab<cr>

" \ra                 一键清理当前代码文件
nmap <leader>ra <esc>\rt<esc>\rs<esc>gg=G<esc>gg<esc>

" \sh
nmap <leader>sh <esc>:set ft=sh<CR>
let g:which_key_map['r'] = {
            \ 'name' : '+remove' ,
            \ 's' :   ['<space>', 'remove space'],
            \ 'm' :   ['^M', 'remove ^M'],
            \ 't' :   ['Tab', 'switch Tab to space'],
            \ 'a' :   ['all', '<space> ^M Tab'],
            \ 'sh' :  ['sh', ''],
            \ }
nnoremap <silent> <c-x><c-r> :WhichKey! which_key_map.r<CR>
nnoremap <silent> <c-x>r     :WhichKey! which_key_map.r<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim tab buffer simulate tmux windows manager; windows simulate pane
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""" tab
nnoremap <silent> <C-s>c :tabnew<cr>
nnoremap <silent> <C-s>b :tab ba<cr>
nnoremap <silent> <C-s>x :tabclose<cr>
nnoremap <silent> <C-s>s :tabs<cr>
nnoremap <silent> <C-s>0 :tabfirst<cr>
nnoremap <silent> <C-s>w <C-w>t<cr>
nnoremap <silent> <C-s><C-c> :tabnew<cr>
nnoremap <silent> <C-s><C-x> :tabclose<cr>
nnoremap <silent> <C-s><C-s> :tabs<cr>
nnoremap <silent> <C-s><C-0> :tabfirst<cr>

nnoremap <silent> <C-s>n gt
nnoremap <silent> <C-s>p gT
nnoremap <silent> <C-s><C-n> gt
nnoremap <silent> <C-s><C-p> gT
nnoremap <silent> <C-s>f :tabfirst<cr>
nnoremap <silent> <C-s>l :tablast<cr>
nnoremap <silent> <C-s><C-f> :tabfirst<cr>
nnoremap <silent> <C-s><C-l> :tablast<cr>

nnoremap <silent> <C-s>1 1gt
nnoremap <silent> <C-s>2 2gt
nnoremap <silent> <C-s>3 3gt
nnoremap <silent> <C-s>4 4gt
nnoremap <silent> <C-s>5 5gt
nnoremap <silent> <C-s>6 6gt
nnoremap <silent> <C-s>7 7gt
nnoremap <silent> <C-s>8 8gt
nnoremap <silent> <C-s>9 9gt

let g:which_key_map['s'] = {
            \ 'name' : '+tab' ,
            \ 'c' :  [':tabnew', 'new tab'],
            \ 'b' :  [':tab ba', 'buffer -> tab'],
            \ 'x' :  [':tabclose', 'close tab'],
            \ 't' :  [':tabs', 'list tab'],
            \ '0' :  [':tabfirst', 'first tab'],
            \ 'n' :  ['gt', 'next tab'],
            \ 'p' :  ['gT', 'previous tab'],
            \ 'f' :  [':tabfirst', 'first tab'],
            \ 'l' :  [':tablast', 'last tab'],
            \ '1' :  ['1gt', '1s tab'],
            \ '2' :  ['2gt', '2s tab'],
            \ '3' :  ['3gt', '3s tab'],
            \ '4' :  ['4gt', '4s tab'],
            \ '5' :  ['5gt', '5s tab'],
            \ '6' :  ['6gt', '6s tab'],
            \ '7' :  ['7gt', '7s tab'],
            \ '8' :  ['8gt', '8s tab'],
            \ '9' :  ['9gt', '9s tab'],
            \ }
nnoremap <silent> <c-x><c-s> :WhichKey! which_key_map.s<CR>
nnoremap <silent> <c-x>s     :WhichKey! which_key_map.s<CR>

nnoremap <silent> <leader>n <down>
nnoremap <silent> <leader>p <up>
nnoremap <silent> <leader>1 1gt
nnoremap <silent> <leader>2 2gt
nnoremap <silent> <leader>3 3gt
nnoremap <silent> <leader>4 4gt
nnoremap <silent> <leader>5 5gt
nnoremap <silent> <leader>6 6gt
nnoremap <silent> <leader>7 7gt
nnoremap <silent> <leader>8 8gt
nnoremap <silent> <leader>9 9gt
nnoremap <silent> <leader>0 :tabs<cr>
let g:which_key_map.1 = 'which_key_ignore'
let g:which_key_map.2 = 'which_key_ignore'
let g:which_key_map.3 = 'which_key_ignore'
let g:which_key_map.4 = 'which_key_ignore'
let g:which_key_map.5 = 'which_key_ignore'
let g:which_key_map.6 = 'which_key_ignore'
let g:which_key_map.7 = 'which_key_ignore'
let g:which_key_map.8 = 'which_key_ignore'
let g:which_key_map.9 = 'which_key_ignore'
let g:which_key_map.0 = 'which_key_ignore'

"""" buffer(args) b conflict with tmux, use screen hotkey a
nnoremap <silent> <C-a>a :ls<CR>
nnoremap <silent> <C-a>b :tab ba<CR>
nnoremap <silent> <C-a>0 :bfirst<CR>
nnoremap <silent> <C-a>c :new<CR>
nnoremap <silent> <C-a>x :bdelete<CR>
nnoremap <silent> <C-a><C-a> :ls<CR>
nnoremap <silent> <C-a><C-0> :bfirst<CR>
nnoremap <silent> <C-a><C-c> :new<CR>
nnoremap <silent> <C-a><C-x> :bdelete<CR>

nnoremap <silent> <C-a>n :bnext<CR>
nnoremap <silent> <C-a>p :bprev<CR>
nnoremap <silent> <C-a><C-n> :bnext<CR>
nnoremap <silent> <C-a><C-p> :bprev<CR>
nnoremap <silent> <C-a>f :bfirst<cr>
nnoremap <silent> <C-a>l :blast<cr>
nnoremap <silent> <C-a><C-f> :bfirst<cr>
nnoremap <silent> <C-a><C-l> :blast<cr>
                               "c-^ e#
nnoremap <silent> <C-a>1 :b1<cr>  " e#1
nnoremap <silent> <C-a>2 :b2<cr>  " e#2
nnoremap <silent> <C-a>3 :b3<cr>  " e#3
nnoremap <silent> <C-a>4 :b4<cr>  " e#4
nnoremap <silent> <C-a>5 :b5<cr>  " e#5
nnoremap <silent> <C-a>6 :b6<cr>  " e#6
nnoremap <silent> <C-a>7 :b7<cr>  " e#7
nnoremap <silent> <C-a>8 :b8<cr>  " e#8
nnoremap <silent> <C-a>9 :b9<cr>  " e#9

let g:which_key_map['a'] = {
            \ 'name' : '+buffer' ,
            \ 'c' :   [':new', 'new buffer'],
            \ 'b' :   [':tab ba', 'buffer -> tab'],
            \ 'x' :   [':bdelete', 'close buffer'],
            \ 't' :   [':list', 'list buffer'],
            \ '0' :   [':bfirst', 'first buffer'],
            \ 'n' :   ['bnext', 'next buffer'],
            \ 'p' :   ['bprev', 'previous buffer'],
            \ 'f' :   [':bfirst', 'first buffer'],
            \ 'l' :   [':blast', 'last buffer'],
            \ '1' :  ['1b', '1s buffer'],
            \ '2' :  ['2b', '2s buffer'],
            \ '3' :  ['3b', '3s buffer'],
            \ '4' :  ['4b', '4s buffer'],
            \ '5' :  ['5b', '5s buffer'],
            \ '6' :  ['6b', '6s buffer'],
            \ '7' :  ['7b', '7s buffer'],
            \ '8' :  ['8b', '8s buffer'],
            \ '9' :  ['9b', '9s buffer'],
            \ 'c-^' :  ['Ctrl+^', 'switch buffer'],
            \ }
nnoremap <silent> <c-x><c-a> :WhichKey! which_key_map.a<CR>
nnoremap <silent> <c-x>a     :WhichKey! which_key_map.a<CR>

let g:which_key_map['b'] = {
            \ 'name' : '+tmux' ,
            \ 'c' : ['new', 'new window'],
            \ '&' : ['kill', 'kill window'],
            \ 'w' : ['list', 'list window'],
            \ 'n' : ['wnext', 'next window'],
            \ 'p' : ['wprev', 'previous window'],
            \ ',' : ['rename', 'rename window'],
            \ 'c-s':['save', 'save session'],
            \ 'c-r':['restore', 'restore session'],
            \ '$' : ['rename', 'rename session'],
            \ ')' : ['snext', 'next session'],
            \ '(' : ['sprev', 'previous session'],
            \ 'd' : ['detach', 'detach session'],
            \ 'c-z':['suspend', 'suspend session'],
            \ 'z' : ['pane<->win', 'pane<->win'],
            \ '!' : ['pane->win', 'pane->win'],
            \ 'vs%"|-':   ['v|split', 'split pane'],
            \ 'HJKL←↑↓→': ['jump', 'jump pane'],
            \ 'x':        ['kill', 'kill pane'],
            \ 'o':        ['swap', 'swap pane'],
            \ 's-p' :     ['log', 'toggle log'],
            \ 'a-p' :     ['capture', 'capture screen'],
            \ }
nnoremap <silent> <c-x><c-b> :WhichKey! which_key_map.b<CR>
nnoremap <silent> <c-x>b     :WhichKey! which_key_map.b<CR>

"""" reload buffer
nnoremap <C-a>u :e!<CR>redraw<CR>
nnoremap <C-a>U :bufdo :e!<CR>redraw<CR>

"""" windows
" tmux % == CTRL-W_s
" tmux " == CTRL-W_v
" tmux x == CTRL-W_c
nnoremap <silent> <C-w>z     <C-w>|
nnoremap <silent> <C-w><C-z> <C-w>|
nnoremap <silent> <C-w>Z     <C-w>_
" shortcuts for opening new split windows
nnoremap <silent> <leader>h :split<CR><C-w><C-w>
nnoremap <silent> <leader>v :vsplit<CR><C-w><C-w>
nnoremap <silent> <leader>q :q<CR>
nnoremap <silent> <leader>Q :q!<CR>

let g:which_key_map['w'] = {
            \ 'name' : '+windows' ,
            \ 'w' : ['<C-W>w'     , 'other-window']          ,
            \ 'c' : ['<C-W>c'     , 'delete-window']         ,
            \ 's' : ['<C-W>s'     , 'split-window-below']    ,
            \ 'v' : ['<C-W>v'     , 'split-window-right']    ,
            \ 'h' : ['<C-W>h'     , 'window-left']           ,
            \ 'j' : ['<C-W>j'     , 'window-below']          ,
            \ 'l' : ['<C-W>l'     , 'window-right']          ,
            \ 'k' : ['<C-W>k'     , 'window-up']             ,
            \ '=' : ['<C-W>='     , 'balance-window']        ,
            \ 'p' : ['<C-W>p'     , 'previous-window']       ,
            \ 'x' : ['<C-W>x'     , 'switch-window']        ,
            \ '_' : ['<C-W>_'     , 'ssplit-window-max']    ,
            \ '|' : ['<C-W>|'     , 'vsplit-window-max']    ,
            \ 'o' : [':only'      , 'only windows']         ,
            \ 'q' : [':quit'      , 'quit current window' ] ,
            \ }
nnoremap <silent> <c-x><c-w>    :WhichKey! which_key_map.w<CR>
nnoremap <silent> <c-x>w        :WhichKey! which_key_map.w<CR>


"""" QuickFix
nnoremap <silent> <C-c>c :copen<CR>
nnoremap <silent> <C-c>x :cclose<CR>
nnoremap <silent> <C-c>p :cnext<CR>
nnoremap <silent> <C-c>n :cprevious<CR>
nnoremap <silent> <C-c>f :cfirst<CR>
nnoremap <silent> <C-c>l :clast<CR>
nnoremap <silent> <C-c><C-c> :copen<CR>
nnoremap <silent> <C-c><C-x> :cclose<CR>
nnoremap <silent> <C-c><C-p> :cnext<CR>
nnoremap <silent> <C-c><C-n> :cprevious<CR>
nnoremap <silent> <C-c><C-f> :cfirst<CR>
nnoremap <silent> <C-c><C-l> :clast<CR>

let g:which_key_map['c'] = {
            \ 'name' : '+cwindow' ,
            \ 'c' :   [':copen', 'open cwindow'],
            \ 'x' :   [':cclose', 'close cwindow'],
            \ 'n' :   ['cnext','next cwindow'],
            \ 'p' :   ['cprevious', 'previous cwindow'],
            \ 'f' :   [':cfirst', 'first cwindow'],
            \ 'l' :   [':clast', 'last cwindow'],
            \ 'c-w+p' :  ['Ctrl-w+p', 'switch window'],
            \ }
nnoremap <silent> <c-x><c-c> :WhichKey! which_key_map.c<CR>
nnoremap <silent> <c-x>c     :WhichKey! which_key_map.c<CR>
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" misc session buffertotab termianl and AutoTag
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""" session
nnoremap <C-a>s :wall<CR>:mksession!     ./.session.vim<CR>
nnoremap <C-a>r :source                  ./.session.vim<CR>
nnoremap <C-a><C-s> :wall<CR>:mksession! ./.session.vim<CR>
nnoremap <C-a><C-r> :source              ./.session.vim<CR>
set sessionoptions=buffers              " Save hidden, unloaded buffers in session
set ssop+=help                          " Save the help window(s)
set ssop+=localoptions                  " Keep any local options or mappings
set ssop+=resize                        " Size of the Window: 'lines' and 'columns'
set ssop+=slash                         " Replace back with fack in session file
set ssop+=tabpages                      " Store all tabs in session
set ssop+=unix                          " Use Unix line endings for session file
set ssop+=winpos                        " Position of the Vim Window
set ssop+=winsize                       " Size of each window

"""" 把buffer中的文件全转成tab # :bufdo tab split 或者 :tab sball
nnoremap <C-a>t :bufdo tab split<CR>
nnoremap <C-a><c-t> :bufdo tab split<CR>

"""" Terminal
nnoremap <C-a>T :vert terminal<CR>

"""" Tag
nnoremap <C-a>P :!touch ./.project<CR>

let g:which_key_map['x'] = {
            \ 'name' : '+misc' ,
            \ 's' :   ['mksession', 'make session'],
            \ 'r' :   ['source', 'reload session'],
            \ 't' :   ['buffer->tab','buffer to tab'],
            \ 'T' :   ['terminal', 'open terminal'],
            \ 'P' :   ['project', 'touch .project for ctag'],
            \ 'c-xh' : ['F1-F12', 'help [leader]F1-F12'],
            \ 'c-xr' : ['space', 'help [leader]rm space'],
            \ 'c-xs' : ['tab', 'help [c-s]tab'],
            \ 'c-xa' : ['buffer', 'help [c-a]buffer'],
            \ 'c-xb' : ['tmux', 'help [c-b]tmux'],
            \ 'c-xw' : ['window', 'help [c-w]window'],
            \ 'c-xc' : ['quickfix',    'help [c-c]quickfix'],
            \ 'c-xx' : ['which', 'help [c-x]which_key_map'],
            \ 'c-xm' : ['bookmark', 'help [c-m]bookmark'],
            \ 'c-xp' : ['plug', 'help cmd plug'],
            \ 'c-xd' : ['comment', 'help [leader]comment'],
            \ 'c-xf' : ['cscope', 'help [c-\]cscope'],
            \ 'c-xg' : ['git', 'help [leader]fugitive'],
            \ 'c-xk'   : ['Man', 'horizontal manual'],
            \ 'c-xc-k' : ['Vman', 'vertical manual'],
            \ 'c-ak'   : ['snippets', 'public snippets'],
            \ 'c-ac-k' : ['mysnippets', 'private snippets'],
            \ '.vimenv' : ['./.vimenv', 'user redefine viml'],
            \ }
nnoremap <silent> <c-x><c-x> :WhichKey! which_key_map.x<CR>
nnoremap <silent> <c-x>x     :WhichKey! which_key_map.x<CR>
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim mark simulate tmux windows manager
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""" vim-bookmarks
nnoremap <C-m>t :BookmarkToggle<CR>
nnoremap <C-m>a :BookmarkAnnotate<CR>
nnoremap <C-m>m :BookmarkShowAll<CR>
nnoremap <C-m>n :BookmarkNext<CR>
nnoremap <C-m>p :BookmarkPrev<CR>
nnoremap <C-m>x :BookmarkClear<CR>
nnoremap <C-m>c :BookmarkClearAll<CR>
nnoremap <C-m>u :BookmarkMoveUp<CR>
nnoremap <C-m>d :BookmarkMoveDown<CR>
nnoremap <C-m>l :BookmarkMoveToLine<CR>
nnoremap <C-m>s :BookmarkSave ./.bookmark<CR>
nnoremap <C-m>r :BookmarkLoad ./.bookmark<CR>

nnoremap <C-m><C-t> :BookmarkToggle<CR>
nnoremap <C-m><C-a> :BookmarkAnnotate<CR>
nnoremap <C-m><C-m> :BookmarkShowAll<CR>
nnoremap <C-m><C-n> :BookmarkNext<CR>
nnoremap <C-m><C-p> :BookmarkPrev<CR>
nnoremap <C-m><C-x> :BookmarkClear<CR>
nnoremap <C-m><C-c> :BookmarkClearAll<CR>
nnoremap <C-m><C-u> :BookmarkMoveUp<CR>
nnoremap <C-m><C-d> :BookmarkMoveDown<CR>
nnoremap <C-m><C-l> :BookmarkMoveToLine<CR>
nnoremap <C-m><C-s> :BookmarkSave ./.bookmark<CR>
nnoremap <C-m><C-r> :BookmarkLoad ./.bookmark<CR>

let g:which_key_map['m'] = {
            \ 'name' : '+bookmark' ,
            \ 't' :   ['BookmarkToggle', 'toggle bookmark'],
            \ 'a' :   ['BookmarkAnnotate', 'annotate bookmark'],
            \ 'm' :   ['BookmarkShowAll','showall bookmark'],
            \ 'n' :   ['BookmarkNext', 'next bookmark'],
            \ 'p' :   ['BookmarkPrev', 'previous bookmark'],
            \ 'x' :   ['BookmarkClear', 'clear bookmark'],
            \ 'c' :   ['BookmarkClearAll', 'clearall bookmarks'],
            \ 'u' :   ['BookmarkMoveUp','move bookmark up'],
            \ 'd' :   ['BookmarkMoveDown', 'move bookmark down'],
            \ 'l' :   ['BookmarkMoveToLine', 'move bookmark to line'],
            \ 's' :   ['BookmarkSave', 'save ./.bookmark'],
            \ 'r' :   ['BookmarkLoad', 'load ./.bookmark'],
            \ }
nnoremap <silent> <c-x><c-m> :WhichKey! which_key_map.m<CR>
nnoremap <silent> <c-x>m     :WhichKey! which_key_map.m<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" cnoremap and inoremap simulate readline
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" cnoremap
" Ctrl + p 和 Ctrl + n 来跳转到上一个/下一个条目
cnoremap <c-n> <down>
cnoremap <c-p> <up>
cnoremap <c-a> <Home>
cnoremap <c-e> <End>
cnoremap <c-b> <Left>
cnoremap <c-f> <Right>
cnoremap <c-d> <Del>
" %% for current buffer file name
" :: for current buffer file path
cnoremap %% <c-r>=expand('%')<cr>
cnoremap :: <c-r>=expand('%:p:h')<cr>/

cnoremap w!! w !sudo tee >/dev/null %   " w! save changes even if file is read-only, provided user has appropriate permissions

" inoremap
inoremap <c-a> <home>
inoremap <c-e> <end>
inoremap <c-b> <left>
inoremap <c-f> <right>
inoremap <c-z> <Esc>zza

" Insert mode navigation similar to <C-g>j and <C-g>k
inoremap <silent> <C-g>l     <right>
inoremap <silent> <C-g>h     <left>
inoremap <silent> <C-g><C-l> <right>
inoremap <silent> <C-g><C-h> <left>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vimrc macros
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" /usr/share/vim/vim81/pack/dist/opt/matchit/autoload
packadd! matchit    " 扩展了%命令的功能,支持if/else/endif语法结构;支持HTML标签.

set clipboard+=unnamed        " 与windows共享剪切板
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vimrc
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if has('autocmd')
    " Remove ALL autocommands for the current group
    au!
endif
let mapleader="\\"
let localleader="\\"

nnoremap s% :source %<cr>     " vim script source
nnoremap r% :read! %<cr>      " vim script reload

" vimrc defaults file
source $VIMRUNTIME/defaults.vim
" Fast reloading of the .vimrc
nnoremap ss :source $MYVIMRC<cr>
" Fast editing of .vimrc
nnoremap ee :tabe $MYVIMRC<cr>
" When .vimrc is edited, reload it
nnoremap rr :e %<cr>

" autocmd BufWritePost $MYVIMRC source $MYVIMRC

augroup enableAutoReloadVimrc
    autocmd!
    autocmd BufWritePost *vimrc source ${MYVIMRC} | set foldmethod=marker
    autocmd BufWritePost *gvimrc if has('gui_running') source source ${MYVIMRC}
augroup END

augroup enableAutoSaveSession
    autocmd!
    " autocmd VimLeave * mksession! ./session.vim
    " autocmd VimEnter * source ./session.vim
augroup END
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 基本配置
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 关闭兼容模式
set nocompatible        " disable backwards-compatible with vi
set shortmess=atI       " 关闭乌干达儿童提示
set diffopt=filler,vertical " Keep files aligned, default to vsplit
set splitright              " Open vertical splits on the right

" 高亮显示匹配的括号
set showmatch           " set show matching parenthesis
" set paste               " 粘贴保持格式

" 启用鼠标
" set mouse=a
" set selection=exclusive
" set selectmode=mouse,key

" 设置编码utf-8
set fileencoding=utf-8
set encoding=utf-8
set tenc=utf-8
set fileencodings=ucs-bom,utf-8,cp936,gb18030,big5,euc-jp,euc-kr,latin1
language message en_US.UTF-8
set helplang=cn

" term 与 t_Co 有的颜色主题可能还与终端与终端色数量有关
" 启用256色
set t_Co=256
" 颜色主题 是放在运行时各路径的 colors/ 子目录的 *.vim 文件
" colorscheme这是个单独的命令,不是 set 选项.选择一个颜色主题
" :colorscheme + 主题名 -> :colorscheme helloworld -> colors/helloworld.vim
colorscheme desert " darkblue
" background 背景是深色 dark 或浅色 light, 有的 colorscheme 只适于深色或 浅色背景,有的则分别为不同背景色定义不同的颜色主题
" set background=dark

set ttyfast                " Faster redrawing.
set lazyredraw             " Only redraw when necessary.

set splitbelow             " Open new windows below the current window.
set splitright             " Open new windows right of the current window.
set clipboard+=unnamed,unnamedplus     " 复制到系统寄存器(*) 复制到系统寄存器(+)
set history=1000           " 最大历史记录 (default is 20)

" 开启语法高亮功能
syntax enable
" 允许用指定语法高亮配色方案替换默认方案 | " Enable syntax highlighting.
syntax on
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"设置行号 + 行号的列宽
set number
" set numberwidth=4
" set numberwidth?

" 突出显示当前行和当前列
" set cursorline
" set cursorcolumn
let g:indentLine_enabled = 1 " indentLine 开启代码对齐线

" 只想让这个效果出现在当前窗口,而且在插入模式中关闭这个效果
autocmd InsertLeave,WinEnter * set cursorline
autocmd InsertEnter,WinLeave * set nocursorline

" 关闭自动折行
set nowrap
set whichwrap-=<,>,h,l              " 设置光标键不跨行
"set whichwrap=b,s,h,l,<,>,~,[,] " everything wraps
"             | | | | | | | | |
"             | | | | | | | | +-- "]" Insert and Replace
"             | | | | | | | +-- "[" Insert and Replace
"             | | | | | | +-- "~" Normal
"             | | | | | +-- <Right> Normal and Visual
"             | | | | +-- <Left> Normal and Visual
"             | | | +-- "l" Normal and Visual (not recommended)
"             | | +-- "h" Normal and Visual (not recommended)
"             | +-- <Space> Normal and Visual
"             +-- <BS> Normal and Visual
set virtualedit-=block,onemore      " 不允许光标出现在最后一个字符的后面
set wrapscan                        " Searches wrap around end-of-file.
set report      =0                  " Always report changed lines.
set synmaxcol   =200                " Only highlight the first 200 columns.
set shortmess-=S                    " display number of search matches & index of a current match

" 插入模式下在哪里允许 <BS> 删除光标前面的字符.逗号分隔的三个值分别指:行首的空白字符,换行符和插入模式开始处之前的字符.
set backspace=indent,eol,start      " allow backspacing over everything in insert mode
set confirm                         " Show confirm dialog
set hidden                          " Switch between buffers without having to save first
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 显示状态栏
set laststatus=2
" 底部显示
" 在底部显示当前模式
set showmode            " Show current mode in command-line.
" 在底部显示当前指令
set showcmd             " Show already typed keys when more are expected.
" 在状态栏中显示光标所在位置
set ruler
" |-- VISUAL --                   2f     43,8   17% |
" +-------------------------------------------------+
"  ^^^^^^^^^^^                  ^^^^^^^^ ^^^^^^^^^^
"   'showmode'                 'showcmd'  'ruler'

" 状态行显示的内容
" 自定义状态行
set statusline=%1*\%<%.50F\             " 显示当前文件相对路径
set statusline+=%=%2*\%y%m%r%h%w\       " 显示文件类型和文件状态
set statusline+=%3*\%{&ff}\[%{&fenc}]\  " 显示文件编码类型
set statusline+=%4*\ row:%l/%L,col:%c\  " 显示光标所在行与列
set statusline+=%5*\%3p%%\              " 显示当前光标位置百分比

" :highlight 可以查看高亮显示组的颜色定义
hi User1 cterm=none ctermfg=25 ctermbg=0
hi User2 cterm=bold ctermfg=1 ctermbg=0
hi User3 cterm=bold ctermfg=1 ctermbg=0
hi User4 cterm=bold ctermfg=6 ctermbg=0
hi User5 cterm=bold ctermfg=green ctermbg=0
" 总是显示状态行
set laststatus=2        " Always show statusline.
set display=lastline    " Show as much as possible of the last line.

" vim命令自动补全: 状态行上显示补全匹配, 按了 <Tab> 后有多于一个匹配的情况
set wildmenu                    " turn on command line completion wild style
set wildmode=longest:list,full
set wildignore=*.dll,*.exe,*.gif,*.jpg,*.mm ",*.png,*.snag,*.ssd,*.xmind " 影响 expand() globpath()和glob()的结果,这些函数被很多插件用来在系统中执行查找
set wildignore+=*/.git/*,*/.hg/*,*/.svn/*          " Linux/MacOSX
" set wildignore+=*\\.git\\*,*\\.hg\\*,*\\.svn\\*  " Windows ('noshellslash')
set esckeys       " Allow cursor keys in insert mode
set modeline      " Respect modeline in files
set modelines=4

" 按 Esc 的生效更快速.通常 Vim 要等待一秒来看看 Esc 是否是转义序列的开始.如果你使用很慢的远程连接,增加此数值
" set timeout
" set timeoutlen=100
" 如果末行被截短,显示 @@@ 而不是隐藏整行
set display=truncate
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 空格和tab键
set nolist
set listchars=tab:>-,trail:-
if has('multi_byte') && &encoding ==# 'utf-8'
    let &listchars = 'tab:▸ ,extends:❯,precedes:❮,nbsp:±'
else
    let &listchars = 'tab:> ,extends:>,precedes:<,nbsp:.'
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"禁用错误报警声音和图标
set noerrorbells
set novisualbell
set t_vb=

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"禁止生成临时文件
set nobackup
set noswapfile

" Put all temporary files under the same directory.
" https://github.com/mhinz/vim-galore#handling-backup-swap-undo-and-viminfo-files
" 如果文件夹不存在,则新建文件夹
if !isdirectory($HOME.'/.vim/files') && exists('*mkdir')
    call mkdir($HOME.'/.vim/files')
endif
" 备份文件
set backup                                  " make backup files
set backupdir   =$HOME/.vim/files/backup/   " where to put backup files
set backupext   =-vimbackup                 "
set backupskip  =$HOME/.vim/files/backup/   " Don't create backups when editing files in certain directories
" 交换文件
set directory   =$HOME/.vim/files/swap/
set updatecount =100
" 撤销文件
set undofile
set undodir     =$HOME/.vim/files/undo/
set undolevels  =1000 " use many muchos levels of undo
" viminfo 文件
set viminfo     ='100,n$HOME/.vim/files/info/viminfo
set viminfo=<100,'100,/50,:100,h,r$TEMP:,s10
"           |    |    |   |    | |       + 不保存超过10KB寄存器
"           |    |    |   |    | + 不保存TEMP目录下文件的相关信息
"           |    |    |   |    + 载入viminfo文件时关闭hlsearch高亮
"           |    |    |   + 保存命令历史条数
"           |    |    + 保存搜索历史条数
"           |    + 保存最近100个文件中的标记
"           + 每个寄存器中保存的行数
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 格式控制
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""" 自动探测
" 开启文件类型侦测
filetype on
" 根据侦测到的不同类型加载对应的插件
filetype plugin on
" 文件类型检查,自适应不同语言的智能缩进
filetype indent on
filetype plugin indent on  " Load plugins according to detected filetype.

"文件自动检测外部更改
set autoread
set autowrite

"formatoptions(TODO) 控制自动格式化文本的许多选项
"""" 手动设置
"textwidth(TODO) 文本行宽度,超过该宽度(默认78)时自动加回车换回

" 按下回车键后,下一行的缩进会自动跟上一行的缩进保持一致(插入模式下回车自动缩进)
set autoindent      " Indent according to previous line
set copyindent      " copy the previous indentation on autoindenting
set smartindent

" 将制表符扩展为空格
set expandtab       " Use spaces instead of tabs
"" make/cmake
augroup vimrc-make-cmake
    autocmd!
    autocmd FileType make setlocal noexpandtab
    autocmd BufNewFile,BufRead CMakeLists.txt setlocal filetype=cmake
augroup END

" 设置格式化时制表符占用空格数
set shiftwidth=4    " >> indents by 4 spaces.
set shiftround      " >> indents to next multiple of 'shiftwidth'.
" 设置编辑时制表符占用空格数
set tabstop=4        " 硬制表符宽度
" 让 vim 把连续数量的空格视为一个制表符
set softtabstop=4   " Tab key indents by 4 spaces.
set smarttab        " insert tabs on the start of a line according to shiftwidth, not tabstop

"c文件自动缩进
set cindent
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 拼写
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"拼写检查
set nospell

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 搜索
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 高亮搜索结果
set hlsearch        " Keep matches highlighted.

" nnoremap <Esc> :nohlsearch<CR>       # 影响<UP><DOWN>键
" inoremap <Esc> <Esc>:nohlsearch<CR>  # 影响<UP><DOWN>键
" nnoremap <esc><esc> :nohl<CR>
" no highlight after search
" noremap  <C-n> :nohl<CR>
" vnoremap <C-n> :nohl<CR>
" inoremap <C-n> :nohl<CR>

" 自动跳转到第一个匹配的结果
set incsearch       " show search matches as you type
" 搜索时只小写字母忽略大小写,有大写字母则大小写敏感
set ignorecase      " ignore case when searching
set infercase       " ignore case when auto-complete
set smartcase       " ignore case if search pattern is all lowercase, case-sensitive otherwise
set ignorecase smartcase " 搜索词全部是小写时,进行大小写不敏感搜索;当搜索词 至少有1个大写字母时,进行大小写敏感搜索

" n 始终为向后搜索,N 始终为向前搜索
nnoremap <expr> n  'Nn'[v:searchforward]
nnoremap <expr> N  'nN'[v:searchforward]
""""""""""""""""""""""""""""""""""""""""
" 折叠 za:打开或关闭当前折叠/zM:关闭所有折叠/zR:打开所有折叠
""""""""""""""""""""""""""""""""""""""""
set nofoldenable                          "启动 vim 时关闭折叠代码
" set foldenable                          "允许折叠
set fdm=syntax                            "基于语法进行代码折叠
set fdm=manual                            "手动折叠
set foldmethod=indent                     "基于缩进进行代码折叠
set foldlevel=99

" 用空格键来切换折叠,即相当于命令 za,但如果当前行根本就没有折叠,那就无所谓切换折叠了,那就换用命令 } 跳到下一个空行
nnoremap <Space> @=(foldlevel(line('.'))>0) ? "za" : "}"<CR>
nnoremap <expr> <Space> (foldlevel(line('.'))>0) ? "za" : "}"
function! ToggleFold()
    if foldlevel(line('.')) > 0
        return "za"
    else
        return "}"
    endif
endfunction
nnoremap <expr> <Space> ToggleFold()
nnoremap <leader>f0 :set foldlevel=0<CR>
nnoremap <leader>f1 :set foldlevel=1<CR>
nnoremap <leader>f2 :set foldlevel=2<CR>
nnoremap <leader>f3 :set foldlevel=3<CR>
nnoremap <leader>f4 :set foldlevel=4<CR>
nnoremap <leader>f5 :set foldlevel=5<CR>
nnoremap <leader>f6 :set foldlevel=6<CR>
nnoremap <leader>f7 :set foldlevel=7<CR>
nnoremap <leader>f8 :set foldlevel=8<CR>
nnoremap <leader>f9 :set foldlevel=9<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" .vim/autoload/plug.vim 自动载入脚本 PlugInstall/PlugUpdate/PlugClean/PlugUpgrade/
" :help packages
" https://github.com/shiqf/dotfiles TODO Read
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Install vim-plug if it isn't already
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" mkdir -p ~/.vim/pack/plugins/start 创建一个存储插件的目录
packloadall             "加载所有插件
silent! helptags ALL    "为所有插件加载帮助文档
" https://zhuanlan.zhihu.com/p/58816187 插件说明 vim-rainbow 插件
" https://github.com/yyq123/learn-vim   帮助文档
call plug#begin('~/.vim/plugged')
Plug 'vim-scripts/vim-addon-mw-utils'  " 代码片段提示/函数库
Plug 'tomtom/tlib_vim'                 " 代码片段提示/函数库
Plug 'SirVer/ultisnips'                " 代码片段提示/替换引擎
Plug 'honza/vim-snippets'              " 代码片段提示/各种各样的snippets
" Plug 'Valloric/YouCompleteMe'          " 代码补全 sudo apt-get install build-essential cmake python-dev python3-dev; ./install.py --clang-completer
" YCM 的高性能 + coc.nvim 的富交互 + vim-lsp 的 API 设计 = EasyComplete 的极简和纯粹

Plug 'jayli/vim-easycomplete'          " 余杭区最好用的vim补全插件(vim 8.2及以上,nvim 0.4.4 及以上版本) :EasyCompleteGotoDefinition :EasyCompleteCheck :EasyCompleteInstallServer ${Plugin_Name} set dictionary=${Your_Dictionary_File}
Plug 'skywind3000/vim-dict'            " VIM 词表收集
Plug 'mattn/webapi-vim'                " Gist 代码段 API
Plug 'mattn/vim-gist'                  " Gist 代码段 命令
Plug 'bronson/vim-trailing-whitespace' " 去除文档多余的空白符 ws
Plug 'vim-autoformat/vim-autoformat'   " 代码格式化
Plug 'rhysd/vim-clang-format'          " apt install clang-format;

Plug 'tpope/vim-commentary'            " 注释 gcc {count}gc gcap
Plug 'tpope/vim-unimpaired'            " ]b和[b循环遍历缓冲区; ]f和[f循环遍历同一目录中的文件,并打开为当前缓冲区; ]l和[l遍历位置列表; ]q和[q遍历快速修复列表; ]t和[t遍历标签列表; yos切换拼写检查,或yoc切换光标行高亮显示
Plug 'vim-scripts/DoxygenToolkit.vim', {'for': ['c', 'cpp']}  " 注释 DoxAuthor Dox DoxBlock DoxAll

Plug 'junegunn/vim-peekaboo'           " \" Ctrl+R 显示寄存器内容
Plug 'Yilin-Yang/vim-markbar'          " '`        显示mark的内容
Plug 'kshenoy/vim-signature'           " mark 记录标注;  m[a-zA-Z]:打标签,打两次就撤除/ m,:自动设定下一个可用书签名; mda:删除当前文件中所有独立书签
Plug 'MattesGroeger/vim-bookmarks'     " bookmarks Ctrl-M

Plug 'ludovicchabant/vim-gutentags'    " 管理tag文件 | ctags索引生成,方便变量,函数的跳转查询  ~/.cache/tags/mnt-d-cygwin64-home-wangfuli-openwrt-netifd-.tags
Plug 'vim-scripts/taglist.vim'         " 浏览tags,文件内跳转 Tlist   set tags=tags;
Plug 'preservim/tagbar'                " 浏览tags,文件内跳转 Tagbar  set tags=tags;
Plug 'skywind3000/vim-preview'         " 预览tags中的函数       F11
Plug 'vim-scripts/a.vim'               " 源文件/头文件之间跳转 :A :AS :AV :AN

" netrw Ex/Sex/Vex/Lex 左右分割方式,当前Netrw窗口位于最左边,且高度占满整个屏幕 :Ex sftp://<domain>/<directory> 列出目录内容, :e scp://<domain>/<directory>/<file> 编辑文件
Plug 'vim-scripts/winmanager'          " 文件系统管理 WMToggle/wm
Plug 'jlanzarotta/bufexplorer'         " opened buffer管理 \bs \bv \bt \be
Plug 'preservim/nerdtree'              " directory管理 NERDTreeToggle/tree; :Bookmark命令来收藏当前光标在NERDTree中选择的目录; B列出所以书签
" Plug 'bagrat/vim-buffet'             " buffer管理
Plug 'kien/ctrlp.vim'                  " find模糊搜索 <Ctrl>+p :CtrlP 或 :CtrlP {path} 或 :CtrlPBuffer 或 :CtrlPMRU 或 :CtrlPMixed
" <leader>vv 搜索光标所在单词,并匹配出所有结果 <leader>vV 搜索光标所在单词,全词匹配
" <leader>va vv结果添加到之前的搜索列表        <leader>vA vV把结果添加到之前的搜索列表
" <leader>vr 全局搜索光标所在单词,并替换想要的单词
" :Grep [arg]                       # 类似 <leader>vv, 使用 ! 类似<leader>vV
" :GrepAdd [arg]                    # 类似 <leader>va, 使用 ! 类似<leader>vA
" :Replace [target] [replacement]   # 类似 <leader>vr
" :ReplaceUndo                      # 撤销替换操作
Plug 'dkprice/vim-easygrep'            " grep模糊查找
" Plug 'junegunn/fzf.vim'              " 模糊搜索
Plug 'jiangmiao/auto-pairs'            " 括号自动补全

Plug 'vim-airline/vim-airline'         " 状态栏
Plug 'vim-airline/vim-airline-themes'  " 状态栏主题

Plug 'yianwillis/vimcdoc'              " vim中文文档  help
Plug 'vim-utils/vim-man'               " vim Man Vman帮助文档
Plug 'vim-scripts/CRefVim'             " c reference manual; \cr
Plug 'nanotee/nvim-lua-guide'          " lua reference manual, :help lua.table
Plug 'hotchpotch/perldoc-vim'          " apt-get install perl-doc; K hotkey
Plug 'bfrg/vim-cmake-help'             " :CMakeHelp {arg} / :CMakeHelpPopup {arg} / :CMakeHelpOnline [{arg}]
" markdown + firefox
" Plug 'iamcco/mathjax-support-for-mkdp' " 实时通过浏览器预览 markdown 文件
" Plug 'iamcco/markdown-preview.vim'     " 实时通过浏览器预览 markdown 文件 MarkdownPreview MarkdownPreviewStop

" Plug 'Yggdroot/leaderF', { 'do': ':leaderfInstallCExtension' }
" Plug 'skywind3000/vim-quickui'

Plug 'vim-syntastic/syntastic'           " ALE 异步语法检查引擎
" Plug 'yegappan/mru'                    " Most Recently opened/edited files
" Plug 'yegappan/bufselect'              " access to jump to a buffer from the Vim buffer list
" Plug 'yegappan/borland'                " Classic borland IDE like Vim color scheme

" Plug 'mbbill/undotree'                 " 可视化管理内容变更历史记录的插件
Plug 'simnalamburt/vim-mundo'            " 可视化管理内容变更历史记录的插件 :MundoToggle -> Gundo
" Plug 'Konfekt/FastFold'                " 让 Vim 按需更新折叠内容,而不是一直调用

Plug 'vim-scripts/a.vim'               " swtich between source files and header files
" Plug 'octol/vim-cpp-enhanced-highlight' " c++ syntax highlighting
" Plug 'xavierd/clang_complete'          " uses clang for accurately completing C and C++ code

Plug 'liuchengxu/vim-which-key'          " c-xc-x hotkey help

Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'iberianpig/tig-explorer.vim'
" Plug 'xolox/vim-lua-ftplugin'          " Lua file type
" Plug 'tbastos/vim-lua', {'for': 'lua'} " lua的高亮和缩进
" Plug 'xolox/vim-lua-inspect'           " uses the [LuaInspect] lua-inspect tool to (automatically) perform semantic highlighting of variables in Lua source code

" Plug 'christoomey/vim-tmux-navigator'  "
Plug 'dracula/vim', { 'as': 'dracula' }
call plug#end()

colorscheme dracula

let g:which_key_map['p'] = {
            \ 'name' : '+plugin' ,
            \   'S': ['PlugSnapshot', 'snapshot'],
            \   'U': ['PlugUpgrade', 'upgrade'],
            \   'c': ['PlugClean', 'clean'],
            \   'd': ['PlugDiff', 'diff'],
            \   'i': ['PlugInstall', 'install'],
            \   's': ['PlugStatus', 'status'],
            \   'u': ['PlugUpdate', 'update'],
            \ }
nnoremap <silent> <c-x><c-p> :WhichKey! which_key_map.p<CR>
nnoremap <silent> <c-x>p     :WhichKey! which_key_map.p<CR>

" neocompletecache -> neocomplete -> deoplete/neocompletion-manager(下一代通用补全)
" CtrlP / CommandT -> Unite.vim + vimproc -> denite.vim

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 'SirVer/ultisnips' + 'honza/vim-snippets'
" <c-j>展开 <c-tab>列出snippets  <c-j>跳到下一个位置   <c-k>跳到上一个位置
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" - https://github.com/Valloric/YouCompleteMe
" - https://github.com/nvim-lua/completion-nvim
let g:UltiSnipsExpandTrigger="<tab>"
" 使用 <c-b> 切换下一个触发点, <c-z>上一个触发点
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"

" 使用 UltiSnipsEdit 命令时垂直分割屏幕
let g:UltiSnipsEditSplit="vertical"

" 配置搜索snippets文件的文件夹
" set runtimepath+="/home/wangfuli/.vim/plugged/vim-mysnippet"
let g:UltiSnipsSnippetDirectories=["UltiSnips", "vim-mysnippet"]
" 定义自己的snippets文件放置的位置
" g:UltiSnipsSnippetsDir

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 'jayli/vim-easycomplete'  :h easycomplete
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:easycomplete_tab_trigger="<c-space>"    " 唤醒补全按键:默认 Tab 键
let g:easycomplete_scheme="sharp"             " 菜单样式可以使用插件自带的四种样式(dark, light, rider, sharp)
let g:easycomplete_diagnostics_enable = 1
let g:easycomplete_signature_enable = 1

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 'skywind3000/vim-dict'
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim-dict
let g:vim_dict_dict = [
  \ '~/.vim/plugged/vim-dict/dict',
  \ '~/.vim/vim-mydict',
  \ ]
let g:vim_dict_config = {
  \ 'html':'html,javascript,css,text',
  \ 'markdown':'text',
  \ }

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 'mattn/vim-gist'
" https://www.5axxw.com/wiki/content/8sjzz7
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:gist_clip_command = 'xclip -selection clipboard' | " Linux
" let g:gist_clip_command = 'putclip'                  | " cygwin
let g:gist_detect_filetype = 1
let g:gist_open_browser_after_post = 1
let g:gist_show_privates = 1
let g:gist_post_private = 1

let github_user = 'wangfuli217'
" 命令小结
" :Gist       发布Gist
" :Gist -p    发布私有Gist
" :Gist -P    发布公开Gist
" :Gist -e    更新Gist文件名
" :Gist -s    更新Gist描述
" :Gist -d    删除Gist
" :Gist -f    克隆Gist
" :Gist +1    星标Gist
" :Gist -1    取消星标Gist
" :Gist -l    列示Gist
" :Gist -b    在浏览器中查看Gist
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 'bronson/vim-trailing-whitespace'
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap trailingwhite :FixWhitespace<cr>
nnoremap tw :FixWhitespace<cr>

" Strip whitespace - trailing whitespace - with (,ss)
function! StripWhitespace()
    let save_cursor = getpos(".")
    let old_query = getreg('/')
    :%s/\s\+$//e
    call setpos('.', save_cursor)
    call setreg('/', old_query)
endfunction
" nnoremap <leader>ss :call StripWhitespace()<cr>

" Strip annoying windows newline characters ^M
function! StripWinLineBreaks()
    let save_cursor = getpos(".")
    let old_query = getreg('/')
    :%s///g
    call setpos('.', save_cursor)
    call setreg('/', old_query)
endfunction
" nnoremap <leader>sn :call StripWinLineBreaks()<cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 'rhysd/vim-clang-format'
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" http://clang.llvm.org/docs/ClangFormatStyleOptions.html
let g:clang_format#style_options = {
            \ 'BasedOnStyle' : 'Google',
            \ 'ColumnLimit' : 160,
            \ 'MaxEmptyLinesToKeep' : 2,
            \ 'SortIncludes' : 'false',
            \ 'AllowShortLoopsOnASingleLine' : 'false',
            \ 'AllowShortLambdasOnASingleLine ' : 'false',
            \ 'AllowShortBlocksOnASingleLine' : 'false',
            \ 'AllowShortFunctionsOnASingleLine' : 'false',
            \ 'AllowShortCaseLabelsOnASingleLine' : 'false',
            \ 'AllowShortIfStatementsOnASingleLine' : 'false',
            \ 'KeepEmptyLinesAtTheStartOfBlocks': 'false',
            \ }

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 'tpope/vim-commentary'
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"为python和shell等添加注释
autocmd FileType python,shell,coffee set commentstring=#\ %s
"修改注释风格
autocmd FileType java,c,cpp set commentstring=//\ %s

" 单行注释用 gcc,多行注释先进入可视模式再 gc,取消注释用 gcu
" gcc: 注释或反注释
" gcap: 注释一段
" gc: visual 模式下直接注释所有已选择的行
" gcc{motion}            Comment or uncomment lines that {motion} moves over.
" gcc                    Comment or uncomment [count] lines.
" {Visual}gc             Comment or uncomment the highlighted lines.
" gc                     Text object for a comment (operator pending mode only.)
" gcgc                   Uncomment the current and adjacent commented lines.
" :[range]Commentary     Comment or uncomment [range] lines

let g:which_key_map.d = {
            \ 'name' : '+commentary/DoxygenToolkit',
            \ }
let g:which_key_map.d.gc = ['gcc{motion}', 'gcc{motion} motion moves over lines']
let g:which_key_map.d.gm = ['[count]gcc',  '[count]gcc [count] lines']
let g:which_key_map.d.gv = ['{Visual}gc',  '{Visual}gc highlighted lines']
let g:which_key_map.d.gr = ['[count]gcc',  ':[range]Commentary']

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 'tpope/vim-unimpaired'
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:which_key_map['u'] = {
            \ 'name' : '+unimpaired' ,
            \ 'a' :   ['[]a', 'previous/next'],
            \ 'A' :   ['[]A', 'first/last'],
            \ 'b' :   ['[]b', 'bprevious/bnext'],
            \ 'B' :   ['[]B', 'bfirst/blast'],
            \ 'l' :   ['[]l', 'lprevious/lnext'],
            \ 'L' :   ['[]L', 'lfirst/llast'],
            \ 'q' :   ['[]q', 'cprevious/cnext'],
            \ 'Q' :   ['[]Q', 'cfirst/clast'],
            \ 't' :   ['[]t', 'tabprevious/tabnext'],
            \ 'T' :   ['[]T', 'tabfirst/tablast'],
            \ 'f' :   ['[]f', 'f prev/next in dir'],
            \ 'n' :   ['[]n', 'SCM conflict prev/next'],
            \ 'Space' : [ '[]<Space>', 'n<Space> line prev/next'],
            \ 'yob'   : [ 'ob', 'background'],
            \ 'yoc'   : [ 'oc', 'cursorline'],
            \ 'yod'   : [ 'od', 'diff'],
            \ 'yoh'   : [ 'oh', 'hlsearch'],
            \ 'yoi'   : [ 'oi', 'ignorecase'],
            \ 'yol'   : [ 'ol', 'list'],
            \ 'yon'   : [ 'on', 'number'],
            \ 'yor'   : [ 'or', 'relativenumber'],
            \ 'you'   : [ 'ou', 'cursorcolumn'],
            \ 'yov'   : [ 'ov', 'virtualedit'],
            \ 'yow'   : [ 'ow', 'wrap'],
            \ 'yox'   : [ 'ox', 'cursorline/cursorcolumn' ],
            \ 'yoz'   : [ 'oz', 'spell'],
            \ }
nnoremap <silent> <c-x><c-u> :WhichKey! which_key_map.u<CR>
nnoremap <silent> <c-x>u     :WhichKey! which_key_map.u<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 'vim-scripts/DoxygenToolkit.vim'
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:load_doxygen_syntax              = 1
let g:doxygen_enhanced_color           = 1

let g:DoxygenToolkit_fileTag            = "@file     "
let g:DoxygenToolkit_briefTag_pre       = "@brief    "
let g:DoxygenToolkit_briefTag_funcName  = "yes"
let g:DoxygenToolkit_briefTag_post = ""
let g:DoxygenToolkit_authorTag          = "@author   "
let g:DoxygenToolkit_authorName         = "wangfuli<wangfl217@126.com>"
let g:DoxygenToolkit_versionTag         = "@version  "
let g:DoxygenToolkit_versionString      = "1.0.0"
let g:DoxygenToolkit_dateTag            = "@modify   "
let g:DoxygenToolkit_classTag           = "@class    "
let g:DoxygenToolkit_paramTag_pre       = "@param    "
let g:DoxygenToolkit_returnTag          = "@return   "
" let g:DoxygenToolkit_blockHeader  = '/*********************************************************************'
" let g:DoxygenToolkit_blockFooter  = '********************************************************************/'
" let g:DoxygenToolkit_startCommentTag='/*********************************************************************'
" let g:DoxygenToolkit_endCommentTag = '********************************************************************/'

let g:DoxygenToolkit_commentType = "C"

nnoremap <leader>df :Dox<CR>               | " 生成函数或者类声明
nnoremap <leader>da :DoxAuthor<CR>         | " 生成作者信息
nnoremap <leader>db :DoxBlock<CR>          | " 在后面的行中插入一个doxygen块
nnoremap <leader>dl :DoxLic<CR>            | " 生成授权说明
nnoremap <leader>du :DoxUndoc(DEBUG)!<CR>  | " 用于忽略代码块

let g:which_key_map.d.df = [':Dox',         'function/class declare']
let g:which_key_map.d.da = [':DoxAuthor',   'author declare']
let g:which_key_map.d.db = [':DoxBlock',    'block commentary']
let g:which_key_map.d.dl = [':DoxLic',      'license declare']
let g:which_key_map.d.du = [':DoxUndoc(DEBUG)!',  'ignore block']
nnoremap <silent> <c-x><c-d>    :WhichKey! which_key_map.d<CR>
nnoremap <silent> <c-x>d        :WhichKey! which_key_map.d<CR>

let s:year = strftime("%Y")
let s:gplv3 = "\<enter>"
let s:gplv3 = s:gplv3 . "<one line to give the program's name and a brief idea of what it does.>\<enter>"
let s:gplv3 = s:gplv3 . "Copyright (C) " . s:year . "  " . g:DoxygenToolkit_authorName . "\<enter>"
let s:gplv3 = s:gplv3 . "\<enter>"
let s:gplv3 = s:gplv3 . "This program is free software: you can redistribute it and/or modify\<enter>"
let s:gplv3 = s:gplv3 . "it under the terms of the GNU General Public License as published by\<enter>"
let s:gplv3 = s:gplv3 . "the Free Software Foundation, either version 3 of the License, or\<enter>"
let s:gplv3 = s:gplv3 . "(at your option) any later version.\<enter>"
let s:gplv3 = s:gplv3 . "\<enter>"
let s:gplv3 = s:gplv3 . "This program is distributed in the hope that it will be useful,\<enter>"
let s:gplv3 = s:gplv3 . "but WITHOUT ANY WARRANTY; without even the implied warranty of\<enter>"
let s:gplv3 = s:gplv3 . "MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the\<enter>"
let s:gplv3 = s:gplv3 . "GNU General Public License for more details.\<enter>"
let s:gplv3 = s:gplv3 . "\<enter>"
let s:gplv3 = s:gplv3 . "You should have received a copy of the GNU General Public License\<enter>"
let s:gplv3 = s:gplv3 . "along with this program.  If not, see <http://www.gnu.org/licenses/>.\<enter>"
let s:gplv3 = s:gplv3 . "\<enter>"
let s:gplv3 = s:gplv3 . "wangfuli <wangfl217@126.com>"
let g:DoxygenToolkit_licenseTag  = s:gplv3


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ludovicchabant/vim-gutentags setting
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" gutentags搜索工程目录的标志,碰到这些文件/目录名就停止向上一级目录递归  # openwrt/build_dir/target-mipsel-openwrt-linux-gnu/'project'
let g:gutentags_project_root = ['mkall.sh', '.sgbuilt_user', '.config', '.root', '.svn', '.git', '.project', '.built', '.configured_yyynyynnnn', '.gitignore', 'README', 'm4', 'configure', 'configure.ac', '.version', '.pc']

" 所生成的数据文件的名称
let g:gutentags_ctags_tagfile = '.tags'

" 将自动生成的 tags 文件全部放入 ~/.cache/tags 目录中,避免污染工程目录
let s:vim_tags = expand('~/.cache/tags')
let g:gutentags_cache_dir = s:vim_tags
" 检测 ~/.cache/tags 不存在就新建
if !isdirectory(s:vim_tags)
    silent! call mkdir(s:vim_tags, 'p')
endif
" autocmd BufWritePost *.py silent! !ctags -R &
" autocmd BufWritePost *.cpp *.h *.c silent! !ctags -R &

" 配置 ctags 的参数
" ctags -R --c++-kinds=+p+l+x+c+d+e+f+g+m+n+s+t+u+vI --fields=+niazS --extra=+q
let g:gutentags_ctags_extra_args = ['--fields=+niazS', '--extra=+q', '--exclude=.git', '--exclude=build']
let g:gutentags_ctags_extra_args += ['--c++-kinds=+p+l+x+c+d+e+f+g+m+n+s+t+u+vI']
let g:gutentags_ctags_extra_args += ['--c-kinds=+p+l+x+c+d+e+f+g+m+n+s+t+u+vI']
" 参数详解
" c  类(classes)
" d  宏定义(macro definitions)
" e  枚举变量(enumerators)
" f  函数定义(function definitions)
" g  枚举类型(enumeration names)
" l  局部变量(local variables),默认不提取
" m  类、结构体、联合体(class, struct, and union members)
" n  命名空间(namespaces)
" p  函数原型(function prototypes),默认不提取
" s  结构体类型(structure names)
" t  (typedefs)
" u  联合体类型(union names)
" v  变量定义(variable definitions)
" x  外部变量(external and forward variable declarations),默认不提取

" set tags+=tags文件路径
" ~/.cache/tags/mnt-d-cygwin64-home-wangfuli-openwrt-netifd-.tags
" set tags+=/usr/include/tags
" set tags+=~/.vim/systags
" set tags+=~/.vim/x86_64-linux-gnu-systags
" let g:ycm_semantic_triggers.c = ['->', '.', ' ', '(', '[', '&',']']

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Taglist setting
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let Tlist_Show_One_File=1               " 不同时显示多个文件的tag,只显示当前文件的
let Tlist_Exit_OnlyWindow=1             " 如果taglist窗口是最后一个窗口,则退出vim
let Tlist_Ctags_Cmd="/usr/bin/ctags"    " 将taglist与ctags关联
let Tlist_File_Fold_Auto_Close = 0      " 不要关闭其他文件的tags
let Tlist_Use_Right_Window = 1          " 在右侧显示窗口
" autocmd FileType h,cpp,cc,c set tags+=/usr/include/tags

" Taglist -> Tagbar(更完善的类支持)
" exuberant-ctags -> universal-ctags (Home · Universal Ctags)

nnoremap Tagbar :TagbarToggle<CR>           " 将开启tagbar的快捷键设置为　<leader>tb
let g:tagbar_ctags_bin='/usr/bin/ctags'     " 设置ctags所在路径
let g:tagbar_sort = 0                       " 设置标签不排序,默认排序

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" bfrg/vim-qf-preview setting
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:qfpreview = {'height': '40', 'offset': '10', 'sign': {'text': '>>', 'texthl': 'Search'}}

augroup qfpreview
    autocmd!
    autocmd FileType qf nmap <buffer> p <plug>(qf-preview-open)
augroup END

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" winmanager setting
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:winManagerWindowLayout = "BufExplorer,FileExplorer|TagList"
let g:winManagerWidth = 30
let g:defaultExplorer = 0
nnoremap wm :WMToggle<cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" cscope setting
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if has("cscope")
    set csprg=/usr/bin/cscope
    set csto=1
    set cst
    set nocsverb
    " add any database in current directory
    if filereadable("cscope.out")
        cs add cscope.out
    endif
    set csverb
endif

"cscope调用
" find . -type f -name  *.[c] > cscope.files; cscope -Rbkq -i cscope.files
set cscopequickfix=s-,c-,d-,i-,t-,e-

nnoremap <C-\>s :cs find s <C-R>=expand("<cword>")<CR><CR>:botright cwindow<CR><CR>
nnoremap <C-\>g :cs find g <C-R>=expand("<cword>")<CR><CR>:botright cwindow<CR><CR>
nnoremap <C-\>c :cs find c <C-R>=expand("<cword>")<CR><CR>:botright cwindow<CR><CR>
nnoremap <C-\>t :cs find t <C-R>=expand("<cword>")<CR><CR>:botright cwindow<CR><CR>
nnoremap <C-\>e :cs find e <C-R>=expand("<cword>")<CR><CR>:botright cwindow<CR><CR>
nnoremap <C-\>f :cs find f <C-R>=expand("<cfile>")<CR><CR>:botright cwindow<CR><CR>
nnoremap <C-\>i :cs find i <C-R>=expand("<cfile>")<CR><CR>:botright cwindow<CR><CR>
nnoremap <C-\>d :cs find d <C-R>=expand("<cword>")<CR><CR>:botright cwindow<CR><CR>

augroup crun
    autocmd Filetype c    nnoremap <C-\>C :!find . -type f -name "*.[chly]" -o -name "*.inc" > cscope.files; cscope -Rbkq -i cscope.files<CR><CR>
    autocmd Filetype cpp  nnoremap <C-\>C :!find . -type f -name "*.[chly]" -o -name "*.cc" -o -name "*.cpp" > cscope.files; cscope -Rbkq -i cscope.files<CR><CR>
    autocmd Filetype java nnoremap <C-\>C :!find . -type f -name "*.java" > cscope.files; cscope -Rbkq -i cscope.files<CR><CR>
    autocmd Filetype sh   nnoremap <C-\>C :!find . -type f > cscope.files; cscope -Rbkq -i cscope.files<CR><CR>
    autocmd Filetype perl nnoremap <C-\>C :!find . -type f > cscope.files; cscope -Rbkq -i cscope.files<CR><CR>
    autocmd Filetype lua  nnoremap <C-\>C :!find . -type f > cscope.files; cscope -Rbkq -i cscope.files<CR><CR>
    autocmd Filetype vim  nnoremap <C-\>C :!find . -type f > cscope.files; cscope -Rbkq -i cscope.files<CR><CR>
augroup END

nnoremap <C-\>A :cs add cscope.out<CR><CR>
let g:which_key_map['f'] = {
            \ 'name' : '+cscope' ,
            \ 's' :   [':cs find s', 'C symbol'],
            \ 'g' :   [':cs find g', 'C definition'],
            \ 'c' :   [':cs find c', 'functions calling this function'],
            \ 't' :   [':cs find t', 'this text string'],
            \ 'e' :   [':cs find e', 'this egrep pattern'],
            \ 'f' :   [':cs find f', 'this file'],
            \ 'i' :   [':cs find i', 'files #including this file'],
            \ 'd' :   [':cs find d', 'functions called by this function'],
            \ 'C' :   ['create cscope', 'create cscope'],
            \ 'I' :   ['import cscope', 'import cscope'],
            \ }
nnoremap <silent> <c-x><c-f> :WhichKey! which_key_map.f<CR>
nnoremap <silent> <c-x>f     :WhichKey! which_key_map.f<CR>
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" netrw setting
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 1 用水平拆分窗口打开文件
" 2 用垂直拆分窗口打开文件
" 3 用新建标签页打开文件
" 4 用前一个窗口打开文件
let g:netrw_browse_split = 0   "控制 <CR> 直接在当前窗口打开光标下文件
let g:netrw_sort_by = 'time'
let g:netrw_sort_direction = 'reverse'
let g:netrw_liststyle = 3       " tree 模式显示风格
let g:netrw_banner = 0          " 显示帮助信息
let g:netrw_winsize = 25        " 占用宽度
let g:netrw_list_hide= '\(^\|\s\s\)\zs\.\S\+' " 需要隐藏的文件
let g:netrw_preview = 1         " 默认是水平分割, 此项设置使之垂直分割
let g:netrw_alto = 0            " 控制预览窗口位于左侧或右侧, 与 netrw_preview 共同作用

" :Hexplore 在下边分屏浏览目录  Hexplore! 在上边分屏浏览目录
" :Vexplore 在左边分屏浏览目录  Vexplore! 在右边分屏浏览目录
" :Ex   全屏进入 netrw, 全称是 :Explorer 或者 :E
" :Sex> 水平分割进入 netrw
" :Vex> 垂直分割进入 netrw

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" MattesGroeger/vim-bookmarks
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
highlight BookmarkSign ctermbg=NONE ctermfg=160
highlight BookmarkLine ctermbg=194 ctermfg=NONE
let g:bookmark_sign = '♥'
let g:bookmark_highlight_lines = 1
let g:bookmark_save_per_working_dir = 1
let g:bookmark_auto_save = 1
let g:bookmark_no_default_key_mappings = 1

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Yilin-Yang/vim-markbar
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" only display alphabetic marks a-i and A-I
let g:markbar_marks_to_display = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ'
let g:markbar_persist_mark_names = v:false
" width of a vertical split markbar
let g:markbar_width = 30

" indentation for lines of context
let g:markbar_context_indent_block = '  '

" number of lines of context to retrieve per mark
let g:markbar_num_lines_context = 3

" ditto, but more granularly (any may be omitted)
" let g:markbar_num_lines_context = {
"     \ 'around_local': 3,           " for local marks, show 3 lines of context
"     \ 'around_file': 0,            " for file marks, show no context at all
"     \ 'peekaboo_around_local': 4,  " like above, but for the peekaboo markbar
"     \ 'peekaboo_around_file': 2,
" \ }

" open/close markbar mappings
nmap <leader>m  <Plug>ToggleMarkbar
nmap <leader>mo <Plug>OpenMarkbar
nmap <leader>mc <Plug>CloseMarkbar

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" auto-pairs setting
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
au Filetype FILETYPE let b:AutoPairs = {"(": ")"}
au FileType php      let b:AutoPairs = AutoPairsDefine({'<?' : '?>', '<?php': '?>'})

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim-airline/vim-airline setting
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" tabline 的定制格式与状态栏一样,在开多个标签页时才生效
set laststatus=2  "永远显示状态栏
let g:airline_powerline_fonts = 1                       " 支持 powerline 字体
let g:airline#extensions#tabline#enabled = 1            " 显示窗口tab和buffer
let g:airline#extensions#tabline#tab_nr_type = 1        " tab number
let g:airline#extensions#tabline#show_tab_nr = 1
let g:airline#extensions#tabline#formatter = 'default'
let g:airline#extensions#tabline#buffer_nr_show = 0
let g:airline#extensions#tabline#fnametruncate = 16
let g:airline#extensions#tabline#fnamecollapse = 2
let g:airline#extensions#tabline#buffer_idx_mode = 1
" let g:airline_theme='moloai'  " murmur配色不错

if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif
let g:airline_left_sep = '▶'
let g:airline_left_alt_sep = '❯'
let g:airline_right_sep = '◀'
let g:airline_right_alt_sep = '❮'
let g:airline_symbols.linenr = '¶'
" let g:airline_symbols.branch = '⎇'
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim-utils/vim-man setting
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" :Man printf
" :Vman 3 putc
" :Man pri<Tab>
" :Man 3 pri<Tab>
" :Man 6 <Ctrl-D>
" Ctrl-] / Ctrl-T
" Mangrep 1 foobar
" Mangrep * foobar
" Mangrep -i 6 foobar
" nnoremap <c-x>k       <Plug>(Man)     "  - open man page for word under cursor in a horizontal split
" nnoremap <c-x><c-k>   <Plug>(Vman)    "  - open man page for word under cursor in a vertical split
" nnoremap <leader>sk   <Plug>(Man)     "  - open man page for word under cursor in a horizontal split
" nnoremap <leader>vk   <Plug>(Vman)    "  - open man page for word under cursor in a vertical splits

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" bfrg/vim-cmake-help setting
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:cmakehelp = {
        \ 'maxheight': 50,
        \ 'scrollup': "\<c-k>",
        \ 'scrolldown': "\<c-j>",
        \ 'top': "\<c-t>",
        \ 'bottom': "\<c-g>"
        \ }
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" preservim/nerdtree
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1

" Use compact syntax for prettified multi-line comments
let g:NERDCompactSexyComs = 1

" Align line-wise comment delimiters flush left instead of following code indentation
let g:NERDDefaultAlign = 'left'

" Set a language to use its alternate delimiters by default
let g:NERDAltDelims_java = 1

" Add your own custom formats or override the defaults
" let g:NERDCustomDelimiters = { 'c': { 'left': '/**','right': '*/' }

" Allow commenting and inverting empty lines (useful when commenting a region)
let g:NERDCommentEmptyLines = 1

" Enable trimming of trailing whitespace when uncommenting
let g:NERDTrimTrailingWhitespace = 1

" Enable NERDCommenterToggle to check all selected lines is commented or not
let g:NERDToggleCheckAllLines = 1

"NERDTree 配置:tree快捷键显示当前目录树
nnoremap tree :NERDTreeRefreshRoot<CR>:NERDTreeToggle<CR>
let NERDTreeWinSize=25
" autocmd VimEnter * NERDTree                      " 自动开启Nerdtree
" let g:nerdtree_tabs_open_on_console_startup = 1  " 打开vim后自动开启目录树
" 忽略一下文件显示
let NERDTreeIgnore=['\.pyc','\~$','\.swp','\.o','\.out','\.fcgi','\.cgi','\.a','\.so','\.svn','\.vscode','\.git','\.project','.\root']
" 显示标记
let g:NERDTreeIndicatorMapCustom = {
            \ "Modified"  : "✹",
            \ "Staged"    : "✚",
            \ "Untracked" : "✭",
            \ "Renamed"   : "➜",
            \ "Unmerged"  : "═",
            \ "Deleted"   : "✖",
            \ "Dirty"     : "✗",
            \ "Clean"     : "✔︎",
            \ 'Ignored'   : '☒',
            \ "Unknown"   : "?"
            \ }
""修改树的显示图标
let g:NERDTreeDirArrowExpandable = '►'
let g:NERDTreeDirArrowCollapsible = '▼'
let NERDTreeAutoCenter=1

" 是否默认显示书签列表
let NERDTreeShowBookmarks = 1
" 是否默认显示隐藏文件
let NERDTreeShowHidden = 1

" 不知道是什么含义,再开发机上,含有+的字符打不开,文件名不可能含有+
" 因此设置为+,不设置的话,第一个字符都是虚的.
let g:NERDTreeNodeDelimiter = '+'

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" kien/ctrlp.vim
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" <c-o> - 打开被 <c-z> 标记的文件 1. t - 在新标签页中打开; 2. v - 在一个竖直分割窗口中; 3. h - 在一个水平分割窗口中; 4. r - 在当前窗口中打开.
" <c-n> 提示符面板历史里的下一个字符串; <c-p> 提示符面板历史里的上一个字符串.
let g:ctrlp_working_path_mode = 'r'
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_custom_ignore = {
            \ 'file': '\v\.(exe|so|dll|fcgi|cgi|\.o|\.a|\.git|\.svn|\.project|\.root)$',
            \ 'link': 'some_bad_symbolic_links',
            \ }
let g:ctrlp_match_window_bottom = 1
let g:ctrlp_max_height = 15
let g:ctrlp_match_window_reversed = 0
let g:ctrlp_mruf_max = 500
let g:ctrlp_follow_symlinks = 1
let g:ctrlp_match_window = 'bottom,order:ttb,min:1,max:10,results:20'
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" dkprice/vim-easygrep
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:EasyGrepMode = 1          " All:0, Open Buffers:1, TrackExt:2
let g:EasyGrepCommand = 0       " Use vimgrep:0, grepprg:1
let g:EasyGrepRecursive  = 1    " Recursive searching
let g:EasyGrepIgnoreCase = 1    " not ignorecase:0
let g:EasyGrepFilesToExclude =  "*.bak, *~, cscope.*, *.a, *.o, *.pyc, *.bak"

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" junegunn/fzf.vim
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ^ 表示前缀精确匹配.要搜索一个以"welcome"开头的短语:^welcom.
" $ 表示后缀精确匹配.要搜索一个以"my friends"结尾的短语:friends$.
" ' 表示精确匹配.要搜索短语"welcom my friends":'welcom my friends.
" | 表示"或者"匹配.要搜索"friends"或"foes":friends | foes.
" ! 表示反向匹配.要搜索一个包含"welcome"但不包含"friends"的短语:welcome !friends
"
" function! s:fzf_statusline()
"   " Override statusline as you like
"   highlight fzf1 ctermfg=161 ctermbg=251
"   highlight fzf2 ctermfg=23 ctermbg=251
"   highlight fzf3 ctermfg=237 ctermbg=251
"   setlocal statusline=%#fzf1#\ >\ %#fzf2#fz%#fzf3#f
" endfunction
"
" autocmd! User FzfStatusLine call <SID>fzf_statusline()
"
" " Mapping selecting mappings
" nmap <leader><tab> <plug>(fzf-maps-n)
" xmap <leader><tab> <plug>(fzf-maps-x)
" omap <leader><tab> <plug>(fzf-maps-o)
"
" " Insert mode completion
" imap <c-x><c-k> <plug>(fzf-complete-word)
" imap <c-x><c-f> <plug>(fzf-complete-path)
" imap <c-x><c-l> <plug>(fzf-complete-line)
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim-syntastic/syntastic
" :help syntastic-commands
" :help syntastic-checkers / syntastic-checker-options
" :help syntastic
" :help syntastic-aggregating-errors
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set statusline+=%#warningmsg#                   " Recommended settings
set statusline+=%{SyntasticStatuslineFlag()}    " Recommended settings
set statusline+=%*                              " Recommended settings

" switch mode by config; switch mode by SyntasticToggleMode command;
"let g:syntastic_mode_map = { 'mode': 'passive', 'active_filetypes': "[],'passive_filetypes': []  }
let g:syntastic_mode_map = { 'mode': 'passive' } " default active; active and passive by F7
" syntax checkers and style checkers
let g:syntastic_quiet_messages = { "type": "style"  } " disable all style messages

let g:syntastic_aggregate_errors         = 1 " Run all linters, even if first found errors.
"总是打开Location List(相当于QuickFix)窗口,如果你发现syntastic因为与其他插件冲突而经常崩溃,将下面选项置0
let g:syntastic_always_populate_loc_list = 1
"自动打开Locaton List,默认值为2,表示发现错误时不自动打开,当修正以后没有再发现错误时自动关闭,
"设置1表示自动打开自动关闭,0表示关闭自动打开和自动关闭,3表示自动打开,但不自动关闭
let g:syntastic_auto_loc_list = 1 " Recommended settings
"修改Locaton List窗口高度
let g:syntastic_loc_list_height = 5
"打开文件时自动进行检查
let g:syntastic_check_on_open = 1 " Recommended settings
"自动跳转到发现的第一个错误或警告处
let g:syntastic_auto_jump = 1
"进行实时检查,如果觉得卡顿,将下面的选项置为1
let g:syntastic_check_on_wq = 0   " Recommended settings
"高亮错误
let g:syntastic_enable_highlighting=1

" g:syntastic_<filetype>_checkers 检查器配置表
let g:syntastic_cpp_include_dirs = ['/usr/include/']
let g:syntastic_cpp_compiler_options = "-Wall -Wextra -Werror -std=c++11 -stdlib=libstdc++"
let g:syntastic_cpp_check_header = 1
let g:syntastic_cpp_remove_include_errors = 1
let g:syntastic_cpp_compiler = 'clang++'
let g:syntastic_cpp_auto_refresh_includes = 1
let g:Syntastic_cpp_checkers = ['gcc'] " clang_tidy cppcheck gcc make

let g:syntastic_c_include_dirs = ['/usr/include/', '/usr/include/']
let g:syntastic_c_compiler_options = "-Wall -Wextra -Werror -std=gnu99 -pthread -lrt -lm"
let g:syntastic_c_check_header = 1
let g:syntastic_c_remove_include_errors = 1
let g:syntastic_c_compiler = 'clang'
let g:syntastic_c_auto_refresh_includes = 1
let g:Syntastic_c_checkers = ['gcc']  " clang_tidy cppcheck gcc make

let g:syntastic_sh_checkers = ['sh', 'shellcheck']
let g:syntastic_sh_shellcheck_args = '--exclude=SC2155,SC2032,SC1090,SC2033' " Ignore declare and assign on same line."

let g:syntastic_vim_checkers             = ['vint']
let g:syntastic_enable_perl_checker = 1

let g:cpp_class_scope_highlight = 1
let g:cpp_class_decl_highlight = 1
let g:cpp_experimental_simple_template_highlight = 1
let g:cpp_concepts_highlight = 1
let g:cpp_no_function_highlight = 1

"set error or warning signs
let g:syntastic_error_symbol = 'X'
let g:syntastic_warning_symbol = '!'
"whether to show balloons
let g:syntastic_enable_balloons = 1

" :SyntasticCheck 手动检测错误
" :SyntasticCheck phpcs phpmd         手动设置检测器
" :SyntasticCheck text/language_check 运行外来类型检测器
" :Errors         打开错误位置列表
" :lclose         关闭位置列表; :lnext  到下一个错误; :lprevious 到上一个错误
" :SyntasticReset 可以清除掉错误列表
" :SyntasticInfo
" :SyntasticToggleMode 来切换激活(在写到 buffer 时检测)和被动(即手动检测)检测错误
" map <C-s>e :SyntasticCheck eslint<CR>
" map <C-s>r :SyntasticCheck rubocop<CR>
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" simnalamburt/vim-mundo
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:mundo_width = 60
let g:mundo_preview_height = 40
let g:mundo_right = 1

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" tpope/vim-fugitive
" help fugitive
" help :Git
" help :Gwrite
" help :Gread
" help :Gremove
" help :Gmove
" help :Gcommit
" help :Gblame
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" :Git add %        :Gwrite              :Git add .
" :Git checkout %   :Gread
" :Git rm %         :Gremove / :Gdelete
" :Git mv %         :Gmove
" :GCommit          :Git commit -am"xxxxxx"
" :Git == git status; - 来添加或删除文件; C 调用 :Gcommit 提交当前修改 / :Git status
" :Gedit打开当前文件的index版本
" :Gvdiff出现与vimdiff命令相似的表现形式来对比当前文件和当前文件的 index 版本
" :Gblame 等价于git blame
" :Git push xxxx master
" fugitive shortcuts
nnoremap <silent> <leader>gl :Glog<CR>
nnoremap <silent> <leader>gd :Gdiff<CR>
nnoremap <silent> <leader>gb :Gblame<CR>
nnoremap <silent> <leader>gs :Gstatus<CR>
nnoremap <silent> <leader>gc :Gcommit -v<CR>
nnoremap <silent> <leader>gr :Gread<CR>
nmap              <leader>gg :Git<CR>gg<c-n>

nnoremap <silent> <leader>gt :TigOpenCurrentFile<CR>
nnoremap <silent> <leader>gT :TigOpenProjectRootDir<CR>
let g:which_key_map.g = {
            \ 'name' : '+fugitive',
            \ }
let g:which_key_map.g.B = ['Gbrowse', 'browse']
let g:which_key_map.g.d = ['Gdiff', 'diff']
let g:which_key_map.g.M = ['Gmerge', 'merge']
let g:which_key_map.g.P = ['Gpush', 'push']
let g:which_key_map.g.R = ['Grebase', 'rebase']
let g:which_key_map.g.b = ['Gblame', 'blame']
let g:which_key_map.g.c = ['Gcommit', 'commit']
let g:which_key_map.g.D = ['Gdelete', 'delete']
let g:which_key_map.g.f = ['Gfetch', 'fetch']
let g:which_key_map.g.l = ['Glog', 'log']
let g:which_key_map.g.m = ['Gmove', 'move']
let g:which_key_map.g.p = ['Gpull', 'pull']
let g:which_key_map.g.r = ['Grename', 'rename']
let g:which_key_map.g.s = ['Gstatus', 'status']
let g:which_key_map.g.t = ['TigOpenCurrentFile', 'TigOpenCurrentFile']
let g:which_key_map.g.T = ['TigOpenProjectRootDir', 'TigOpenProjectRootDir']
nnoremap <silent> <c-x><c-g> :WhichKey! which_key_map.g<CR>
nnoremap <silent> <c-x>g     :WhichKey! which_key_map.g<CR>
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" iberianpig/tig-explorer.vim
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:tig_explorer_keymap_edit_e  = 'e'
let g:tig_explorer_keymap_edit    = '<C-o>'
let g:tig_explorer_keymap_tabedit = '<C-t>'
let g:tig_explorer_keymap_split   = '<C-s>'
let g:tig_explorer_keymap_vsplit  = '<C-v>'

let g:tig_explorer_keymap_commit_edit    = '<ESC>o'
let g:tig_explorer_keymap_commit_tabedit = '<ESC>t'
let g:tig_explorer_keymap_commit_split   = '<ESC>s'
let g:tig_explorer_keymap_commit_vsplit  = '<ESC>v'

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" liuchengxu/vim-which-key
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" let g:which_key_map =  {}
let g:which_key_vertical = 0           " show popup vertically
let g:which_key_position = "botright"  " split a window at the bottom
let g:which_key_hspace   = 5           " minimum horizontal space between columns
let g:which_key_centered = 1           " make all keybindings centered in the middle
let g:which_key_group_dicts = 'start'
nnoremap <silent> <leader>      :WhichKey      '\'<CR>
nnoremap <silent> <localleader> :WhichKey      '\'<CR>
vnoremap <silent> <leader>      :<c-u>WhichKeyVisual '\'<CR>
vnoremap <silent> <localleader> :<c-u>WhichKeyVisual '\'<CR>

call which_key#register('\', "g:which_key_map")

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" tpope/surround
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nmap <C-J> yss}