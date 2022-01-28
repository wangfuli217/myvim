
" https://vimjc.com/vim-commands-and-vim-mapping-conf.html 常用Vim命令及实用Vim按键映射配置

" nnoremap         <F5> :update<CR>:source %<CR>
" nnoremap <leader><F5> :update<CR>:source %<CR>
" augroup makeprg
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
autocmd FileType cpp        set makeprg=g++\ -g\ -Wall\ -Wno-sign-compare\ %

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" recently used or append
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap <Tab> %
vnoremap <Tab> %
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" F1-F12 显示方式 和 <Leader>F1-F12 插件窗口  快捷键 F5编译/执行 <Leader>F5执行
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""" F1-F12 快捷键
" 代码显示
nnoremap <F2> :set nu! nu?<CR>
nnoremap <F3> :set list! list?<CR>
nnoremap <F4> :set wrap! wrap?<CR>

" :set makeprg=gcc\ -Wall\ -omain\ main.c
" :make -> :compiler! helloworld -> compiler/helloworld.vim
augroup ccompile
    autocmd Filetype c      nnoremap   <F5> <Esc>:w<CR>:!gcc % -std=gnu99 -g -o %< -pthread -lrt -lm <CR>
    autocmd Filetype cpp    nnoremap   <F5> <Esc>:w<CR>:!g++ % -std=c++11 -g -o %< -pthread -lrt -lm <CR>
    autocmd Filetype python nnoremap   <F5> <Esc>:w<CR>:!ipython  % <CR>
    autocmd Filetype java   nnoremap   <F5> <Esc>:w<CR>:!javac % <CR>
    autocmd Filetype sh     nnoremap   <F5> <Esc>:w<CR>:!bash  % <CR>
    autocmd Filetype perl   nnoremap   <F5> <Esc>:w<CR>:!perl  % <CR>
    autocmd Filetype lua    nnoremap   <F5> <Esc>:w<CR>:!lua   % <CR>
    autocmd Filetype vim    nnoremap   <F5> <Esc>:w<CR>:source % <CR>
augroup END

augroup crun
    autocmd Filetype c    nnoremap <leader><F5> <Esc>:!gcc % -std=gnu99 -g -o %< -pthread -lrt -lm <CR>:! ./%< <CR>
    autocmd Filetype cpp  nnoremap <leader><F5> <Esc>:!g++ % -std=c++11 -g -o %< -pthread -lrt -lm <CR>:! ./%< <CR>
    autocmd Filetype java nnoremap <leader><F5> <ESC>:!javac % <CR>:java %< <CR>
    autocmd Filetype sh   nnoremap <leader><F5> <Esc>:w<CR>:!bash  % <CR>
    autocmd Filetype perl nnoremap <leader><F5> <Esc>:w<CR>:!perl  % <CR>
    autocmd Filetype lua  nnoremap <leader><F5> <Esc>:w<CR>:!lua   % <CR>
    autocmd Filetype vim  nnoremap <leader><F5> <Esc>:w<CR>:source % <CR>
augroup END


" 代码格式化
nnoremap <F6> :FixWhitespace<CR>:Autoformat<CR>:w!<CR>:!dos2unix %<CR>
" 静态代码扫描
nnoremap <F7> :SyntasticToggleMode<CR>

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

"""" 跳转再优化
" 把下一个查找匹配项所在的行显示在屏幕的最中间
nnoremap <silent> n nzz
nnoremap <silent> N Nzz
nnoremap <silent> * *zz
nnoremap <silent> # #zz
nnoremap <silent> g* g*zz
" 代码跳转后居中
nnoremap <c-]> <c-]>zz
nnoremap <c-o> <c-o>zz
nnoremap <c-i> <c-i>zz
" 执行删除操作时插入断点 Ctrl-G u (类似commit的操作)
inoremap <silent> <c-u> <c-g>u<c-u>
inoremap <silent> <c-w> <c-g>u<c-w>
inoremap <silent> , ,<c-g>u
inoremap <silent> . .<c-g>u
inoremap <silent> / /<c-g>u
inoremap <silent> \ \<c-g>u
inoremap <silent> ; ;<c-g>u
inoremap <silent> : :<c-g>u
inoremap <silent> ' '<c-g>u
inoremap <silent> " "<c-g>u
inoremap <silent> [ [<c-g>u
inoremap <silent> ] ]<c-g>u
inoremap <silent> { {<c-g>u
inoremap <silent> } }<c-g>u
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
nnoremap <leader>q :q<CR>       " \q = :q
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
nnoremap <leader>v "+p          | " Linux粘贴板
nnoremap <leader>c "+y          | " Linux粘贴板
vnoremap <leader>c "+y          | " Linux粘贴板
" Yank from the cursor to the end of the line, to be consistent with C and D.
nnoremap Y y$
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim tab buffer simulate tmux windows manager; windows simulate pane
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""" tab
nnoremap <silent> <C-t>c :tabnew<cr>
nnoremap <silent> <C-t>x :tabclose<cr>
nnoremap <silent> <C-t>t :tabs<cr>
nnoremap <silent> <C-t>0 :tabfirst<cr>
nnoremap <silent> <C-t><C-c> :tabnew<cr>
nnoremap <silent> <C-t><C-x> :tabclose<cr>
nnoremap <silent> <C-t><C-t> :tabs<cr>
nnoremap <silent> <C-t><C-0> :tabfirst<cr>

nnoremap <silent> <C-t>n gt
nnoremap <silent> <C-t>p gT
nnoremap <silent> <C-t><C-n> gt
nnoremap <silent> <C-t><C-p> gT
nnoremap <silent> <C-t>f :tabfirst<cr>
nnoremap <silent> <C-t>l :tablast<cr>
nnoremap <silent> <C-t><C-f> :tabfirst<cr>
nnoremap <silent> <C-t><C-l> :tablast<cr>

nnoremap <silent> <C-t>1 1gt
nnoremap <silent> <C-t>2 2gt
nnoremap <silent> <C-t>3 3gt
nnoremap <silent> <C-t>4 4gt
nnoremap <silent> <C-t>5 5gt
nnoremap <silent> <C-t>6 6gt
nnoremap <silent> <C-t>7 7gt
nnoremap <silent> <C-t>8 8gt
nnoremap <silent> <C-t>9 9gt

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

"""" buffer(args) b conflict with tmux, use screen hotkey a
nnoremap <silent> <C-a>a :ls<CR>
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

