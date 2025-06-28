: > /tmp/test.$VIM_FILENAME
while IFS= read -r line; do
  echo "$line" >> /tmp/test.$VIM_FILENAME
done

case $VIM_FILETYPE in
    python ) python3 -i < /tmp/test.$VIM_FILENAME 2>&1 | sed -e 's/>>> />>>\n/g' ;;
    sh | bash ) bash -i /tmp/test.$VIM_FILENAME ;;
    pl | perl ) perl -E "use re 'debug'; $(cat /tmp/test.$VIM_FILENAME)" ;;
    lua ) lua /tmp/test.$VIM_FILENAME        ;;
esac
