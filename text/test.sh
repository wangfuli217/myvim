echo "argc=$# argv=$@"

while IFS= read line; do
echo "$line"
done

echo "VIM_ENCODING  = $VIM_ENCODING "   # value of &encoding in vim.
echo "VIM_FILEPATH  = $VIM_FILEPATH "   # file name of current buffer with full path
echo "VIM_FILENAME  = $VIM_FILENAME "   # file name of current buffer without path
echo "VIM_FILEDIR   = $VIM_FILEDIR  "   # full path of current buffer without the file name
echo "VIM_SCRIPT    = $VIM_SCRIPT   "   # file name of the filter program
echo "VIM_SCRIPTDIR = $VIM_SCRIPTDIR"   # directory of filter program
echo "VIM_FILETYPE  = $VIM_FILETYPE "   # file type of current buffer
echo "VIM_LINE1     = $VIM_LINE1    "   # start line of the given {range}
echo "VIM_LINE2     = $VIM_LINE2    "   # last line of the given {range}

#### 命令行参数
# argc=2 argv=hello world
#### 输入内容
# line import sys
# line import os
# line
# line if os.environ.get('VIM_ENCODING'):
# line encoding = os.environ['VIM_ENCODING']
# line
# line for line in sys.stdin:
# line sys.stdout.write(line.lower())
#### 环境变量
# VIM_ENCODING  = utf-8
# VIM_FILEPATH  = /home/wangfuli/.vim/text/lower.py
# VIM_FILENAME  = lower.py
# VIM_FILEDIR   = /home/wangfuli/.vim/text
# VIM_SCRIPT    = /home/wangfuli/.vim/text/test.sh
# VIM_SCRIPTDIR = /home/wangfuli/.vim/text
# VIM_FILETYPE  = python
# VIM_LINE1     = 1
# VIM_LINE2     = 11
