set nocompatible        " disable backwards-compatible with vi

""""""""""""""""""""""""""""""
" => Visual mode related
""""""""""""""""""""""""""""""
" Visual mode pressing * or # searches for the current selection
" Super useful! From an idea by Michael Naumann
vnoremap <silent> * :<C-u>call VisualSelection('', '')<CR>/<C-R>=@/<CR><CR>
vnoremap <silent> # :<C-u>call VisualSelection('', '')<CR>?<C-R>=@/<CR><CR>"

" autocmd TermOpen term://* startinsert
tnoremap <Esc> <C-\><C-n><C-w><c-w>
" noremap <Esc>  <C-w><c-w>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" F1-F12 显示方式; 快捷键 F5编译/执行 <Leader>F5执行
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""" F1-F12 快捷键
" 代码显示
"                                                        <leader>f1 :AsyncTaskLast<cr>              <leader><F1> :call asyncrun#quickfix_toggle(6)<cr>
nnoremap <F2> :set nu!   nu?<CR>                       " <leader>f2 :AsyncTaskEdit<cr>              <leader><F2> :TagbarToggle<CR>
nnoremap <F3> :set list! list?<CR>                     " <leader>f3 :AsyncTask FZF-neigh<cr>  <leader><F3> :NERDTreeRefreshRoot<CR>:NERDTreeToggle<CR>
nnoremap <F4> :set relativenumber! relativenumber?<CR> " <leader>f4 :AsyncTask FZF-root-files<cr>   <leader><F4> :VimRegEdit y<CR><CR>

" ccompile <F5>     <--> <leader>f5 :AsyncTask file-build<cr>
augroup ccompile
    autocmd!
    autocmd Filetype c      nnoremap   <F5> <Esc>:w<CR>:AsyncRun gcc -Wall -Wextra -Wconversion "$(VIM_FILEPATH)" -std=gnu99 -g -o "$(VIM_FILEDIR)/$(VIM_FILENOEXT)" -pthread -lrt -lm -ljson-c -O1 <CR>
    autocmd Filetype cpp    nnoremap   <F5> <Esc>:w<CR>:AsyncRun g++ "$(VIM_FILEPATH)" -std=c++11 -g -o "$(VIM_FILEDIR)/$(VIM_FILENOEXT)" -pthread -lrt -lm -O1 -ljson-c <CR>
    autocmd Filetype python nnoremap   <F5> <Esc>:w<CR>:AsyncRun python     "$(VIM_FILEPATH)" <CR>
    autocmd Filetype java   nnoremap   <F5> <Esc>:w<CR>:AsyncRun javac      "$(VIM_FILEPATH)" <CR>
    autocmd Filetype sh     nnoremap   <F5> <Esc>:w<CR>:AsyncRun -raw bash  "$(VIM_FILEPATH)" <CR>
    autocmd Filetype perl   nnoremap   <F5> <Esc>:w<CR>:AsyncRun -raw perl  "$(VIM_FILEPATH)" <CR>
    autocmd Filetype lua    nnoremap   <F5> <Esc>:w<CR>:AsyncRun -raw lua   "$(VIM_FILEPATH)" <CR>
    autocmd Filetype javascript     nnoremap   <F5> <Esc>:w<CR>:AsyncRun -raw node  "$(VIM_FILEPATH)" <CR>
    autocmd Filetype vim    nnoremap   <F5> <Esc>:w<CR>:source %<CR>
augroup END

autocmd FocusLost * :wa  | " 离开Vim编辑器时,自动保存文件

" crun <leader><F5> <--> <leader>f6 :AsyncTask file-run<cr>
augroup crun
    autocmd!
    autocmd Filetype c    nnoremap <leader><F5> <Esc>:AsyncRun gcc -Wall -Wextra -Wconversion "$(VIM_FILEPATH)" -std=gnu99 -g -o "$(VIM_FILEDIR)/$(VIM_FILENOEXT)" -pthread -lrt -lm -ljson-c -O1; "$(VIM_FILEDIR)/$(VIM_FILENOEXT)" <CR>
    autocmd Filetype cpp  nnoremap <leader><F5> <Esc>:AsyncRun g++ "$(VIM_FILEPATH)" -std=c++11 -g -o "$(VIM_FILEDIR)/$(VIM_FILENOEXT)" -pthread -lrt -lm -O1  -ljson-c  <CR>
    autocmd Filetype java nnoremap <leader><F5> <ESC>:AsyncRun javac %; java %< <CR>
    autocmd Filetype sh   nnoremap <leader><F5> <Esc>:w<CR>:AsyncRun -mode=term -pos=right bash  "$(VIM_FILEPATH)" <CR>
    autocmd Filetype perl nnoremap <leader><F5> <Esc>:w<CR>:AsyncRun -mode=term -pos=right perl  "$(VIM_FILEPATH)" <CR>
    autocmd Filetype lua  nnoremap <leader><F5> <Esc>:w<CR>:AsyncRun -mode=term -pos=right lua   "$(VIM_FILEPATH)" <CR>
    autocmd Filetype javascript   nnoremap <leader><F5> <Esc>:w<CR>:AsyncRun -mode=term -pos=right node  "$(VIM_FILEPATH)" <CR>
    autocmd Filetype vim  nnoremap <leader><F5> <Esc>:w<CR>:source %<CR>
augroup END

" redefine F1-F12 hotkey
if filereadable(".vimenv")
    source ./.vimenv
    nnoremap <c-x><c-k> :CMakeHelpPopup <C-R>=expand("<cword>")<CR><CR>  "<c-c> quit popup
endif

" 代码格式化 current buffer or all opened buffer
nnoremap <F6> :FixWhitespace<CR>:Autoformat<CR>:w!<CR>:!dos2unix %<CR>
" npm install --save-dev --save-exact prettier # https://prettier.io/docs/en/install.html
augroup format
    autocmd!
    autocmd Filetype c     nnoremap <F6> :FixWhitespace<CR>:!dos2unix %<CR>:!indent -kr -i4 -ts4 -sob -ss -sc -npsl -pcs -bs -bad -bap --ignore-newlines -l96 -nut -npro -brf %<CR>:%s/\r//ga<CR>
    autocmd Filetype perl  nnoremap <F6> :FixWhitespace<CR>:!dos2unix %<CR>:!perltidy -i=4 -et=4 -ndsm -st -ce -bar -nola -l=220 %<CR>:%s/\r//ga<CR>
    autocmd Filetype cpp   nnoremap <F6> :FixWhitespace<CR>:!dos2unix %<CR>:%s/\r//ga<CR>
    autocmd Filetype sh    nnoremap <F6> :FixWhitespace<CR>:!dos2unix %<CR>:!shfmt -l -w -i 2 -ci %<CR>:%s/\r//ga<CR>
    autocmd Filetype c     nnoremap twfl :FixWhitespace<CR>:!dos2unix %<CR>:!indent -kr -i4 -ts4 -sob -ss -sc -npsl -pcs -bs --ignore-newlines -l96 -nut -npro -brf %<CR>:%s/\r//ga<CR>
    autocmd Filetype perl  nnoremap twfl :FixWhitespace<CR>:!dos2unix %<CR>:!perltidy -i=4 -et=4 -ndsm -st -ce -bar -nola -l=220 %<CR>:%s/\r//ga<CR>
    autocmd Filetype cpp   nnoremap twfl :FixWhitespace<CR>:!dos2unix %<CR>:%s/\r//ga<CR>
    autocmd Filetype sh    nnoremap twfl :FixWhitespace<CR>:!dos2unix %<CR>:!shfmt -l -w -i 2 -ci %<CR>:%s/\r//ga<CR>
augroup END

augroup format
    autocmd!
    autocmd Filetype c     nnoremap <leader><F6> :bufdo FixWhitespace<CR>:!dos2unix %<CR>:!indent -kr -i4 -ts4 -sob -ss -sc -npsl -pcs -bs -bad -bap --ignore-newlines -l96 -nut -npro -brf %<CR>:%s/\r//ga<CR>
    autocmd Filetype perl  nnoremap <leader><F6> :bufdo FixWhitespace<CR>:!dos2unix %<CR>:!perltidy -i=4 -et=4 -ndsm -st -ce -bar -nola -l=220 %<CR>:%s/\r//ga<CR>
    autocmd Filetype cpp   nnoremap <leader><F6> :bufdo FixWhitespace<CR>:!dos2unix %<CR>:%s/\r//ga<CR>
    autocmd Filetype sh    nnoremap <leader><F6> :bufdo FixWhitespace<CR>:!dos2unix %<CR>:!shfmt -l -w -i 2 -ci %<CR>:%s/\r//ga<CR>
    autocmd Filetype c     nnoremap twfl :FixWhitespace<CR>:!dos2unix %<CR>:!indent -kr -i4 -ts4 -sob -ss -sc -npsl -pcs -bs --ignore-newlines -l96 -nut -npro -brf %<CR>:%s/\r//ga<CR>
    autocmd Filetype perl  nnoremap twfl :FixWhitespace<CR>:!dos2unix %<CR>:!perltidy -i=4 -et=4 -ndsm -st -ce -bar -nola -l=220 %<CR>:%s/\r//ga<CR>
    autocmd Filetype cpp   nnoremap twfl :FixWhitespace<CR>:!dos2unix %<CR>:%s/\r//ga<CR>
    autocmd Filetype sh    nnoremap twfl :FixWhitespace<CR>:!dos2unix %<CR>:!shfmt -l -w -i 2 -ci %<CR>:%s/\r//ga<CR>
augroup END


" 静态代码扫描 current buffer or all opened buffer
" nnoremap <leader><F7> :bufdo SyntasticToggleMode<CR><CR>
augroup format
    autocmd!
    autocmd Filetype c     nnoremap <F7> :AsyncRun (cppcheck   --std=c99 --enable=warning,style -v %)<CR>
    autocmd Filetype sh    nnoremap <F7> :AsyncRun shellcheck %<CR>
    autocmd Filetype perl  nnoremap <F7> :AsyncRun perlcritic %<CR>
augroup END
" nnoremap <F7> :SyntasticToggleMode<CR><CR>

augroup format
    autocmd!
    autocmd Filetype c     nnoremap <leader><F7> :bufdo AsyncRun (cppcheck   --std=c99 --enable=warning,style -v %)<CR>
    autocmd Filetype sh    nnoremap <leader><F7> :bufdo AsyncRun shellcheck %<CR>
    autocmd Filetype perl  nnoremap <leader><F7> :bufdo AsyncRun perlcritic %<CR>
augroup END

" MaximizerToggle Windows or FZF Windows
nnoremap <silent><F8> :MaximizerToggle<CR>
vnoremap <silent><F8> :MaximizerToggle<CR>gv
inoremap <silent><F8> <C-o>:MaximizerToggle<CR>

" FloatermNext or FloatermPrev
nnoremap <F9> :FloatermNext<CR>
tnoremap <F9> <C-\><C-n>:FloatermNext<CR>

nnoremap <leader><F9> :FloatermPrev<CR>
tnoremap <leader><F9> <C-\><C-n>:FloatermPrev<CR>

" FloatermToggle or vim-terminal-help
nnoremap <F10> :FloatermToggle<CR>
tnoremap <F10> <C-\><C-n>:FloatermToggle<CR>

nnoremap <leader><F10> :call TerminalToggle()<CR><CR>
tnoremap <leader><F10> :<c-\><c-n>:call TerminalToggle()<CR><CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" <Leader>F1-F12 插件窗口 快捷键 F5编译/执行 <Leader>F5执行
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 自说明帮助
nnoremap <leader><F1> :call asyncrun#quickfix_toggle(6)<cr>
" 扩展窗口
nnoremap <leader><F2>  :TagbarToggle<CR>                           " :TagbarToggle; :TlistToggle
nnoremap <leader><F3>  :NERDTreeRefreshRoot<CR>:NERDTreeToggle<CR> " :WMToggle; :ToggleBufExplorer; :NERDTreeToggle
nnoremap <leader><F4>  :VimRegEdit y<CR><CR>                       " Edit register

" F5 AsyncRun run
" F6 bufdo: format
" F7 static-analysis

tnoremap <leader><F8> <C-\><C-n>:Windows<CR>
nnoremap <leader><F8> :Windows<CR>

" project tags or file tags
nnoremap <leader><F11> :call Gutentags()<cr>
function! g:CscopeDone()
	exec "cs add ".fnameescape(g:asyncrun_text)
endfunc

function! g:CscopeUpdate(workdir, cscopeout)
	let l:cscopeout = fnamemodify(a:cscopeout, ":p")
	let l:cscopeout = fnameescape(l:cscopeout)
	let l:workdir = (a:workdir == '')? '.' : a:workdir
	try | exec "cs kill ".l:cscopeout | catch | endtry
	exec "AsyncRun -post=call\\ g:CscopeDone() ".
				\ "-text=".l:cscopeout." "
				\ "-cwd=".fnameescape(l:workdir)." ".
				\ "cscope -b -R -f -q ".l:cscopeout
endfunc
nnoremap <F11>         <Esc>:w<CR>:!ctags --language-force=sh % <CR>:set ft=sh<CR>:set tags=./tags<CR>

" cscope generate
nnoremap <F12>         <Esc>:!find . -name "*.h" -o -name "*.c" -o -name "*.cc" > cscope.files; cscope -bkq -i cscope.files<CR>:call g:CscopeUpdate(".", "cscope.out")<cr>
nnoremap <leader><F12> <Esc>:!find . -name "*.h" -o -name "*.c" -o -name "*.cc" > cscope.files; cscope -bkq -i cscope.files<CR>:call g:CscopeUpdate(".", "cscope.out")<cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 跳转再优化
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 把下一个查找匹配项所在的行显示在屏幕的最中间
nnoremap <silent> n nzz         " 正向重复上一次搜索并居中显示结果
nnoremap <silent> N Nzz         " 反向重复上一次搜索并居中显示结果
nnoremap <silent> * *zz         " 向后搜索光标所在的单词并居中显示结果
nnoremap <silent> # #zz         " 向前搜索光标所在的单词并居中显示结果
nnoremap <silent> g* g*zz
" Format Jump
nnoremap <silent> g; g;zz
nnoremap <silent> g, g,zz
" Change j and k to add movements to the jumplist.
nnoremap <expr> k (v:count > 1 ? "m'". v:count : '') . 'gk'
nnoremap <expr> j (v:count > 1 ? "m'". v:count : '') . 'gj'

" Clear the jump list on startup.
" I have never once remembered the jumplist between multiple Vim sessions.
" Starting from a zero state each session lets me rewind/fast-forward through
" the current session movements without accidentally entering a previous and
" long-forogtten session.
au VimEnter * clearjumps

nnoremap }   }zz                " 向前移动一个段落并居中显示
nnoremap {   {zz                " 向后移动一个段落并居中显示
nnoremap ]]  ]]zz               " 跳转到下一个顶层函数并居中显示
nnoremap [[  [[zz               " 跳转到上一个顶层函数并居中显示
nnoremap []  []zz               " 跳转到上一个第一列的 } 并居中显示
nnoremap ][  ][zz               " 跳转到下一个第一列的 } 并居中显示

" 代码跳转后居中 + 多选择跳转:nmap <c-]> g<c-]>
nnoremap <silent> <c-]> g<c-]>zz
nnoremap <silent> <c-o> g<c-o>zz
nnoremap <silent> <c-i> g<c-i>zz

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" cnoremap simulate readline
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
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

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" inoremap simulate readline
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
inoremap <c-a> <home>
inoremap <c-e> <end>
inoremap <c-b> <left>
inoremap <c-f> <right>
inoremap <c-z> <Esc>zza
inoremap <c-_> <c-k>       " insert mode as emacs
inoremap <c-x><c-a> <c-a>  " insert mode as emacs
inoremap <c-x><c-b> <c-e>  " insert mode as emacs

" Insert mode navigation similar to <C-g>j and <C-g>k
inoremap <silent> <C-g>l     <right>
inoremap <silent> <C-g>h     <left>
inoremap <silent> <C-g><C-l> <right>
inoremap <silent> <C-g><C-h> <left>
inoremap <C-^> <C-o><C-^>       " movement in insert mode

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

source $VIMRUNTIME/defaults.vim     " vimrc defaults file
nnoremap ss :source $MYVIMRC<cr>    " Fast reloading of the .vimrc
nnoremap ee :tabe $MYVIMRC<cr>      " Fast editing of .vimrc

augroup enableAutoReloadVimrc
    autocmd!
    autocmd BufWritePost *vimrc source ${MYVIMRC} | set foldmethod=marker
    autocmd BufWritePost *gvimrc if has('gui_running') source source ${MYVIMRC}
augroup END

" augroup enableAutoSaveSession
"     autocmd!
"     autocmd VimLeave * AsyncTask auto-vimleave-mksession
"     autocmd VimEnter *  AsyncTask auto-vimenter-sosession
" augroup END



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
set t_Co=256    " 启用256色
" 颜色主题 是放在运行时各路径的 colors/ 子目录的 *.vim 文件
" colorscheme这是个单独的命令,不是 set 选项.选择一个颜色主题
" :colorscheme + 主题名 -> :colorscheme helloworld -> colors/helloworld.vim
" colorscheme desert " darkblue
" background 背景是深色 dark 或浅色 light, 有的 colorscheme 只适于深色或 浅色背景，有的则分别为不同背景色定义不同的颜色主题
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
"""" 设置行号 + 行号的列宽
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
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
"             | +-- <leader> Normal and Visual
"             +-- <BS> Normal and Visual
set virtualedit-=block,onemore      " 不允许光标出现在最后一个字符的后面
set wrapscan                        " Searches wrap around end-of-file.
set report      =0                  " Always report changed lines.
set synmaxcol   =200                " Only highlight the first 200 columns.
set shortmess-=S                    " display number of search matches & index of a current match

