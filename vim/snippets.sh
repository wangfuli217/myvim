# How to post code snippets from the command line (contributes are welcome!)

#(CC) Andrea Fiore,
# Creative Commons, by Attribution Share Alike 2.0
# http://creativecommons.org/licenses/by-sa/2.0/
# andinventati.org

#debug:
#set -x

#todo: 1.Add a proper password field
#      2.Add options: description, tag lists, snippet name as options
#      3.improve options..
#      4.Add funky ansi colors

function help() {
  echo "Usage: "$(basename $0)" -u  [-P, -D ]"
}
while getopts "u:p:PdhH" opt; do
  case $opt in
    u) user=$OPTARG ;;
    p) pass=$OPTARG ;;
    P) private=1 ;;
    'h' | 'H') help ;;
    *) help ;;
  esac
done

shift $(($OPTIND - 1))

if [ -z $1 ]; then
  echo -e "What I am supposed to upload?\n missing filename... exiting"
  exit 1
fi
if [ -z $user ]; then
  echo -e "How am I supposed to log-in without your user name?\n"
  help
  exit 1
fi
if [ -z $pass ]; then
  read -p "password: " pass
  #how can I have a proper password field?
fi
if [ -z $1 ]; then
  echo "Missing file to upload; exiting"
  exit 1
fi
if [ -z $private ]; then
  private=1
fi

# get the autentication cookie and put it in the /tmp dir
curl -v -D /tmp/header -F "username=$user" -F "password=$pass" -l "http://www.bigbold.com/snippets/account/login" &>/dev/null
#grab the userid
userid=$(curl -b /tmp/header -l http://www.bigbold.com/snippets/ 2>/dev/null | grep -Eo 'post\[user_id\]\" value\=\"[0-9]{1,9}"' | sed -r 's/post\[user_id\]" value="([0-9]{1,9})"/\1/')

if [ $? = 1 ]; then
  echo -e "autentication failture, or unable to get userid!\n Exiting"
  exit 1
fi
#snip_cont=$(cat $1 | urlencode)
read -p "snippet title: " snip_title
read -p "description: " snip_desc
read -p "tags:" tags

snip='//'${snip_desc}'code'$(cat $1)'/code' # WARNIG: Code tags here are escaped...
#echo -e $content
curl -b /tmp/header.txt -F "post[id]= " -F "post[user_id]=$userid" -F "post[title]=$snip_title" -F "post[content]=$snip" -F "post[tag_list]=$tags" -F "post[private]=1" http://www.bigbold.com/snippets/posts/create/ &>/dev/null
#log-out
curl -b /tmp/header "http://www.bigbold.com/snippets/logout" &>/dev/null
