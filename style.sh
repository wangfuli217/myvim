tw_indentquiet (){
    for f in $@;
    do
        sed -i 's/\。/\./g' "$f";
        sed -i 's/\，/\,/g' "$f";
        sed -i 's/\”/\"/g' "$f";
        sed -i "s/\‘/\'/g" "$f";
        sed -i "s/\’/\'/g" "$f";
        sed -i 's/\“/\"/g' "$f";
        sed -i 's/\（/\(/g' "$f";
        sed -i 's/\）/\)/g' "$f";
        sed -i 's/\）/\)/g' "$f";
        sed -i 's/\？/\?/g' "$f";
        sed -i 's/\：/\:/g' "$f";
        sed -i 's/\；/\;/g' "$f";
        sed -i 's/\【/\[/g' "$f";
        sed -i 's/\】/\]/g' "$f";
        sed -i 's/\》/\>\>/g' "$f";
        sed -i 's/\《/\<\</g' "$f";
        sed -i 's/\–/\-/g' "$f";
    done
}

tw_indentwhite (){
    for f in $@;
    do
        local files="$f";
        sed -i 's/\s*$//g' $files;
        while true; do
            lines=$(wc -l < $files);
            nostr=$(sed -n ""$lines" p" "$files");
            if [ "Y$nostr" != "Y" ]; then
                break;
            fi;
            sed -i ""$lines" d" "$files";
        done;
    done
}

tw_indentcode (){
    for f in $@;
    do
        [ -f "$f" ] || continue;
        tw_indentquiet "$f";
        tw_indentwhite "$f";
    done
}

dos2unix        $VIM_FILEPATH
tw_indentcode   $VIM_FILEPATH

indent_c(){
  astyle --style=java -j -J -s4 -c -xn -xb -xl -xk -xV -xf -xh -S -L -K -N -m0 -p -H -xg -k3 -W3 -xC96 -n -z2 -v -Q -xe --mode=c --lineend=linux "${VIM_FILEPATH}"
  indent -kr -i4 -ts4 -sob -ss -sc -npsl -pcs -bs -bad -bap --ignore-newlines -l96 -nut -npro -brf "${VIM_FILEPATH}"
}

case $VIM_FILETYPE in
    go )  gofmt -l -s -w $VIM_FILEPATH ;;
    sh | bash ) shfmt -l -w -i 2 -ci $VIM_FILEPATH ;;
    c ) indent_c ;;
esac