" 插入模式下在哪里允许 <BS> 删除光标前面的字符.逗号分隔的三个值分别指:行首的空白字符,换行符和插入模式开始处之前的字符。
set backspace=indent,eol,start      " allow backspacing over everything in insert mode
set confirm                         " Show confirm dialog
set hidden                          " Switch between buffers without having to save first

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""" 显示状态栏
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
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
"""" 空格和tab键
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nolist
set listchars=tab:>-,trail:-
if has('multi_byte') && &encoding ==# 'utf-8'
    let &listchars = 'tab:▸ ,extends:❯,precedes:❮,nbsp:±'
else
    let &listchars = 'tab:> ,extends:>,precedes:<,nbsp:.'
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""" 禁用错误报警声音和图标
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set noerrorbells
set novisualbell
set t_vb=

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""" 禁止生成临时文件
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nobackup
set noswapfile

" Put all temporary files under the same directory.
" https://github.com/mhinz/vim-galore#handling-backup-swap-undo-and-viminfo-files
" 如果文件夹不存在，则新建文件夹
if !isdirectory($HOME.'/.vim/files') && exists('*mkdir')
    call mkdir($HOME.'/.vim/files')
endif
" 备份文件
set backup                                  " make backup files
set backupdir   =$HOME/.vim/files/backup/   " where to put backup files
set backupext   =-vimbackup                 "
set backupskip  =$HOME/.vim/files/backup/   " Don’t create backups when editing files in certain directories
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
"""" 格式控制
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
"""" 拼写
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"拼写检查
set nospell

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""" 搜索
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 高亮搜索结果
set hlsearch        " Keep matches highlighted.

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

""""""""""""""""""""""""""""""""""""""""
"""" FZF config
""""""""""""""""""""""""""""""""""""""""
let $FZF_DEFAULT_COMMAND = 'ag --hidden --ignore .git -f -g ""'
" let $FZF_DEFAULT_COMMAND = 'fd --type f --color=always'
" let $FZF_DEFAULT_COMMAND = 'fd --type f --color=always' --exclude .git --ignore-file ~/.gitignore'

" CTRL-A CTRL-Q to select all and build quickfix list
function! s:build_quickfix_list(lines)
  call setqflist(map(copy(a:lines), '{ "filename": v:val }'))
  copen
  cc
endfunction

let g:fzf_action = {
  \ 'ctrl-q': function('s:build_quickfix_list'),
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }

let $FZF_DEFAULT_OPTS='--bind ctrl-a:select-all --bind ctrl-d:deselect-all'
let $FZF_DEFAULT_OPTS='--no-height --no-reverse -m --bind="ctrl-a:select-all" --bind="ctrl-d:deselect-all" --bind "ctrl-/:toggle-preview" --bind "ctrl-\\:change-header(Type jump label)+jump,jump-cancel:change-header:Jump cancelled" --highlight-line --color gutter:-1,selected-bg:238,selected-fg:146,current-fg:189 --marker ▏ --pointer ▌ --prompt ▌ --bind "start:show-header"'
let g:fzf_layout = { 'window': { 'width': 1.0, 'height': 1.0 } }

" let g:fzf_vim.preview_window = ['right,50%', 'ctrl-/']
" let g:fzf_layout = { 'down': '40%' }
" let g:fzf_layout = { 'window': { 'width': 0.8, 'height': 0.8 } }

inoremap <expr> <c-x><c-k> fzf#vim#complete#word({'window': { 'width': 0.2, 'height': 0.9, 'xoffset': 1 }})
inoremap <expr> <c-x><c-f> fzf#vim#complete("find -print0 <Bar> xargs --null realpath --relative-to " . expand("%:h"))
inoremap <expr> <c-x><c-l> fzf#vim#complete#line()

" inoremap <c-x><c-k> <plug>(fzf-complete-word)
" inoremap <c-x><c-f> <plug>(fzf-complete-path)
" inoremap <c-x><c-l> <plug>(fzf-complete-line)

" show mapping on all modes with <leader><tab>
nmap <leader><tab> <plug>(fzf-maps-n)
xmap <leader><tab> <plug>(fzf-maps-x)
omap <leader><tab> <plug>(fzf-maps-o)

let g:fzf_history_dir = '~/.local/share/fzf-history'

