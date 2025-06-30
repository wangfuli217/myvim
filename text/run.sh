: > /tmp/test.$VIM_FILENAME
while IFS= read -r line; do
  echo "$line" >> /tmp/test.$VIM_FILENAME
done
echo "" >> /tmp/test.$VIM_FILENAME

case $VIM_FILETYPE in
    python ) python3 /tmp/test.$VIM_FILENAME ;;
    sh | bash ) bash /tmp/test.$VIM_FILENAME ;;
    pl | perl ) perl /tmp/test.$VIM_FILENAME ;;
    lua ) lua /tmp/test.$VIM_FILENAME        ;;
    vim ) vimdbg -f /tmp/test.$VIM_FILENAME  ;;
    js | javascript ) node /tmp/test.$VIM_FILENAME ;;
esac
