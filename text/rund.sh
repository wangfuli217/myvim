: > /tmp/test.$VIM_FILENAME
while IFS= read -r line; do
  echo "$line" >> /tmp/test.$VIM_FILENAME
done

case $VIM_FILETYPE in
    python ) python3 -i < /tmp/test.$VIM_FILENAME ;;
    sh | bash ) bash -i /tmp/test.$VIM_FILENAME ;;
    pl | perl ) perl /tmp/test.$VIM_FILENAME ;;
    lua ) lua /tmp/test.$VIM_FILENAME        ;;
esac