""""""""""""""""""""""""""""""""""""""""
"""" FZF map
""""""""""""""""""""""""""""""""""""""""
" fzf
" :Ag [PATTERN]  Ag! open fzf in fullscreen
" :Rg [PATTERN]  Rg! open fzf in fullscreen
" Ag / Rg / Lines / BLines / Tags / BTags ==> fill the quickfix list when multiple entries are selected
nnoremap <leader>fa :Ag! <C-R><C-W><CR>  | " :Ag [PATTERN] ag search result (ctrl-A to select all, ctrl-D to deselect all) word
nnoremap <leader>fA :Ag! <C-R><C-A><CR>  | " :Ag [PATTERN] ag search result (ctrl-A to select all, ctrl-D to deselect all) WORD
nnoremap <leader>fr :Rg! <C-R><C-W><CR>  | " :Rg [PATTERN] rg search result (ctrl-A to select all, ctrl-D to deselect all) word
nnoremap <leader>fR :Rg! <C-R><C-A><CR>  | " :Rg [PATTERN] rg search result (ctrl-A to select all, ctrl-D to deselect all) WORD
" or xnoremap <Leader>* "sy:Rg! <C-r>s
xnoremap <leader>fa y:Ag! <C-R>"<CR>
xnoremap <leader>fA y:Ag! <C-R>"<CR>
xnoremap <leader>fr y:Rg! <C-R>"<CR>
xnoremap <leader>fR y:Rg! <C-R>"<CR>


" :FZF [fzf_options string] [path string] 1.:FZF ~ 2.:FZF --reverse --info=inline /tmp 3.:FZF!
nnoremap <leader>ff :execute 'Files! ' expand('%:h')<CR>       | " Files (runs $FZF_DEFAULT_COMMAND if defined)
nnoremap <leader>fg :FZFFzm<CR>    | " fzf-marks
nnoremap <leader>fG :GFiles?!<CR>   | " Git files (git status)
nnoremap <leader>fb :Buffers!<CR>   | " Open buffers
nnoremap <leader>fB :execute 'GFiles! ' expand('%:h')<CR>    | " Git files (git ls-files)
nnoremap <leader>fl :BLines!<CR>    | " Lines in the current buffer
nnoremap <leader>fL :Lines!<CR>     | " Lines in loaded buffers
nnoremap <leader>ft :execute "Tags '" . expand('<cword>')<CR>     | " Tags in the current buffer    ; Tags and Helptags require Perl
nnoremap <leader>fT :execute "BTags '" . expand('<cword>')<CR>    | " Tags in the project (ctags -R); Tags and Helptags require Perl
let g:fzf_tags_command = 'ctags -R --c++-kinds=+p+l+x+c+d+e+f+g+m+n+s+t+u+vI --c-kinds=+px --fields=+niazS --extra=+r'
nnoremap <leader>fm :Marks<CR>      | " Marks
nnoremap <leader>fM :Maps<CR>       | " Normal mode mappings
nnoremap <leader>fj :Jumps<CR>      | " Jumps
nnoremap <leader>fw :Windows!<CR>   | " switch Windows
nnoremap <leader>fW :MaximizerToggle<CR>   | " max Windows
nnoremap <leader>fh :History!<CR>   | " Open buffers history
nnoremap <leader>H :execute ":help " . expand("<cword>")<cr>
nnoremap <leader>f: :History:<CR>   | " Command history
nnoremap <leader>f/ :History/<CR>   | " Search history
nnoremap <leader>f? :Helptags<CR>   | " Help tags
nnoremap <leader>fs :Snippets<CR>   | " Snippets (UltiSnips)
nnoremap <leader>fS :call fzf#sonictemplate#run()<CR>   | " sonictemplate
nnoremap <leader>fc :Commits!<CR>   | " Git commits (requires fugitive.vim)
nnoremap <leader>fc :Changes!<CR>   | " Git commits (requires fugitive.vim)
nnoremap <leader>fC :BCommits!<CR>  | " Git commits (requires fugitive.vim)
nnoremap <leader>f; :Commands<CR>   | " Commands

nnoremap <leader>f' :FZFBookmarks<CR>
nnoremap <leader>f` :FZFBookmarks<CR>

function! s:fzf_yank_files()
  let cwd = $HOME . "/.vim/registers/"
  let command = 'ag -g "" -f ' . cwd . ' --depth 0'

  call fzf#run({
        \ 'source': command,
        \ 'sink':   'e',
        \ 'options': '-m -x +s',
        \ 'window':  'enew' })
endfunction
command! FZFYankHistory call s:fzf_yank_files()
nnoremap <leader>fy :FZFYankHistory<CR>  | " FZFYankHistory

let g:fzf_history_dir = '~/.local/share/fuf-history'  " CTRL-N: next-history CTRL-P:previous-history  instead of 'down' and 'up'


let g:vimreg_window_size_view = 15
let g:vimreg_window_size_edit = 15

let g:fzf_files_command  = 'rg --color=never --hidden --files -g "!.git/"'
let g:fzf_afiles_command = 'rg --color=never --no-ignore --hidden --files'
nnoremap <leader>fF :AFiles<CR>       | " include .git
nnoremap <leader>fu :Mru<CR>          | " MRU files like History
nnoremap <leader>fU :MruCwd<CR>       | " MRU files like History in current dir
" nnoremap <leader>fu :MruInCwd<CR>   | " MRU files like History in current dir
nnoremap <leader>fo :BOutline<CR>     | " Outline like BTag
nnoremap <Leader>fO :Messages<CR>     | " :echomsg output
nnoremap <Leader>f" :Registers<CR>    | " like junegunn/vim-peekaboo
nnoremap <Leader>fq :Quickfix<CR>     | " getqflist
nnoremap <Leader>fQ :LocationList<CR> | " getloclist

nnoremap <Leader>f] :FzfFunky<Cr>
" narrow the list down with a word under cursor
nnoremap <Leader>f} :execute 'FzfFunky ' . expand('<cword>')<Cr>

" Tig revision
nnoremap <leader>fk :TigOpenCurrentFile<CR>
nnoremap <leader>fK :TigOpenProjectRootDir<CR>

" Floaterms
" nnoremap <Leader>fx :Floaterms<CR>
" nnoremap <Leader>fX :FloatermToggle<CR>

function! s:fzf_neighbouring_files()
  let current_file =expand("%")
  let cwd = fnamemodify(current_file, ':p:h')
  let command = 'ag -g "" -f ' . cwd . ' --depth 0'

  call fzf#run({
        \ 'source': command,
        \ 'sink':   'e',
        \ 'options': '-m -x +s',
        \ 'window':  'enew' })
endfunction

command! FZFNeigh call s:fzf_neighbouring_files()
nnoremap <leader>f. :FZFNeigh<CR>  | " FZFNeigh

augroup fzf_commands
  autocmd!
  autocmd FileType fzf tnoremap <silent> <buffer> <c-j> <down>
  autocmd FileType fzf tnoremap <silent> <buffer> <c-k> <up>
augroup end

nnoremap <leader>f] <Plug>(fzf_tags)
nnoremap <C-]> :Tgs<CR>


command! FzReadme call fzf#run(fzf#wrap(#{
          \ source: values(map(copy(g:plugs), {k,v-> k.' '.get(split(globpath(get(v,'dir',''), '\creadme.*'), '\n'), 0, '')})),
          \ options: ['--with-nth=1', '--preview', 'bat --color=always --plain {2}'],
          \ sink: funcref('s:PlugReadmeFzf')}))
function s:PlugReadmeFzf(name_and_path) abort
  execute 'PlugReadme' substitute(a:name_and_path, ' .*', '', '')
endfunction
nnoremap <Leader>fP :FzReadme<cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" pechorin/any-jump.vim
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:any_jump_window_width_ratio  = 1.0
let g:any_jump_window_height_ratio = 1.0
let g:any_jump_window_top_offset   = 10

let g:any_jump_max_search_results = 28
let g:any_jump_preview_lines_count = 10



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" .vim/autoload/plug.vim 自动载入脚本 PlugInstall/PlugUpdate/PlugClean/PlugUpgrade/
" :help packages
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

call plug#begin('~/.vim/plugged')
" Plug 'skywind3000/vim-dict'           " VIM 词表收集
Plug 'skywind3000/asyncrun.vim'         " hook (AsyncRunPre AsyncRunStart AsyncRunStop) cmd(AsyncRun AsyncStop AsyncReset)
Plug 'skywind3000/vim-terminal-help'    " (toggle)\wt; drop abc.txt(bash -> vim); :H {shell command}; command H to send:(vim -> bash)
Plug 'skywind3000/asynctasks.vim'       " :AsyncTaskMacro :AsyncTaskProfile  :AsyncTask task1 -name=Batman -gender=boy :AsyncTaskList!(以点.开头的任务名在查询时会被隐藏)  :AsyncTaskList
" :AsyncTask file-build ; noremap <silent><f5> :AsyncTask file-run<cr>   ; <leader>fe :AsyncTaskFzf
" :AsyncTask file-run   ; noremap <silent><f9> :AsyncTask file-build<cr> ; <leader>fe :AsyncTaskLast
" cmd(AsyncTask AsyncTaskEdit AsyncTaskList AsyncTaskMacro AsyncTaskProfile AsyncTaskLast AsyncTaskEnviron)
Plug 'skywind3000/vim-preview'         " 预览tags中的函数
Plug 'skywind3000/vim-text-process'    " Text Filter Manager for Vim/NeoVim !!

Plug 'voldikss/vim-floaterm'      " cmd(FloatermNew, FloatermPrev, FloatermNext, FloatermFirst, FloatermLast, FloatermUpdate, FloatermToggle FloatermKill FloatermShow FloatermHide FloatermSend)
Plug 'jgdavey/tslime.vim'         " <Plug>SendSelectionToTmux; <Plug>NormalModeSendToTmux; <Plug>SetTmuxVars(reset the session, window, and pane info)

Plug 'vim-scripts/vim-addon-mw-utils'  " 代码片段提示/函数库
Plug 'tomtom/tlib_vim'                 " 代码片段提示/函数库
Plug 'SirVer/ultisnips'                " 代码片段提示/替换引擎
Plug 'honza/vim-snippets'              " 代码片段提示/各种各样的snippets


" Plug 'Valloric/YouCompleteMe'          " 代码补全 sudo apt-get install build-essential cmake python-dev python3-dev; ./install.py --clang-completer
" YCM 的高性能 + coc.nvim 的富交互 + vim-lsp 的 API 设计 = EasyComplete 的极简和纯粹
" Plug 'nvie/vim-nox'
" Plug 'Shougo/neocomplete.vim'
Plug 'jayli/vim-easycomplete'            " 余杭区最好用的vim补全插件(vim 8.2及以上,nvim 0.4.4 及以上版本) :EasyCompleteGotoDefinition :EasyCompleteCheck :EasyCompleteInstallServer ${Plugin_Name} set dictionary=${Your_Dictionary_File}
" Plug 'williamboman/nvim-lsp-installer' " :InstallLspServer lua
" Plug 'ervandew/supertab'               "
" let g:SuperTabDefaultCompletionType = <c-n>
" let g:SuperTabContextDefaultCompletionType = <c-n>

Plug 'bronson/vim-trailing-whitespace' " 去除文档多余的空白符 ws
Plug 'vim-autoformat/vim-autoformat'   " 代码格式化

Plug 'easymotion/vim-easymotion'       " \\w (quick motion)
Plug 'junegunn/vim-easy-align'         " ga gaip=; gaip*=
Plug 'vim-scripts/VisIncr'             " :I [#]; :II [# [zfill]]; :IO [#]; :IIO [# [zfill]]; :IX [#]; :IIX [# [zfill]]; :IYMD [#]; :IMDY [#]; :IDMY [#]; :ID [#]

Plug 'tpope/vim-surround'              " cs]{  ds{ds)  ysiw<em>
Plug 'tpope/vim-commentary'            " 注释 gcc {count}gc gcap
Plug 'tpope/vim-unimpaired'            " ]b和[b循环遍历缓冲区; ]f和[f循环遍历同一目录中的文件,并打开为当前缓冲区; ]l和[l遍历位置列表; ]q和[q遍历快速修复列表; ]t和[t遍历标签列表; yos切换拼写检查,或yoc切换光标行高亮显示

Plug 'tpope/vim-rsi'                   " readline key
" Plug 'tpope/vim-endwise'              helps to end certain structures automatically.
Plug 'tpope/vim-scriptease'            " tool for script expert; :PP/:Runtime/:Disarm/:Scriptnames/:Messages/:Verbose/:Time
Plug 'tpope/vim-fugitive'              " Git

Plug 'vim-scripts/DoxygenToolkit.vim', {'for': ['c', 'cpp']}  " 注释DF DL DA DB
Plug 'gcmt/wildfire.vim'               " in Visual mode, type k' to select all text in '', or type k) k] k} kp

Plug 'rhysd/clever-f.vim'              " fFtT
Plug 'roxma/vim-paste-easy'            " auto paste && nopaste
Plug 'christoomey/vim-system-copy'     " cp for copying; cv for pasting; cP for line copying; cV for line pasting
" let g:system_copy#copy_command='xclip -sel clipboard'
" let g:system_copy#paste_command='xclip -sel clipboard -o'

" Plug 'rjungemann/registers-everywhere'    ay(buffer->register a) \ca(register a -> tempfile a.txt) \va(tempfile a.txt -> register a)  ap(register a -> buffer) \Ca \Va
Plug 'm6z/VimRegDeluxe'                   " vr(View) a 5; vre(Edit) a 5; vrc(Close) ab;  vrs(Resize) 5 :vrr(Refresh)
Plug 'vim-scripts/tmpclip.vim'            " TmpClipWrite TmpClipRead

Plug 'junegunn/vim-peekaboo'           " \" Ctrl+R 显示寄存器内容
" Plug 'Yilin-Yang/vim-markbar'           '`        显示mark的内容
Plug 'simnalamburt/vim-mundo'          " 可视化管理内容变更历史记录的插件 :MundoToggle -> Gundo
Plug 'kshenoy/vim-signature'           " mark 记录标注;  m[a-zA-Z]:打标签,打两次就撤除/ m,:自动设定下一个可用书签名; mda:删除当前文件中所有独立书签
Plug 'MattesGroeger/vim-bookmarks'     " bookmarks Ctrl-M
Plug 'tenfyzhong/fzf-bookmarks.vim'    " bookmarks <leader>fo

Plug 'chengzeyi/fzf-preview.vim'       "
Plug 'nmaiti/fzf_cscope.vim'           "
Plug 'brookhong/cscope.vim'            "
" 's'   symbol: find all references to the token under cursor.
" 'g'   global: find global definition(s) of the token under cursor
" 'c'   calls:  find all calls to the function name under cursor.
" 't'   text:   find all instances of the text under cursor.
" 'e'   egrep:  egrep search for the word under cursor.
" 'f'   file:   open the filename under cursor.
" 'i'   includes: find files that include the filename under cursor.
" 'd'   called: find functions that function under cursor calls.
" 'a'   Assigned: Assigned to this symbol.

Plug 'tracyone/fzf-funky'                "
Plug 'vim-scripts/autopreview'            "

Plug 'ludovicchabant/vim-gutentags'    " 管理tag文件 | ctags索引生成,方便变量,函数的跳转查询  ~/.cache/tags/mnt-d-cygwin64-home-wangfuli-openwrt-netifd-.tags
Plug 'vim-scripts/taglist.vim'         " 浏览tags,文件内跳转 Tlist   set tags=tags;
Plug 'preservim/tagbar'                " 浏览tags,文件内跳转 Tagbar  set tags=tags;

Plug 'vim-scripts/a.vim'               " 源文件/头文件之间跳转 :A :AS :AV :AN

Plug 'vim-scripts/netrw.vim'
" netrw Ex/Sex/Vex/Lex 左右分割方式,当前Netrw窗口位于最左边,且高度占满整个屏幕 :Ex sftp://<domain>/<directory> 列出目录内容, :e scp://<domain>/<directory>/<file> 编辑文件
Plug 'vim-scripts/winmanager'          " 文件系统管理 WMToggle/wm
Plug 'jlanzarotta/bufexplorer'         " opened buffer管理 \bs \bv \bt \be
Plug 'preservim/nerdtree'              " directory管理 NERDTreeToggle/tree; :Bookmark命令来收藏当前光标在NERDTree中选择的目录; B列出所以书签

Plug 'vim-scripts/ctrlp-funky'         " nnoremap <Leader>fu :execute 'CtrlPFunky ' . expand('<cword>')<Cr>
" <Leader>vv 搜索光标所在单词,并匹配出所有结果 <Leader>vV 搜索光标所在单词,全词匹配
" <Leader>va vv结果添加到之前的搜索列表        <Leader>vA vV把结果添加到之前的搜索列表
" <Leader>vr 全局搜索光标所在单词,并替换想要的单词
" :Grep [arg]                       # 类似 <Leader>vv, 使用 ! 类似<Leader>vV
" :GrepAdd [arg]                    # 类似 <Leader>va, 使用 ! 类似<Leader>vA
" :Replace [target] [replacement]   # 类似 <Leader>vr
" :ReplaceUndo                      # 撤销替换操作

Plug 'francoiscabrol/ranger.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }  " 模糊搜索
Plug 'junegunn/fzf.vim'
Plug 'junegunn/limelight.vim'
" Color name (:help cterm-colors) or ANSI code
let g:limelight_conceal_ctermfg = 'gray'
let g:limelight_conceal_ctermfg = 240
" Color name (:help gui-colors) or RGB color
let g:limelight_conceal_guifg = 'DarkGray'
let g:limelight_conceal_guifg = '#777777'

Plug 'junegunn/seoul256.vim'    " a low-contrast Vim color scheme based on Seoul Colors.
set background=dark             " let g:seoul256_background = 236
Plug 'junegunn/vim-slash'       " provides a set of mappings for enhancing in-buffer search experience in Vim.
Plug 'junegunn/gv.vim'          " A git commit browser. # :GV; :GV!; :GV?; :GBrowse; [[; ]]; o|<cr>/O
Plug 'junegunn/goyo.vim'        " :Goyo; :Goyo [dimension]; :Goyo! # Distraction-free writing in Vim.
Plug 'sunaku/vim-shortcut'      " Shortcut!; Shortcut; :Shortcuts

Plug 'phongnh/fzf-settings.vim' " Quickfix/Registers/Messages/BOutline
" z= spelling suggestions via fzf https://github.com/junegunn/fzf/issues/2284
Plug 'tknightz/projectile.vim'        " :AddProject; :ListProject; :RemoveProject
Plug 'relastle/vim-tgs'               " :TgsList :Tgs
Plug 'fszymanski/fzf-quickfix', {'on': 'Quickfix'}  " fq/fQ
Plug 'AndrewRadev/quickpeek.vim', {'on': 'Quickfix'}  ":Quickpeek; :QuickpeekStop; :QuickpeekToggle
Plug 'mattn/vim-sonictemplate'        " Template <TAB>
Plug 'voldikss/fzf-floaterm'          " :Floaterms
Plug 'tenfyzhong/fzf-marks.vim'       " fzf-marker
Plug 'pechorin/any-jump.vim'          " <leader>j :AnyJump; <leader>ab :AnyJumpBack; <leader>al :AnyJumpLastResult
Plug '4513ECHO/vim-readme-viewer'     " :PlugHelp or :FzReadme

Plug 'liuchengxu/vista.vim/'            " Vista!! Toggle vista view window
Plug 'lambdalisue/fern.vim'            " :Fern . ; :Fern {url} [-opener={opener}] [-reveal={reveal}] [-stay] [-wait]
Plug 'LumaKernel/fern-mapping-fzf.vim' " ff fzf-files;fd fzf-dirs;fa fzf-both;frf fzf-root-files;frd fzf-root-dirs;fra fzf-root-both; :help fern-mapping-fzf .

Plug 'azabiong/vim-highlighter'        " HiSet   = 'f<CR>'; HiErase = 'f<BS>'; HiFind  = 'f<Tab>'; HiClear = 'f<C-L>'; # Default key mappings: f Enter, f Backspace, f Ctrl+L, f Tab and t Enter
Plug 'jiangmiao/auto-pairs'            " 括号自动补全
Plug 'RRethy/vim-illuminate'
hi illuminatedWord cterm=underline gui=underline

Plug 'vim-airline/vim-airline'         " 状态栏
Plug 'vim-airline/vim-airline-themes'  " 状态栏主题

Plug 'metakirby5/codi.vim'             " 异步显示当前代码执行结果
Plug 'asins/vimcdoc'                   " vim中文文档  help
Plug 'vim-utils/vim-man'               " vim Man Vman帮助文档
Plug 'powerman/vim-plugin-viewdoc'     " K
Plug 'nanotee/nvim-lua-guide'          " lua reference manual, :help lua.table
Plug 'hotchpotch/perldoc-vim'          " apt-get install perl-doc; K hotkey
Plug 'bfrg/vim-cmake-help'             " :CMakeHelp {arg} / :CMakeHelpPopup {arg} / :CMakeHelpOnline [{arg}]

" Plug 'vim-syntastic/syntastic'         " ALE 异步语法检查引擎
Plug 'iberianpig/tig-explorer.vim'

Plug 'dracula/vim', { 'as': 'dracula' }  " Plug 'liuchengxu/space-vim-dark' + colorscheme space-vim-dark
Plug 'jacoborus/tender.vim'              " colorscheme
Plug 'morhetz/gruvbox'                   " colorscheme

Plug 'will133/vim-dirdiff'               " :DirDiff <dir1> <dir2>
Plug 'szw/vim-maximizer'                 " :MaximizerToggle
Plug 'lambdalisue/suda.vim'                                             " sudo
call plug#end()

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" colorscheme
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
colorscheme dracula
colorscheme gruvbox
colorscheme tender
let g:airline_theme = 'tender'


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 'SirVer/ultisnips' + 'honza/vim-snippets'
" <c-j>展开 <c-tab>列出snippets  <c-j>跳到下一个位置   <c-k>跳到上一个位置
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" - https://github.com/Valloric/YouCompleteMe
" - https://github.com/nvim-lua/completion-nvim
" let g:UltiSnipsExpandTrigger="<tab>"
" 使用 <c-b> 切换下一个触发点, <c-z>上一个触发点
" let g:UltiSnipsJumpForwardTrigger="<tab>"
" let g:UltiSnipsJumpBackwardTrigger="<s-tab>"

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
let g:easycomplete_tab_trigger="<tab>"    " 唤醒补全按键:默认 Tab 键
let g:easycomplete_scheme="sharp"             " 菜单样式可以使用插件自带的四种样式(dark, light, rider, sharp)
let g:easycomplete_diagnostics_next = "<C-n>"
let g:easycomplete_diagnostics_prev = "<C-p>"
let g:easycomplete_diagnostics_enable = 1

let g:easycomplete_lsp_checking = 0      " check LSP server 是否安装
let g:easycomplete_signature_enable = 0  " lsp signature checking
let g:easycomplete_tabnine_enable = 0         " disaable TabNine
let g:easycomplete_tabnine_config = {
            \ 'line_limit': 1000,
            \ 'max_num_result' : 3,
            \ }

let g:easycomplete_cursor_word_hl = 0         " Highlight the symbol when holding the cursor
let g:easycomplete_nerd_font = 0              " Using nerdfont is highly recommended

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" supertab
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:SuperTabRetainCompletionType = 2 " 0 不记录上次的补全方式 1 记住上次的补全方式,直到用其他的补全命令改变它 2 记住上次的补全方式,直到按ESC退出插入模式为止
let g:SuperTabDefaultCompletionType = "context"
let g:SuperTabContextDefaultCompletionType = "<c-x><c-x>"
let g:SuperTabCompleteCase = 'match'

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
" 'bronson/vim-trailing-whitespace'
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap tw :FixWhitespace<cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 'tpope/vim-unimpaired'
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

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
let g:DoxygenToolkit_commentType = "C"

nnoremap <Leader>df :Dox<CR>               | " 生成函数或者类声明
nnoremap <Leader>da :DoxAuthor<CR>         | " 生成作者信息
nnoremap <Leader>db :DoxBlock<CR>          | " 在后面的行中插入一个doxygen块
nnoremap <Leader>dl :DoxLic<CR>            | " 生成授权说明
nnoremap <Leader>du :DoxUndoc(DEBUG)!<CR>  | " 用于忽略代码块

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
" 'tpope/vim-commentary'
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"为python和shell等添加注释
autocmd FileType python,shell,coffee set commentstring=#\ %s
"修改注释风格
autocmd FileType java,c,cpp set commentstring=//\ %s

" 单行注释用 gcc，多行注释先进入可视模式再 gc，取消注释用 gcu
" gcc: 注释或反注释
" gcap: 注释一段
" gc: visual 模式下直接注释所有已选择的行
" gcc{motion}            Comment or uncomment lines that {motion} moves over.
" gcc                    Comment or uncomment [count] lines.
" {Visual}gc             Comment or uncomment the highlighted lines.
" gc                     Text object for a comment (operator pending mode only.)
" gcgc                   Uncomment the current and adjacent commented lines.
" :[range]Commentary     Comment or uncomment [range] lines

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ludovicchabant/vim-gutentags setting
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" gutentags搜索工程目录的标志，碰到这些文件/目录名就停止向上一级目录递归  # openwrt/build_dir/target-mipsel-openwrt-linux-gnu/'project'
let g:gutentags_enabled=0
let g:gutentags_ctags_auto_set_tags=1
let g:gutentags_project_root = ['mkall.sh', 'COPYING', 'base-files', 'base-files', 'cgi-bin', '.sgbuilt_user', '.config', '.root', '.svn', '.git', '.project', '.built', '.configured_yyynyynnnn', '.gitignore', 'README', 'm4', 'configure', 'configure.ac', '.version', '.pc']

function! g:Gutentags()
    let g:loaded_gutentags = 0
    source ~/.vim/plugged/vim-gutentags/plugin/gutentags.vim
    let g:gutentags_enabled=1
    :GutentagsUpdate
endfunc

" 所生成的数据文件的名称
let g:gutentags_ctags_tagfile = '.tags'

" 将自动生成的 tags 文件全部放入 ~/.cache/tags 目录中，避免污染工程目录
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

if filereadable("tags")
    set tags+=./tags
"  set tags+=/usr/include/tags
else
    set tags+=./tags,tags
"   set tags+=/usr/include/tags
endif

if filereadable(".tags")
    set tags+=./.tags
"  set tags+=/usr/include/tags
else
    set tags+=./.tags,.tags
"   set tags+=/usr/include/tags
endif

" 生成系统头文件
" ctags --fields=+niazS --extras=+q --c++-kinds=+px --c-kinds=+px --output-format=e-ctags -R -f ~/.vim/systags /usr/include

let g:gutentags_ctags_exclude = [
\]

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Taglist setting
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let Tlist_Show_One_File=1               " 不同时显示多个文件的tag，只显示当前文件的
let Tlist_Exit_OnlyWindow=1             " 如果taglist窗口是最后一个窗口，则退出vim
let Tlist_Ctags_Cmd="/usr/bin/ctags"    " 将taglist与ctags关联
let Tlist_File_Fold_Auto_Close = 0      " 不要关闭其他文件的tags
let Tlist_Use_Right_Window = 1          " 在右侧显示窗口
" autocmd FileType h,cpp,cc,c set tags+=/usr/include/tags

" Taglist -> Tagbar(更完善的类支持)
" exuberant-ctags -> universal-ctags (Home · Universal Ctags)

nnoremap tagbar :TagbarToggle<CR>           " 将开启tagbar的快捷键设置为　<Leader>tb
let g:tagbar_ctags_bin='/usr/bin/ctags'     " 设置ctags所在路径
let g:tagbar_sort = 0                       " 设置标签不排序,默认排序


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" winmanager setting
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:winManagerWindowLayout = "BufExplorer,FileExplorer|TagList"
let g:winManagerWidth = 30
let g:defaultExplorer = 0
nnoremap wm :WMToggle<cr>

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
" cscope setting
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! s:add_cscope_db()
  " add any database in current directory
  let db = findfile('cscope.out', '.;')
  if !empty(db)
    silent cs reset
    silent! execute 'cs add' db
  " else add database pointed to by environment
  elseif !empty($CSCOPE_DB)
    silent cs reset
    silent! execute 'cs add' $CSCOPE_DB
  endif
endfunction

if has("cscope")
  set csprg=/usr/bin/cscope
  set csto=0
  set cst
  set nocsverb
  set csverb
  call s:add_cscope_db()

  "   's'   symbol: find all references to the token under cursor
  "   'g'   global: find global definition(s) of the token under cursor
  "   'c'   calls:  find all calls to the function name under cursor
  "   't'   text:   find all instances of the text under cursor
  "   'e'   egrep:  egrep search for the word under cursor
  "   'f'   file:   open the filename under cursor
  "   'i'   includes: find files that include the filename under cursor
  "   'd'   called: find functions that function under cursor calls
  nnoremap <C-\>s :cs find s <C-R>=expand("<cword>")<CR><CR>
  nnoremap <C-\>g :cs find g <C-R>=expand("<cword>")<CR><CR>
  nnoremap <C-\>c :cs find c <C-R>=expand("<cword>")<CR><CR>
  nnoremap <C-\>t :cs find t <C-R>=expand("<cword>")<CR><CR>
  xnoremap <C-\>t y:cs find t <C-R>"<CR>
  " nnoremap <C-\>e :cs find e <C-R>=expand("<cword>")<CR><CR>
  nnoremap <C-\>f :cs find f <C-R>=expand("<cfile>")<CR><CR>
  " nnoremap <C-\>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
  nnoremap <C-\>d :cs find d <C-R>=expand("<cword>")<CR><CR>

  " extends
  nnoremap <C-\>e :cs find t extends <C-R>=expand("<cword>")<CR><CR>
  " implements
  nnoremap <C-\>i :cs find t implements <C-R>=expand("<cword>")<CR><CR>
  " new
  nnoremap <C-\>n :cs find t new <C-R>=expand("<cword>")<CR><CR>
endif


nnoremap <leader>fi :call CscopeFindInteractive(expand('<cword>'))<CR>
nnoremap <leader>fI :call ToggleLocationList()<CR>

" ----------------------------------------------------------------------------
" :CSBuild
" ----------------------------------------------------------------------------
function! s:build_cscope_db(...)
  let git_dir = system('git rev-parse --git-dir')
  let chdired = 0
  if !v:shell_error
    let chdired = 1
    execute 'cd' substitute(fnamemodify(git_dir, ':p:h'), ' ', '\\ ', 'g')
  endif

  let exts = empty(a:000) ?
    \ ['java', 'c', 'h', 'cc', 'hh', 'cpp', 'hpp'] : a:000

  let cmd = "find . " . join(map(exts, "\"-name '*.\" . v:val . \"'\""), ' -o ')
  let tmp = tempname()
  try
    echon 'Building cscope.files'
    call system(cmd.' | grep -v /test/ > '.tmp)
    echon ' - cscoped db'
    call system('cscope -b -q -i'.tmp)
    echon ' - complete!'
    call s:add_cscope_db()
  finally
    silent! call delete(tmp)
    if chdired
      cd -
    endif
  endtry
endfunction
command! CSBuild call s:build_cscope_db(<f-args>)

"cscope调用
" find . -name "*.h" -o -name "*.c" -o -name "*.cc" > cscope.files; cscope -bkq -i cscope.files
set cscopequickfix=s-,c-,d-,i-,t-,e-

nnoremap <C-\>s :cs find s <C-R>=expand("<cword>")<CR><CR>:botright cwindow<CR><CR>
nnoremap <C-\>g :cs find g <C-R>=expand("<cword>")<CR><CR>:botright cwindow<CR><CR>
nnoremap <C-\>c :cs find c <C-R>=expand("<cword>")<CR><CR>:botright cwindow<CR><CR>
nnoremap <C-\>t :cs find t <C-R>=expand("<cword>")<CR><CR>:botright cwindow<CR><CR>
nnoremap <C-\>e :cs find e <C-R>=expand("<cword>")<CR><CR>:botright cwindow<CR><CR>
nnoremap <C-\>f :cs find f <C-R>=expand("<cfile>")<CR><CR>:botright cwindow<CR><CR>
nnoremap <C-\>i :cs find i <C-R>=expand("<cfile>")<CR><CR>:botright cwindow<CR><CR>
nnoremap <C-\>d :cs find d <C-R>=expand("<cword>")<CR><CR>:botright cwindow<CR><CR>

augroup cscope
    autocmd!
    autocmd Filetype c    nnoremap <C-\>C :!find . -type f -name "*.[chly]" -o -name "*.inc" > cscope.files; cscope -Rbkq -i cscope.files<CR><CR>
    autocmd Filetype cpp  nnoremap <C-\>C :!find . -type f -name "*.[chly]" -o -name "*.cc" -o -name "*.cpp" > cscope.files; cscope -Rbkq -i cscope.files<CR><CR>
    autocmd Filetype java nnoremap <C-\>C :!find . -type f -name "*.java" > cscope.files; cscope -Rbkq -i cscope.files<CR><CR>
    autocmd Filetype sh   nnoremap <C-\>C :!find . -type f > cscope.files; cscope -Rbkq -i cscope.files<CR><CR>
    autocmd Filetype perl nnoremap <C-\>C :!find . -type f > cscope.files; cscope -Rbkq -i cscope.files<CR><CR>
    autocmd Filetype lua  nnoremap <C-\>C :!find . -type f > cscope.files; cscope -Rbkq -i cscope.files<CR><CR>
    autocmd Filetype vim  nnoremap <C-\>C :!find . -type f > cscope.files; cscope -Rbkq -i cscope.files<CR><CR>
augroup END

nnoremap <C-\>A :cs add cscope.out<CR><CR>

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

"""" vim-bookmarks
nnoremap <leader>mt :BookmarkToggle<CR>
nnoremap <leader>ma :BookmarkAnnotate<CR>
nnoremap <leader>mm :BookmarkAnnotate<CR>
nnoremap <leader>mn :BookmarkNext<CR>
nnoremap <leader>mp :BookmarkPrev<CR>
nnoremap <leader>mx :BookmarkClear<CR>
nnoremap <leader>mc :BookmarkClearAll<CR>
nnoremap <leader>mu :BookmarkMoveUp<CR>
nnoremap <leader>md :BookmarkMoveDown<CR>
nnoremap <leader>ml :BookmarkMoveToLine<CR>
nnoremap <leader>ms :BookmarkSave ./.bookmark<CR>
nnoremap <leader>mr :BookmarkLoad ./.bookmark<CR>

