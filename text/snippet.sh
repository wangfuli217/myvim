: > /tmp/test.$VIM_FILENAME

if [ -n $1 ]; then
  snippet="$1"
  shift
else
  snippet="snippet"
fi

echo "#### $@" >> /tmp/test.$VIM_FILENAME
while IFS= read -r line; do
  echo "$line" >> /tmp/test.$VIM_FILENAME
done
echo "" >> /tmp/test.$VIM_FILENAME

[ -d  ~/.vim/snippet ] || mkdir -p  ~/.vim/snippet
for ft in python sh bash pl perl lua vim ini js javascript; do
  [ -d  ~/.vim/snippet/$ft/ ] || mkdir -p  ~/.vim/snippet/$ft/
done

case $VIM_FILETYPE in
    python ) cat /tmp/test.$VIM_FILENAME >> ~/.vim/snippet/$VIM_FILETYPE/$snippet.py ;;
    sh | bash ) cat /tmp/test.$VIM_FILENAME >> ~/.vim/snippet/$VIM_FILETYPE/$snippet.sh ;;
    pl | perl ) cat /tmp/test.$VIM_FILENAME >> ~/.vim/snippet/$VIM_FILETYPE/$snippet.pl ;;
    lua ) cat /tmp/test.$VIM_FILENAME >> ~/.vim/snippet/$VIM_FILETYPE/$snippet.lua ;;
    vim ) cat /tmp/test.$VIM_FILENAME >> ~/.vim/snippet/$VIM_FILETYPE/$snippet.vim ;;
    ini ) cat /tmp/test.$VIM_FILENAME >> ~/.vim/snippet/$VIM_FILETYPE/$snippet.ini ;;
    js | javascript ) cat /tmp/test.$VIM_FILENAME >> ~/.vim/snippet/$VIM_FILETYPE/$snippet.js ;;
esac
cat /tmp/test.$VIM_FILENAME