nnoremap <silent> <C-a>1 :b1<cr>
nnoremap <silent> <C-a>2 :b2<cr>
nnoremap <silent> <C-a>3 :b3<cr>
nnoremap <silent> <C-a>4 :b4<cr>
nnoremap <silent> <C-a>5 :b5<cr>
nnoremap <silent> <C-a>6 :b6<cr>
nnoremap <silent> <C-a>7 :b7<cr>
nnoremap <silent> <C-a>8 :b8<cr>
nnoremap <silent> <C-a>9 :b9<cr>

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

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" misc session buffertotab termianl and AutoTag
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""" session
nnoremap <C-a>s :wall<CR>:mksession!     ./.session.vim<CR>
nnoremap <C-a>r :source                  ./.session.vim<CR>
nnoremap <C-a><C-s> :wall<CR>:mksession! ./.session.vim<CR>
nnoremap <C-a><C-r> :source              ./.session.vim<CR>

"""" 把buffer中的文件全转成tab # :bufdo tab split 或者 :tab sball
nnoremap <C-a>t :bufdo tab split<CR>
nnoremap <C-a><c-t> :bufdo tab split<CR>

"""" Terminal
nnoremap <C-a>T :terminal<CR>

"""" Tag
nnoremap <C-a>P :!touch ./.project<CR>
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
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" cnoremap and inoremap simulate readline
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" cnoremap
" Ctrl + p 和 Ctrl + n 来跳转到上一个/下一个条目
cnoremap <c-n> <down>
cnoremap <c-p> <up>
cnoremap <C-a> <Home>
cnoremap <C-e> <End>
cnoremap <C-b> <Left>
cnoremap <C-f> <Right>
cnoremap <C-d> <C-f>
" %% for current buffer file name
" :: for current buffer file path
cnoremap %% <c-r>=expand('%')<cr>
cnoremap :: <c-r>=expand('%:p:h')<cr>/

cnoremap w!! w !sudo tee >/dev/null %

" inoremap
inoremap <C-a> <home>
inoremap <C-e> <end>
inoremap <C-b> <left>
inoremap <C-f> <right>
inoremap <C-z> <Esc>zza