nnoremap <leader>f' :FZFBookmarks<CR>
nnoremap <leader>f` :FZFBookmarks<CR>
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
" nmap <Leader>m  <Plug>ToggleMarkbar
" nmap <Leader>mo <Plug>OpenMarkbar
" nmap <Leader>mc <Plug>CloseMarkbar

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
"NERDTree 配置:tree快捷键显示当前目录树
nnoremap tree :NERDTreeRefreshRoot<CR>:NERDTreeToggle<CR>

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
"进行实时检查，如果觉得卡顿，将下面的选项置为1
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
" tpope/vim-fugitive (git)
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
nnoremap <silent> <Leader>ga :Git add %<CR>
nnoremap <silent> <Leader>gA :Git add .<CR>
nnoremap <silent> <Leader>gb :Git blame<CR>
nnoremap <silent> <leader>gl :Gllog!<CR>
nnoremap <silent> <leader>gd :Gvdiffsplit!<CR>
nnoremap <silent> <leader>gb :Git blame<CR>
nnoremap <silent> <leader>gs :Gstatus<CR>
nnoremap <silent> <leader>gc :Git commit<CR>
nnoremap <silent> <leader>gr :Gread<CR>
nmap              <Leader>gg :Git<CR>gg<c-n>

nnoremap <silent> <leader>gt :TigOpenCurrentFile<CR>
nnoremap <silent> <leader>gT :TigOpenProjectRootDir<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" tpope/vim-surround (git)
" ," Surround a word with "quotes"
map  <leader>" ysiw"
vmap <leader>" c"<C-R>""<ESC>

" ,' Surround a word with 'single quotes'
map  <leader>' ysiw'
vmap <leader>' c'<C-R>"'<ESC>

" ,) or ,( Surround a word with (parens)
" The difference is in whether a space is put in
map  <leader>( ysiw(
map  <leader>) ysiw)
vmap <leader>( c( <C-R>" )<ESC>
vmap <leader>) c(<C-R>")<ESC>

" ,[ Surround a word with [brackets]
map  <leader>] ysiw]
map  <leader>[ ysiw[
vmap <leader>[ c[ <C-R>" ]<ESC>
vmap <leader>] c[<C-R>"]<ESC>

" ,{ Surround a word with {braces}
map <leader>} ysiw}
map <leader>{ ysiw{
vmap <leader>} c{ <C-R>" }<ESC>
vmap <leader>{ c{<C-R>"}<ESC>

map <leader>` ysiw`


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" iberianpig/tig-explorer.vim (git-tig)
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

command! GF call tig_explorer#open_current_file()
command! GP call tig_explorer#open_project_root_dir()

" open tig with current file
nnoremap <Leader>gf :TigOpenCurrentFile<CR>

" open tig with Project root path
nnoremap <Leader>gt :TigOpenProjectRootDir<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" iPlug 'junegunn/gv.vim'                   " :GV; :GV!; :GV?; :GBrowse; [[; ]]; o|<cr>/O
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap <Leader>gv :GV<CR>
nnoremap <Leader>gV :GV!<CR>
nnoremap <Leader>g? :GV?<CR>

" o or <cr> on a commit to display the content of it
" o or <cr> on commits to display the diff in the range
" O opens a new tab instead
" gb for :GBrowse
" q or gq to close

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" skywind3000/asyncrun.vim
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:asyncrun_mode = 0     | " 全局的默认运行模式
let g:asyncrun_wrapper = '' | " 命令前缀，默认为空，比如可以设置成 nice
let g:asyncrun_open = 10    | " 大于零的话会在运行时自动打开高度为具体值的 quickfix 窗口
let g:asyncrun_bell = 1     | " 任务结束时候响铃提醒
let g:asyncrun_encs = ''    | " 如果系统编码和 Vim 内部编码 &encoding，不一致，那么在这里设置一下
let g:asyncrun_trim='1'     | " non-zero to trim the empty lines in the quickfix window.
let g:asyncrun_auto=''      | " 用于触发 QuickFixCmdPre/QuickFixCmdPost 的 autocmd 名称
let g:asyncrun_save=2       | " 全局设置，运行前是否保存文件，1是保存当前文件，2是保存所有修改过的文件
let g:asyncrun_timer=50     | " 每 100ms 处理多少条消息，默认为 25

command! -bang -nargs=+ -range=0 -complete=file HH call asyncrun#run('<bang>', '', <q-args>, <count>, <line1>, <line2>)
command! -bar  -bang -nargs=0                   HS call asyncrun#stop('<bang>')
command! -nargs=0                               HR call asyncrun#reset()


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" skywind3000/vim-text-process
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" text-processor search path, a comma separated string
let g:textproc_root = '~/.vim/text'

" preview window split method: auto/vert/horizon
let g:textproc_split = "vert"

" filter runner
let g:textproc_runner = {
    \ 'py': '/usr/bin/python3',
    \ 'sh': '/bin/bash',
    \ 'pl': '/usr/bin/perl',
    \ 'awk': '/usr/bin/gawk -f',
    \ }

" g:textproc_home    - sub-directory name, default to "text"
" g:textproc_root    - a list of script search path.
" b:textproc_root    - local list of script search path.
" g:textproc_split   - preview split mode: "auto", "vert" or ""
" g:textproc_runner  - a dictionary of filter runners

" $VIM_ENCODING      # value of &encoding in vim.
" $VIM_FILEPATH      # file name of current buffer with full path
" $VIM_FILENAME      # file name of current buffer without path
" $VIM_FILEDIR       # full path of current buffer without the file name
" $VIM_SCRIPT        # file name of the filter program
" $VIM_SCRIPTDIR     # directory of filter program
" $VIM_FILETYPE      # file type of current buffer
" $VIM_LINE1         # start line of the given {range}
" $VIM_LINE2         # last line of the given {range}

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" junegunn/vim-easy-align
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:easy_align_ignore_groups = ['Comment', 'String']
let g:ignore_unmatched  = 1

xmap <Leader>ga <Plug>(EasyAlign)   " Start interactive EasyAlign in visual mode           (e.g. vipga)
nmap <Leader>ga <Plug>(EasyAlign)   " Start interactive EasyAlign for a motion/text object (e.g. gaip)
" Align = signs
vmap <Leader>g=  :EasyAlign =<cr>gv
vmap <Leader>g== :EasyAlign *=<cr>gv
" Align hashrockets
vmap <Leader>g> :EasyAlign =><cr>gv

" Align words and fix indentation
vmap <Leader>g<Space>         :EasyAlign \ <cr>gv
vmap <Leader>g<Space><Space>  :EasyAlign *\ <cr>gv
" Align comments
vmap <Leader>g#  :EasyAlign /\#/ <cr>gv
vmap <Leader>g## :EasyAlign /\#/ <cr>gv

" Align comments
vmap <Leader>g/  :EasyAlign /\// <cr>gv
vmap <Leader>g// :EasyAlign /\// <cr>gv
" Align continue
vmap <Leader>g\  :EasyAlign /\\/ <cr>gv
vmap <Leader>g\\ :EasyAlign */\\/ <cr>gv

" Align blocks
vmap <Leader>g{ :EasyAlign {<cr>gv

" Align commas
vmap <Leader>g,  :EasyAlign ,<cr>gv
vmap <Leader>g,, :EasyAlign *,<cr>gv
" Align :
vmap <Leader>g:  :EasyAlign :<cr>gv
vmap <Leader>g:: :EasyAlign *:<cr>gv
" Align ;
vmap <Leader>g; :EasyAlign ;<cr>gv
vmap <Leader>g;; :EasyAlign *;<cr>gv

vnoremap gb <Plug>(EasyAlign)       " Visual 模式下快捷键
vnoremap <Enter> <Plug>(EasyAlign)  " Visual 模式下快捷键

" =       Around the 1st occurrences
" 2=      Around the 2nd occurrences
" *=      Around all occurrences
" **=     Left/Right alternating alignment around all occurrences
" <Enter> Switching between left/right/center alignment modes

" <leader>                Around the 1st occurrences of whitespaces
" 2<leader>               Around the 2nd occurrences
" -<leader>               Around the last occurrences
" <Enter><Enter>2<leader> Center-alignment around the 2nd occurrences
" <leader>     Around 1st whitespaces              :'<,'>EasyAlign\
" 2<leader>    Around 2nd whitespaces              :'<,'>EasyAlign2\
" -<leader>    Around the last whitespaces         :'<,'>EasyAlign-\ 
" -2<leader>   Around the 2nd to last whitespaces  :'<,'>EasyAlign-2\
" :           Around 1st colon (key:  value)      :'<,'>EasyAlign:
" <Right>:    Around 1st colon (key : value)      :'<,'>EasyAlign:>l1
" =           Around 1st operators with =         :'<,'>EasyAlign=
" 3=          Around 3rd operators with =         :'<,'>EasyAlign3=
" *=          Around all operators with =         :'<,'>EasyAlign*=
" **=         Left-right alternating around =     :'<,'>EasyAlign**=
" <Enter>=    Right alignment around 1st =        :'<,'>EasyAlign!=
" <Enter>**=  Right-left alternating around =     :'<,'>EasyAlign!**=

" Using predefined alignment rules
"   :EasyAlign[!] [N-th] DELIMITER_KEY [OPTIONS]
" :EasyAlign :
" :EasyAlign =
" :EasyAlign *=
" :EasyAlign 3\

" Using arbitrary regular expressions
"   :EasyAlign[!] [N-th] /REGEXP/ [OPTIONS]
" :EasyAlign /[:;]\+/
" :EasyAlign 2/[:;]\+/
" :EasyAlign */[:;]\+/
" :EasyAlign **/[:;]\+/

" Left-alignment around the FIRST occurrences of delimiters
":EasyAlign =

" Left-alignment around the SECOND occurrences of delimiters
":EasyAlign 2=

" Left-alignment around the LAST occurrences of delimiters
":EasyAlign -=

" Left-alignment around ALL occurrences of delimiters
":EasyAlign *=

" Left-right ALTERNATING alignment around all occurrences of delimiters
":EasyAlign **=

" Right-left ALTERNATING alignment around all occurrences of delimiters
":EasyAlign! **=

":EasyAlign
"Left, Right, Center
":EasyAlign!
"Right, Left, Center

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" azabiong/vim-highlighter
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let HiSet   = 'f<CR>'
let HiErase = 'f<BS>'
let HiClear = '<leader>f<BS>'
let HiFind  = 'f<Tab>'
nnoremap f<leader>         :Hi><CR>
nnoremap <leader>f<leader> :Hi<<CR>

" :Hi/Find  [options]  expression  [directories_or_files]
" :Hi/Find  red|blue
" :Hi/Find  "pattern with spaces"
" :Hi/Find  \b[AS]\w+
" :Hi/Find  -F  'item[i+1].size() * 2'

" :Hi   pattern  # set highlighting by entering a pattern
" :Hi ==         # synchronizing the current window's highlights with other split windows
" :Hi =          # switch back to single window highlighting mode
" :Hi < and Hi >  # move the cursor back and forth to recently highlighted words
" :Hi < and Hi >  # move the cursor to the nearest highlight, even if the pattern or type differs from the current selection

" let HiFindTool = 'grep -H -EnrI --exclude-dir=.git'
" let HiFindTool = 'ag --nocolor --noheading --column --nobreak'
" let HiFindTool = 'rg -H --color=never --no-heading --column --smart-case'
" let HiFindTool = 'ack -H --nocolor --noheading --column --smart-case'
" let HiFindTool = 'sift --no-color --line-number --column --binary-skip --git --smart-case'
" let HiFindTool = 'ggrep -H -EnrI --exclude-dir=.git'
" let HiFindTool = 'git grep -EnI --no-color --column'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" skywind3000/vim-terminal-help : drop filename.txt(vim)  H (bash)
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:terminal_key ="<leader>wt"        "哪个键将用于切换终端窗口，默认为<m-=>。
" let g:terminal_cwd ="<leader>"        "初始化工作目录：0保持不变，1文件路径和2项目根目录。
" let g:terminal_height ="<leader>"     "新的终端高度，默认为10。
" let g:terminal_pos  ="<leader>"       "打开终端的位置，默认为rightbelow。
" let g:terminal_shell ="<leader>"      "指定外壳而不是默认外壳。
" let g:terminal_edit ="<leader>"       "命令在vim中打开文件，默认为tab drop。
" let g:terminal_kill ="<leader>"       "设置term退出vim时终止学期会话。
" let g:terminal_list  ="<leader>"      "设置为0以将终端缓冲区隐藏在缓冲区列表中。
" let g:terminal_fixheight ="<leader>"  "设置为1以设置winfixheight终端窗口。
" let g:terminal_close ="<leader>"      "设置为1以在处理完成后关闭窗口。

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" voldikss/vim-floaterm : floaterm filename.txt
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:floaterm_position='topright'
let g:floaterm_width = 1.0
let g:floaterm_height = 1.0
let g:floaterm_wintype='normal'
command! -nargs=* -complete=customlist,floaterm#cmdline#complete -bang -range          FF  call floaterm#run('new', <bang>0, [visualmode(), <range>, <line1>, <line2>], <q-args>)
command! -nargs=? -count=0 -bang -complete=customlist,floaterm#cmdline#complete_names1 FK  call floaterm#kill(<bang>0, <count>, <q-args>)
command! -nargs=? -count=0 -bang -complete=customlist,floaterm#cmdline#complete_names1 FT  call floaterm#toggle(<bang>0, <count>, <q-args>)
command! -nargs=? -range   -bang -complete=customlist,floaterm#cmdline#complete_names2 FS  call floaterm#send(<bang>0, visualmode(), <range>, <line1>, <line2>, <q-args>)
command! -nargs=0                                                                      FP  call floaterm#prev()
command! -nargs=0                                                                      FN  call floaterm#next()
command! -nargs=0                                                                      FF  call floaterm#first()
command! -nargs=0                                                                      FL  call floaterm#last()

function! Floaterm_new(name)
  let l:term_name = a:name
  if len(l:term_name) == 0
    execute ':FloatermNew'
  else
    execute ':FloatermNew --title=' . l:term_name
  endif
endfunction

" let g:floaterm_keymap_new    = '<leader>wc'  " new
let g:floaterm_keymap_prev   = '<leader>wp'    " prev
let g:floaterm_keymap_next   = '<leader>wn'    " next
let g:floaterm_keymap_kill   = '<leader>wk'    " kill
let g:floaterm_keymap_toggle = '<leader>ww'    " toggle
nnoremap <leader>wc  :call Floaterm_new(input('term name: '))<CR>
" :FloatermSend                        " Send current line to the current floaterm (execute the line in the terminal)
" :FloatermSend --name=ft1             " Send current line to the floaterm named ft1
" :FloatermSend ls -la                 " Send `ls -la` to the current floaterm
" :FloatermSend --name=ft1 ls -la      " Send `ls -la` to the floaterm named ft1
" :23FloatermSend ...                  " Send the line 23 to floaterm
" :1,23FloatermSend ...                " Send lines between line 1 and line 23 to floaterm
" :'<,'>FloatermSend ...               " Send lines selected to floaterm(visual block selection are supported)
" :%FloatermSend ...                   " Send the whole buffer to floaterm

let g:floaterm_keymap_next   = '<F9>'

nnoremap  <leader>ws :execute "terminal" <CR>
nnoremap  <leader>wv :execute "vert terminal" <CR>
vnoremap <leader>wf :'<,'>FloatermSend <CR>
nnoremap <leader>wf :'<,'>FloatermSend <CR>

" :FloatermNew python (python driectly) vs :FloatermNew! python (bash; then python driectly)

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" voldikss/fzf-floaterm (switch floaterm + switch create)
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:fzf_floaterm_newentries = {
    \ '+fzf' : {
    \    'title': 'fzf',
    \    'height': 0.9,
    \    'width': 0.9,
    \    'cmd' : 'fzf'
    \ },
    \ '+tig' : {
    \    'title': 'tig',
    \    'height': 0.9,
    \    'width': 0.9,
    \    'cmd' : 'tig'
    \ },
    \ '+reply' : {
    \ '  title': 'perl',
    \ '  height': 0.9,
    \ '  width': 0.9,
    \ '  cmd' : 'reply'
    \ },
    \ '+python2' : {
    \   'title': 'python2',
    \   'height': 0.99,
    \   'width': 0.99,
    \   'cmd' : 'python2'
    \ },
    \ '+python3' : {
    \   'title': 'python3',
    \   'height': 0.99,
    \   'width': 0.99,
    \   'cmd' : 'python3'
    \ },
    \ '+node' : {
    \   'title': 'node',
    \   'height': 0.99,
    \   'width': 0.99,
    \   'cmd' : 'node'
    \ },
    \ '+root' : {
    \ 'title': 'shell',
    \ 'cmd' : 'bash' },
    \}

let g:floaterm_shell   = 'bash'
let g:floaterm_wintype = 'float'
let g:floaterm_opener  = 'edit'
let g:floaterm_height  = 1.0
let g:floaterm_width   = 1.0

" Floaterms
nnoremap <Leader>wx :Floaterms<CR>
nnoremap <Leader>wX :FloatermToggle<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" fzf#wrap vimrc nocompatible @ github
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! FzfGetQuickFixList(cmdstr)
    let l:quickhistory = trim(execute(a:cmdstr))
    let l:newQuickfixHistoryList = []
    if l:quickhistory == "No entries"
        return l:newQuickfixHistoryList
    endif
    let l:quickHistoryList = split(l:quickhistory, "\n")
    if len(l:quickHistoryList) == 0 || l:quickhistory == "No entries"
        echomsg "no quick fix list"
        return l:newQuickfixHistoryList
    endif

    let l:quickHistoryList = reverse(l:quickHistoryList)

    for item in l:quickHistoryList
        let itemInfo = split(item, ";")
        let numsList = split(itemInfo[0], " ")
        let nums = 0
        for subItem in numsList
            if subItem == "of"
                break
            endif
            let nums = subItem
        endfor
        if nums != ""
            call add(l:newQuickfixHistoryList, nums . ':' . itemInfo[1])
        endif
    endfor

    return l:newQuickfixHistoryList
endfunction

function! s:FzfQuickfixOpen(line)
    if a:line == ""
        return
    endif
    let lineInfo = split(a:line, ":")
    let nums = lineInfo[0]
    exec nums . "chi"
    copen
endfunction

function! s:FzfQuickfixLocalOpen(line)
    if a:line == ""
        return
    endif
    let lineInfo = split(a:line, ":")
    let nums = lineInfo[0]
    exec nums . "lhi"
    lopen
endfunction

command! -bang FzfQuiclfixHistory
    \ call fzf#run(fzf#wrap('fzfquickfix', {'source': FzfGetQuickFixList('chi'), 'sink': function('s:FzfQuickfixOpen')}, 0))

command! -bang FzfQuiclfixLocalHistory
    \ call fzf#run(fzf#wrap('fzfquickfix', {'source': FzfGetQuickFixList('lhi'), 'sink': function('s:FzfQuickfixLocalOpen')}, 0))

nnoremap <leader>fn :FzfQuiclfixHistory<cr>
nnoremap <leader>fN :FzfQuiclfixLocalHistory<cr>

function! s:plug_help_sink(line)
  let dir = g:plugs[a:line].dir
  for pat in ['doc/*.txt', 'README.md']
    let match = get(split(globpath(dir, pat), "\n"), 0, '')
    if len(match)
      execute 'tabedit' match
      return
    endif
  endfor
  tabnew
  execute 'Explore' dir
endfunction

command! PlugHelp call fzf#run(fzf#wrap({
  \ 'source': sort(keys(g:plugs)),
  \ 'sink':   function('s:plug_help_sink')}))

nnoremap <leader>fp :PlugHelp<cr>

noremap <leader>f^ :call SwitchToHeaderOrSource()<CR>
function! SwitchToHeaderOrSource()
    let extn="cpp"
    if (expand("%:e")=="cpp")
        let extn="hpp"
    elseif(expand("%:e")=="hpp")
        let extn="cpp"
    elseif(expand("%:e")=="h")
        let extn="c"
    else
        let extn="h"
    endif
    :call fzf#vim#files('.', {'options':['--query', expand("%:t:r").' '.expand(extn)]})<CR>
endfunction


let g:quickfix_is_open = 0
function! QuickfixToggle()
    if g:quickfix_is_open
        cclose
        let g:quickfix_is_open = 0
    else
        copen
        let g:quickfix_is_open = 1
    endif
endfunction

function s:GoTo(jumpline)
  let values = split(a:jumpline, ":")
  execute "e ".values[0]
  call cursor(str2nr(values[1]), str2nr(values[2]))
  execute "normal zvzz"
endfunction

function s:GetLine(bufnr, lnum)
  let lines = getbufline(a:bufnr, a:lnum)
  if len(lines)>0
    return trim(lines[0])
  else
    return ''
  endif
endfunction


" getjumplist()
function! FZF_changes_jumps_Jumps()
  " Get jumps with filename added
  let jumps = map(reverse(copy(getjumplist()[0])),
    \ { key, val -> extend(val, {'name': getbufinfo(val.bufnr)[0].name }) })

  let jumptext = map(copy(jumps), { index, val ->
      \ (val.name).':'.(val.lnum).':'.(val.col+1).': '.s:GetLine(val.bufnr, val.lnum) })

  call fzf#run(fzf#vim#with_preview(fzf#wrap({
        \ 'source': jumptext,
        \ 'column': 1,
        \ 'options': ['--delimiter', ':', '--bind', 'alt-a:select-all,alt-d:deselect-all', '--preview-window', '+{2}-/2'],
        \ 'sink': function('s:GoTo')})))
endfunction


" getchangelist()
function! FZF_changes_jumps_Changes()
  let changes  = reverse(copy(getchangelist()[0]))

  let changetext = map(copy(changes), { index, val ->
      \ expand('%').':'.(val.lnum).':'.(val.col+1).': '.s:GetLine(bufnr('%'), val.lnum) })

  call fzf#run(fzf#vim#with_preview(fzf#wrap({
        \ 'source': changetext,
        \ 'column': 1,
        \ 'options': ['--delimiter', ':', '--bind', 'alt-a:select-all,alt-d:deselect-all', '--preview-window', '+{2}-/2'],
        \ 'sink': function('s:GoTo')})))
endfunction

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" skywind3000/asynctasks
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! s:fzf_sink(what)
    let p1 = stridx(a:what, '<')
    if p1 >= 0
        let name = strpart(a:what, 0, p1)
        let name = substitute(name, '^\s*\(.\{-}\)\s*$', '\1', '')
        if name != ''
            exec "AsyncTask ". fnameescape(name)
        endif
    endif
endfunction

function! s:fzf_task()
    let rows = asynctasks#source(&columns * 48 / 100)
    let source = []
    for row in rows
        let name = row[0]
        let source += [name . '  ' . row[1] . '  : ' . row[2]]
    endfor
    let opts = { 'source': source, 'sink': function('s:fzf_sink'),
                \ 'options': '+m --nth 1 --inline-info --tac' }
    if exists('g:fzf_layout')
        for key in keys(g:fzf_layout)
            let opts[key] = deepcopy(g:fzf_layout[key])
        endfor
    endif
    call fzf#run(opts)
endfunction

let g:asynctasks_config_name = ['.tasks', '.git/tasks.ini', '~/.vim/task_template.ini', '.asynctask', '.svn/tasks.ini'] " 修改默认 .tasks 配置文件的名称
let g:asynctasks_rtp_config = "task_template.ini" " 修改 ~/.vim 下面的全局配置文件 tasks.ini 的名称
let g:asynctasks_extra_config = [ $HOME .. "/.vim/asynctasks.ini", '~/.config/nvim/utils/tasks.ini' ] " 额外全局配置,除了 ~/.vim/task_template.ini 外,你还可以指定更多全局配置

command! -nargs=0 AsyncTaskFzf call s:fzf_task()
noremap <leader>fe :AsyncTaskFzf<cr>
noremap <leader>fE :AsyncTaskLast<cr>
noremap <leader>f1 :FZFFiles! ~/.vim/snippet<cr>
noremap <leader>f2 :FZFFiles! ~/.vim/registers<cr>
noremap <leader>f3 :AsyncTask FZF-neigh<cr>
noremap <leader>f4 :AsyncTask FZF-root-files<cr>
noremap <leader>f5 :AsyncTask file-build<cr>
noremap <leader>f6 :AsyncTask file-run<cr>
noremap <leader>f7 :TP! run<cr>
noremap <leader>f8 :TP! runa
noremap <leader>f9 :TP! snippet
noremap <leader>fd :Actions<cr>
noremap <leader>fz :Shortcuts<cr>
vmap <leader>f7 :TP! run<cr>
vmap <leader>f8 :TP! runa
vmap <leader>f9 :TP! snippet
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" userdefined
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
command! FZFCd call fzf#run({
\   'options'    : '-x',
\   'sink'       : 'lcd',
\   'source'     : 'find * -path "*/.*" -type d -prune -o -type d',
\   'tmux_height': '40%',
\ })

noremap <leader>f> :FZFCd<cr>
command! -nargs=1 Spaces let b:wv = winsaveview() | execute "setlocal tabstop=" . <args> . " expandtab"   | silent execute "%!expand -t "  . <args> . ""  | call winrestview(b:wv) | setlocal ts? sw? sts? et?
command! -nargs=1 Tabs   let b:wv = winsaveview() | execute "setlocal tabstop=" . <args> . " noexpandtab" | silent execute "%!unexpand -t " . <args> . "" | call winrestview(b:wv) | setlocal ts? sw? sts? et?

" Change directory to the path of the current file; and back again
map <leader>cd :lcd %:p:h<cr><bar>:pwd<cr>
map <leader>cc :lcd -<cr><bar>:pwd<cr>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:tslime_always_current_session = 1
let g:tslime_always_current_window = 1

vmap <leader>f0 <Plug>SendSelectionToTmux
nmap <leader>f0 <Plug>NormalModeSendToTmux

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim-shortcut
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
runtime plugin/shortcut.vim

" at least execute map if vim-shortcut is not available
if !exists(':Shortcut')
  command! -bang -nargs=+ Shortcut call s:null_shortcut(<q-args>, <bang>0)

  function! s:null_shortcut_parse(input) abort
    let parts = split(a:input, '\s*\ze\<[nvxsoilct]\?\%(nore\)\?map\>')
    if len(parts) < 2
      throw 'expected "<description> <map-command>" but got ' . string(a:input)
    endif
    let [description; rest] = parts
    let definition = join(rest, '')
    return [description, definition]
  endfunction

  function! s:null_shortcut(qargs, bang) abort
    if !a:bang
      let [description, definition] = s:null_shortcut_parse(a:qargs)
      execute definition
    endif
  endfunction
endif

Shortcut show shortcut menu and run chosen shortcut
    \ nnoremap  <leader>fx  :Shortcuts<CR>


"-----------------------------------------------------------------------------
"-----------------------------------------------------------------------------
Shortcut! <F2>          (FF)   number
Shortcut! <F3>          (FF)   list
Shortcut! <F4>          (FF)   relativenumber
Shortcut! <F5>          (FF)   ccompile
Shortcut! <F6>          (FF)   format
Shortcut! <F7>          (FF)   SyntasticToggleMode(lint)
Shortcut! <F8>          (FF)   MaximizerToggle
Shortcut! <F9>          (FF)   FloatermNext
Shortcut! <F10>         (FF)   FloatermToggle
Shortcut! <F11>         (FF)   single file tags
Shortcut! <F12>         (FF)   project cscope build

Shortcut! <leader><F1>  (FF)   quickfix_toggle
Shortcut! <leader><F2>  (FF)   TagbarToggle
Shortcut! <leader><F3>  (FF)   NERDTreeRefreshRoot
Shortcut! <leader><F4>  (FF)   VimRegEdit
Shortcut! <leader><F5>  (FF)   crun
Shortcut! <leader><F6>  (FF)   all buffer file format
Shortcut! <leader><F7>  (FF)   all buffer file SyntasticToggleMode(lint)
Shortcut! <leader><F8>  (FF)   Windows
Shortcut! <leader><F9>  (FF)   FloatermPrev
Shortcut! <leader><F10> (FF)   TerminalToggle
Shortcut! <leader><F11> (FF)   Gutentags
Shortcut! <leader><F12> (FF)   project cscope build

Shortcut! <leader>f0    (FF)   SendSelectionToTmux
Shortcut! <leader>f1    (FF)   AsyncTaskLast
Shortcut! <leader>f2    (FF)   AsyncTaskEdit
Shortcut! <leader>f3    (FF)   FZF-neigh
Shortcut! <leader>f4    (FF)   FZF-root-files
Shortcut! <leader>f5    (FF)   AsyncTask file-build
Shortcut! <leader>f6    (FF)   AsyncTask file-run
Shortcut! <leader>f7    (FF)   AsyncTaskFzf
Shortcut! <leader>f8    (FF)   Shortcuts
Shortcut! <leader>f9    (FF)   Actions

"-----------------------------------------------------------------------------
"                                *fzf.vim*
"-----------------------------------------------------------------------------
" :Ag! <C-R><C-W><CR>  [PATH] preview
Shortcut! <leader>fa   (fzf.vim)   :Ag [PATTERN]  (ctrl-A to select all, ctrl-D to deselect all) word + with preview
" :Ag! <C-R><C-A><CR>  [PATH] preview
Shortcut! <leader>fA   (fzf.vim)   :Ag [PATTERN]  (ctrl-A to select all, ctrl-D to deselect all) WORD + with preview

" :Buffers<CR>         [PATH] preview
Shortcut! <leader>fb   (fzf.vim)   Open buffers                    open buffer
" :GFiles<CR>          [OPTS] preview
Shortcut! <leader>fB   (fzf.vim)   Git files (git ls-files)        open git file (tracked by git)

" :Commits?<CR>                 preview
Shortcut! <leader>fc   (fzf.vim)  " Git commits  (requires fugitive.vim)
" :BCommits?<CR>                preview
Shortcut! <leader>fC   (fzf.vim)  " Git BCommits (requires fugitive.vim)

"""" d/D """"
Shortcut! <leader>fe  (asynctasks.vim) " AsyncTaskFzf
Shortcut! <leader>fE  (asynctasks.vim) " AsyncTaskLast

"""" F """"
" :FZF<CR>             [PATH]
Shortcut! <leader>ff   (fzf.vim)   Files Look for files under current directory


" :FZFFzm<CR>
Shortcut! <leader>fg   (fzf-marks.vim)   jump to specify directory by fzf-marks ==> urbainvaes/fzf-marks + tenfyzhong/fzf-marks.vim
" :GFiles?<CR>                preview
Shortcut! <leader>fG   (fzf.vim)   Git files (git status)          open git file that has changes

"""" H """"
" :History<CR>                preview
Shortcut! <leader>fh   (fzf.vim)   Open buffers history            reopen file from history

" :CscopeFindInteractive(expand('<cword>'))
Shortcut! <leader>fi   (cscope.vim)   search by cscope
" ToggleLocationList
Shortcut! <leader>fI   (cscope.vim)   search by cscope

"""" J """"
" :Jumps<CR>
Shortcut! <leader>fj   (fzf.vim)   Jumps                           Jumps

Shortcut! <leader>fk   (tig-explorer.vim)   TigOpenCurrentFile
Shortcut! <leader>fK   (tig-explorer.vim)   TigOpenProjectRootDir

" :BLines<CR>         [QUERY]
Shortcut! <leader>fl   (fzf.vim)   Lines in the current buffer     expose line in buffer
" :Lines<CR>          [QUERY]
Shortcut! <leader>fL   (fzf.vim)   Lines in loaded buffers         expose line in any buffer

" :Marks<CR>
Shortcut! <leader>fm   (fzf.vim)   Marks                           expose mark in buffer
" :Maps<CR>
Shortcut! <leader>fM   (fzf.vim)   Normal mode mappings            trigger mapping / keybinding / shortcut

Shortcut!  <leader>fn   (fzf#run)  FzfQuiclfixHistory<cr>
Shortcut!  <leader>fN   (fzf#run)  FzfQuiclfixLocalHistory<cr>

" :BTags<CR>          [QUERY] preview
Shortcut! <leader>ft   (fzf.vim)   Tags in the current buffer    ; expose tag in buffer
" :Tags<CR>           [QUERY] preview
Shortcut! <leader>fT   (fzf.vim)   Tags in the project (ctags -R); expose tag in any buffer

Shortcut! <leader>fo (fzf.vim)    BOutline<CR>     | " Outline like BTag

" :Windows<CR>
Shortcut! <leader>fw   (fzf.vim)   Windows                         expose window in any tab

Shortcut! <leader>fp  (vim-readme-viewer) PlugHelp<cr>
Shortcut! <leader>fP  (vim-readme-viewer) FzReadme<cr>

Shortcut!  <Leader>fq (fzf-quickfix) Quickfix<CR>         | " getqflist
Shortcut!  <Leader>fQ (fzf-quickfix) LocationList<CR>     | " getloclist

" :Rg! <C-R><C-W><CR>  [PATH]
Shortcut! <leader>fr   (fzf.vim)   :Rg [PATTERN]  (ctrl-A to select all, ctrl-D to deselect all) word + without preview
" :Rg! <C-R><C-A><CR>  [PATH]
Shortcut! <leader>fR   (fzf.vim)   :Rg [PATTERN]  (ctrl-A to select all, ctrl-D to deselect all) WORD + without preview

" :Snippets<CR>
Shortcut! <leader>fs   (fzf.vim)   Snippets (UltiSnips)            snippets
" :call fzf#sonictemplate#run()<CR>
Shortcut! <leader>fS   (fzf.vim)   template (sonictemplate) ==> mattn/vim-sonictemplate

Shortcut! <leader>ft  (fzf.vim)     :BTags<CR>     | " Tags in the current buffer    ; Tags and Helptags require Perl
Shortcut! <leader>fT  (fzf.vim)     :Tags<CR>      | " Tags in the project (ctags -R); Tags and Helptags require Perl

Shortcut! <leader>fu :Mru<CR>          | " MRU files like History
Shortcut! <leader>fU :MruCwd<CR>       | " MRU files like History in current dir

" :Commands<CR>
Shortcut! <leader>f;   (fzf.vim)   Commands                            run command from menu

Shortcut! <leader>fw   (fzf.vim)  :Windows<CR>   | " Windows

" rjungemann/registers-everywhere ay(register a) \ca(a.txt) \va(register a) ap(buffer)
Shortcut! <leader>fy    (fzf.vim) :FZFYankHistory<CR>


" MattesGroeger/vim-bookmarks + tenfyzhong/fzf-bookmarks.vim
Shortcut! <leader>f'   (fzf.vim)  :FZFBookmarks<CR>
" MattesGroeger/vim-bookmarks + tenfyzhong/fzf-bookmarks.vim
Shortcut! <leader>f`   (fzf.vim)  :FZFBookmarks<CR>

