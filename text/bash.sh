echo "argc=$# argv=$@"

while read line; do
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

fzf