" Insert mode navigation similar to <C-g>j and <C-g>k
inoremap <silent> <C-g>l <right>
inoremap <silent> <C-g>h <left>
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
" 启用256色
set t_Co=256
" 颜色主题 是放在运行时各路径的 colors/ 子目录的 *.vim 文件
" colorscheme这是个单独的命令,不是 set 选项.选择一个颜色主题
" :colorscheme + 主题名 -> :colorscheme helloworld -> colors/helloworld.vim
colorscheme desert " darkblue
" background 背景是深色 dark 或浅色 light, 有的 colorscheme 只适于深色或 浅色背景，有的则分别为不同背景色定义不同的颜色主题
" set background=dark

set ttyfast                " Faster redrawing.
set lazyredraw             " Only redraw when necessary.

set splitbelow             " Open new windows below the current window.
set splitright             " Open new windows right of the current window.
set clipboard+=unnamed     " 与windows共享剪切板
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

" 插入模式下在哪里允许 <BS> 删除光标前面的字符.逗号分隔的三个值分别指:行首的空白字符,换行符和插入模式开始处之前的字符。
set backspace=indent,eol,start      " allow backspacing over everything in insert mode
set confirm                         " Show confirm dialog
set hidden                          " Switch between buffers without having to save first
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 显示状态栏
set laststatus=1
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
set wildignore=*.dll,*.exe,*.gif,*.jpg,*.mm ",*.png,*.snag,*.ssd,*.xmind
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
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" https://zhuanlan.zhihu.com/p/58816186 插件说明 vim-rainbow 插件
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
Plug 'tpope/vim-commentary'            " 注释 gcc {count}gc gcap

Plug 'junegunn/vim-peekaboo'           " \" Ctrl+R 显示寄存器内容
Plug 'Yilin-Yang/vim-markbar'          " '`        显示mark的内容
Plug 'kshenoy/vim-signature'           " mark 记录标注;  m[a-zA-Z]:打标签,打两次就撤除/ m,:自动设定下一个可用书签名; mda:删除当前文件中所有独立书签
Plug 'MattesGroeger/vim-bookmarks'     " bookmarks Ctrl-M

Plug 'ludovicchabant/vim-gutentags'    " 管理tag文件 | ctags索引生成,方便变量,函数的跳转查询  ~/.cache/tags/mnt-d-cygwin64-home-wangfuli-openwrt-netifd-.tags
Plug 'vim-scripts/taglist.vim'         " 浏览tags,文件内跳转 Tlist   set tags=tags;
Plug 'preservim/tagbar'                " 浏览tags,文件内跳转 Tagbar  set tags=tags;
Plug 'vim-scripts/a.vim'               " 源文件/头文件之间跳转 :A :AS :AV :AN

                                       " netrw Ex/Sex/Vex
Plug 'vim-scripts/winmanager'          " 文件系统管理 WMToggle/wm
Plug 'jlanzarotta/bufexplorer'         " opened buffer管理 \bs \bv \bt \be
Plug 'preservim/nerdtree'              " directory管理 NERDTreeToggle/tree
" Plug 'bagrat/vim-buffet'               " buffer管理
Plug 'kien/ctrlp.vim'                  " find模糊搜索 <Ctrl>+p :CtrlP 或 :CtrlP {path} 或 :CtrlPBuffer 或 :CtrlPMRU 或 :CtrlPMixed
" <Leader>vv 搜索光标所在单词,并匹配出所有结果 <Leader>vV 搜索光标所在单词,全词匹配 
" <Leader>va vv结果添加到之前的搜索列表        <Leader>vA vV把结果添加到之前的搜索列表
" <Leader>vr 全局搜索光标所在单词,并替换想要的单词
" :Grep [arg]                       # 类似 <Leader>vv, 使用 ! 类似<Leader>vV
" :GrepAdd [arg]                    # 类似 <Leader>va, 使用 ! 类似<Leader>vA
" :Replace [target] [replacement]   # 类似 <Leader>vr
" :ReplaceUndo                      # 撤销替换操作
Plug 'dkprice/vim-easygrep'            " grep模糊查找
" Plug 'junegunn/fzf.vim'                " 模糊搜索
Plug 'jiangmiao/auto-pairs'            " 括号自动补全

Plug 'vim-airline/vim-airline'         " 状态栏
Plug 'vim-airline/vim-airline-themes'  " 状态栏主题