" :History:<CR>
Shortcut! <leader>f:   (fzf.vim)   Command history                 repeat command from history
" :History/<CR>
Shortcut! <leader>f/   (fzf.vim)   Search history                  repeat search from history
" :Helptags<CR>
Shortcut! <leader>f?   (fzf.vim)   Help tags                       open help topic
" :FZFNeigh<CR>
Shortcut! <leader>f.   (fzf.vim)   open file under buffer's directory

Shortcut! ]c       (vimdiff) Next difference
Shortcut! [c       (vimdiff) Previous difference
Shortcut! do       (vimdiff) Diff Obtain! Pull the changes to the current file.
Shortcut! dp       (vimdiff) Diff Put!    Push the changes to the other file.

Shortcut (fzf) apply colorscheme
      \ nnoremap <silent> <leader>f+ :Colors<CR>
Shortcut (fzf) apply filetype
      \ nnoremap <silent> <leader>f- :Filetypes<CR>

"-----------------------------------------------------------------------------
" pabsan-0/vim-actions
"-----------------------------------------------------------------------------
" Quick access list default
" - Left side of separator is (Action) Name
" - Right side of separator is Target
let g:actions_list = [
    \ ["                                                                      "],
    \ ["source local rc                                      | :source ~/.vimrc "],
    \ ["edit local rc                                        | :edit ~/.vimrc   "],
    \ ["                                                                      "],
    \ ["hexdump do                                           | :%!xxd"],
    \ ["hexdump re                                           | :%!xxd -r "],
    \ ["                                                                           "],
    \ ["json format                                          | :%!jq ."],
    \ ["                                                                      "],
    \ ["file-build                                           | :AsyncTask file-build"],
    \ ["file-run                                             | :AsyncTask file-run"],
    \ ["                                                                      "],
    \ ["sudo-write                                           | :w !sudo tee % > /dev/null"],
    \ ["                                                                      "],
    \ ["open commit browser                                  | :GV"],
    \ ["list current commit file                             | :GV!"],
    \ ["current file location list                           | :GV?"],
    \ ["                                                           "],
    \ ["toggle enhancement for distraction-free writing mode | :Limelight!!"],
    \ ["toggle distraction-free writing mode                 | :Goyo!!"],
    \ ["                                                              "],
    \ ["split window above                                   | :aboveleft split"],
    \ ["split window below                                   | :belowright split"],
    \ ["split window left                                    | :aboveleft vsplit"],
    \ ["split window right                                   | :belowright vsplit"],
    \ ["close window                                         | :close"],
    \ ["close other windows                                  | :only"],
    \ ["                                                             "],
    \ ["reload buffer from file                              | :confirm edit"],
    \ ["reload buffer from file forcefully                   | :edit!"],
    \ ["write buffer to file                                 | :write"],
    \ ["write buffer to file forcefully                      | :write!"],
    \ ["close all buffers                                    | :1,999bdelete"],
    \ ]


" Entrypoint. Loads action list and feeds into FZF
command! Actions call fzf#run(fzf#wrap({
    \ 'source': map(copy(g:actions_list), 'v:val[0]'),
    \ 'sink*': function('ActionsFZFHandle')
    \ }))


