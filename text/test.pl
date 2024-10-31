while(@ARGV) {
    print "$ARGV[0]\n";
    shift @ARGV;
}

while (<STDIN>) {
    print;
}

print "VIM_ENCODING  = $ENV{VIM_ENCODING};  \n";
print "VIM_FILEPATH  = $ENV{VIM_FILEPATH};  \n";
print "VIM_FILENAME  = $ENV{VIM_FILENAME};  \n";
print "VIM_FILEDIR   = $ENV{VIM_FILEDIR};   \n";
print "VIM_SCRIPT    = $ENV{VIM_SCRIPT};    \n";
print "VIM_SCRIPTDIR = $ENV{VIM_SCRIPTDIR}; \n";
print "VIM_FILETYPE  = $ENV{VIM_FILETYPE};  \n";
print "VIM_LINE1     = $ENV{VIM_LINE1};     \n";
print "VIM_LINE2     = $ENV{VIM_LINE2};     \n";

# hello
# world
# import sys
# import os
# import zhconv
#
# text = sys.stdin.buffer.read().decode('utf-8', 'ignore')
# output = zhconv.convert(text, 'zh-cn')
#
# sys.stdout.buffer.write(output.encode('utf-8', 'ignore'))
#
# VIM_ENCODING  = utf-8;
# VIM_FILEPATH  = /home/wangfuli/.vim/text/zhconv_cn.py;
# VIM_FILENAME  = zhconv_cn.py;
# VIM_FILEDIR   = /home/wangfuli/.vim/text;
# VIM_SCRIPT    = /home/wangfuli/.vim/text/text.pl;
# VIM_SCRIPTDIR = /home/wangfuli/.vim/text;
# VIM_FILETYPE  = python;
# VIM_LINE1     = 1;
# VIM_LINE2     = 10;