Plug 'yianwillis/vimcdoc'              " vim中文文档  help
Plug 'vim-utils/vim-man'               " vim Man Vman帮助文档
Plug 'vim-scripts/CRefVim'             " c reference manual; \cr
Plug 'nanotee/nvim-lua-guide'          " lua reference manual, :help lua.table
Plug 'hotchpotch/perldoc-vim'          " perldoc; K hotkey
Plug 'bfrg/vim-cmake-help'             " :CMakeHelp {arg} / :CMakeHelpPopup {arg} / :CMakeHelpOnline [{arg}]
" markdown + firefox
" Plug 'iamcco/mathjax-support-for-mkdp' " 实时通过浏览器预览 markdown 文件
" Plug 'iamcco/markdown-preview.vim'     " 实时通过浏览器预览 markdown 文件 MarkdownPreview MarkdownPreviewStop

" Plug 'Yggdroot/LeaderF', { 'do': ':LeaderfInstallCExtension' }
" Plug 'skywind3000/vim-quickui'

Plug 'vim-syntastic/syntastic'
" Plug 'yegappan/mru'                    " Most Recently opened/edited files
" Plug 'yegappan/bufselect'              " access to jump to a buffer from the Vim buffer list
" Plug 'yegappan/borland'                " Classic borland IDE like Vim color scheme

" Plug 'mbbill/undotree'                 " 可视化管理内容变更历史记录的插件
Plug 'simnalamburt/vim-mundo'            " 可视化管理内容变更历史记录的插件 :MundoToggle
" Plug 'Konfekt/FastFold'                " 让 Vim 按需更新折叠内容,而不是一直调用

Plug 'vim-scripts/a.vim'               " swtich between source files and header files
" Plug 'octol/vim-cpp-enhanced-highlight' " c++ syntax highlighting
" Plug 'xavierd/clang_complete'          " uses clang for accurately completing C and C++ code

" Plug 'xolox/vim-lua-ftplugin'          " Lua file type
" Plug 'xolox/vim-lua-inspect'           " uses the [LuaInspect] lua-inspect tool to (automatically) perform semantic highlighting of variables in Lua source code
call plug#end()

" neocompletecache -> neocomplete -> deoplete/neocompletion-manager(下一代通用补全)
" CtrlP / CommandT -> Unite.vim + vimproc -> denite.vim

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 'SirVer/ultisnips' + 'honza/vim-snippets'
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" - https://github.com/Valloric/YouCompleteMe
" - https://github.com/nvim-lua/completion-nvim
let g:UltiSnipsExpandTrigger="<tab>"
" 使用 <c-b> 切换下一个触发点, <c-z>上一个触发点
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

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
let g:easycomplete_diagnostics_enable = 0
let g:easycomplete_signature_enable = 1

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 'mattn/vim-gist'
" https://www.5axxw.com/wiki/content/8sjzz7
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:gist_clip_command = 'xclip -selection clipboard' | " Linux
" let g:gist_clip_command = 'putclip'                    | " cygwin
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
" nnoremap <Leader>ss :call StripWhitespace()<cr>

" Strip annoying windows newline characters ^M
function! StripWinLineBreaks()
    let save_cursor = getpos(".")
    let old_query = getreg('/')
    :%s///g
    call setpos('.', save_cursor)
    call setreg('/', old_query)
endfunction
" nnoremap <Leader>sn :call StripWinLineBreaks()<cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 'tpope/vim-commentary'
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"为python和shell等添加注释
autocmd FileType python,shell,coffee set commentstring=#\ %s
"修改注释风格
autocmd FileType java,c,cpp set commentstring=//\ %s

" gcc: 注释或反注释
" gcap: 注释一段
" gc: visual 模式下直接注释所有已选择的行
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ludovicchabant/vim-gutentags setting
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" gutentags搜索工程目录的标志，碰到这些文件/目录名就停止向上一级目录递归
let g:gutentags_project_root = ['.root', '.svn', '.git', '.project']

" 所生成的数据文件的名称
let g:gutentags_ctags_tagfile = '.tags'

" 将自动生成的 tags 文件全部放入 ~/.cache/tags 目录中，避免污染工程目录
let s:vim_tags = expand('~/.cache/tags')
let g:gutentags_cache_dir = s:vim_tags
" 检测 ~/.cache/tags 不存在就新建
if !isdirectory(s:vim_tags)
   silent! call mkdir(s:vim_tags, 'p')
endif