" Sink function for FZF. Actions after selection is made
function! ActionsFZFHandle(selected)

    " Check that separator is present between action name and target
    if a:selected[0]!~'|'
        return
    endif

    " Discard action name through separator, keep target only
    let l:target = split(a:selected[0], "|")[-1]

    " Remove trailing/leading whitespace and expand for chars like ~
    let l:target = substitute(l:target, '\s*$', '', '')
    let l:target = substitute(l:target, '^\s*', '', '')
    let l:target = expand(l:target)

    " Handle target by type: may be a command, file or directory
    if l:target =~ ':'
        echom "Executing command: " . l:target
        execute l:target
    elseif isdirectory(l:target)
        tabnew
        execute 'cd ' . fnameescape(l:target)
        execute 'Explore'
    elseif filereadable(l:target)
        tabnew
        execute 'edit ' . fnameescape(l:target)
    else
        let l:create = confirm("File " . l:target . " does not exist. Create it?", "&Yes\n&No", 1)
        if l:create == 1
            tabnew
            execute 'edit ' . fnameescape(l:target)
        endif
    endif
endfunction

Shortcut show shortcut menu and run chosen shortcut
    \ nnoremap  <leader>fX  :Actions<CR>


let g:ranger_replace_netrw = 1
let g:ranger_map_keys = 0
map <C-p> :Ranger<CR>