" 配置 ctags 的参数
" ctags -R --c++-kinds=+p+l+x+c+d+e+f+g+m+n+s+t+u+vI --fields=+niazS --extra=+q
let g:gutentags_ctags_extra_args = ['--fields=+niazS', '--extra=+q']
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
let Tlist_Show_One_File=1               " 不同时显示多个文件的tag，只显示当前文件的
let Tlist_Exit_OnlyWindow=1             " 如果taglist窗口是最后一个窗口，则退出vim
let Tlist_Ctags_Cmd="/usr/bin/ctags"    " 将taglist与ctags关联
let Tlist_File_Fold_Auto_Close = 0      " 不要关闭其他文件的tags
let Tlist_Use_Right_Window = 1          " 在右侧显示窗口
autocmd FileType h,cpp,cc,c set tags+=/usr/include/tags

" Taglist -> Tagbar(更完善的类支持)
" exuberant-ctags -> universal-ctags (Home · Universal Ctags)

nnoremap Tagbar :TagbarToggle<CR>           " 将开启tagbar的快捷键设置为　<Leader>tb
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
" find . -type f > cscope.files; cscope -Rbkq -i cscope.files
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
nmap <Leader>m  <Plug>ToggleMarkbar
nmap <Leader>mo <Plug>OpenMarkbar
nmap <Leader>mc <Plug>CloseMarkbar

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
let g:airline_powerline_fonts = 1  " 支持 powerline 字体
let g:airline#extensions#tabline#enabled = 1 " 显示窗口tab和buffer
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
nnoremap <leader>sman <Plug>(Man)    "  - open man page for word under cursor in a horizontal split
nnoremap <leader>vman <Plug>(Vman)   "  - open man page for word under cursor in a vertical split
nnoremap <leader>sk   <Plug>(Man)    "  - open man page for word under cursor in a horizontal split
nnoremap <leader>vk   <Plug>(Vman)   "  - open man page for word under cursor in a vertical splits
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
" autocmd vimenter * NERDTree                      " 自动开启Nerdtree
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
" }}}
""修改树的显示图标
let g:NERDTreeDirArrowExpandable = '►'
let g:NERDTreeDirArrowCollapsible = '▼'
let NERDTreeAutoCenter=1

" 是否默认显示书签列表
let NERDTreeShowBookmarks = 1
" 是否默认显示隐藏文件
let NERDTreeShowHidden = 1

" 不知道是什么含义，再开发机上，含有+的字符打不开，文件名不可能含有+
" 因此设置为+，不设置的话，第一个字符都是虚的。
let g:NERDTreeNodeDelimiter = '+'

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" kien/ctrlp.vim
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
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
" ^ 表示前缀精确匹配。要搜索一个以"welcome"开头的短语：^welcom。
" $ 表示后缀精确匹配。要搜索一个以"my friends"结尾的短语：friends$。
" ' 表示精确匹配。要搜索短语"welcom my friends"：'welcom my friends。
" | 表示"或者"匹配。要搜索"friends"或"foes"：friends | foes。
" ! 表示反向匹配。要搜索一个包含"welcome"但不包含"friends"的短语：welcome !friends
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
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

let g:syntastic_cpp_include_dirs = ['/usr/include/']
let g:syntastic_cpp_compiler_options = "-Wall -Wextra -Werror -std=c++11 -stdlib=libstdc++"
let g:syntastic_cpp_check_header = 1
let g:syntastic_cpp_remove_include_errors = 1
let g:syntastic_cpp_compiler = 'clang++'
let g:syntastic_cpp_auto_refresh_includes = 1
let g:Syntastic_cpp_checkers = ['gcc']

let g:syntastic_c_include_dirs = ['/usr/include/', '/usr/include/']
let g:syntastic_c_compiler_options = "-Wall -Wextra -Werror -std=gnu99 -pthread -lrt -lm"
let g:syntastic_c_check_header = 1
let g:syntastic_c_remove_include_errors = 1
let g:syntastic_c_compiler = 'clang'
let g:syntastic_c_auto_refresh_includes = 1
let g:Syntastic_c_checkers = ['gcc']

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
" :Errors         打开错误位置列表
" :lclose         关闭位置列表; :lnext  到下一个错误; :lprevious 到上一个错误
" :SyntasticReset 可以清除掉错误列表
" :SyntasticToggleMode 来切换激活(在写到 buffer 时检测)和被动(即手动检测)检测错误

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" simnalamburt/vim-mundo
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:mundo_width = 60
let g:mundo_preview_height = 40
let g:mundo_right = 1
