# Amazon Q pre block. Keep at the top of this file.
# [[ -f "${HOME}/.local/share/amazon-q/shell/bashrc.pre.bash" ]] && builtin source "${HOME}/.local/share/amazon-q/shell/bashrc.pre.bash"
# Fig pre block. Keep at the top of this file.
# [[ -f "$HOME/.fig/shell/bashrc.pre.bash" ]] && builtin source "$HOME/.fig/shell/bashrc.pre.bash"
# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# # If not running interactively, don't do anything
# case $- in
#     *i*) ;;
#     *) return;;
# esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
# HISTCONTROL=ignoreboth
export HISTCONTROL='ignoredups:erasedups'

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
        # We have color support; assume it's compliant with Ecma-48
        # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
        # a case would tend to support setf rather than setaf.)
        color_prompt=yes
    else
        color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
    xterm*|rxvt*)
        PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
        ;;
    *)
        ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
    if [ -f /usr/share/bash-completion/bash_completion ]; then
        . /usr/share/bash-completion/bash_completion
    elif [ -f /etc/bash_completion ]; then
        . /etc/bash_completion
    fi
fi

export GIT_SSL_NO_VERIFY=1  # 忽略git认证

alias cdqsdk=svnqsdk
svnqsdk(){
  local oldpwd=$(pwd)
  while ! [ -d .svn ]; do
    cd ../
  done
  [ -d qsdk ] && cd $(pwd)/qsdk
  [ -n $1 ] && eval "$@"
  OLDPWD=${oldpwd}
}


# eval "$(lua /home/wangfuli/git/z.lua/z.lua  --init bash once enhanced)"   # BASH 初始化

alias sourcebash='source ~/.bashrc'
alias sourcetmux='tmux source-file ~/.tmux.conf'

alias tmux_WB_5G03='tmux attach -t WB_5G03'
alias tmux_FAP680M1='tmux attach -t FAP680-M1'

alias resovl='sudo cp /etc/resolv.conf.bak /etc/resolv.conf'

alias makee='make 2>&1 | tee ./makeerror.log | grep error'
alias makew='make 2>&1 | tee ./makewarn.log  | grep warning'
alias makes='make -j`nproc` V=1 QUILT=1'
alias makev='make -j1 V=sc'

# make  package/kernel/mac80211 clean ==> /logs/package/kernel/mac80211/compile.txt
alias makekconfig='make -j$(nproc) kernel_menuconfig '         # CONFIG_TARGET=subtarget
alias makekclean='cdqsdk; make -j$(nproc) target/linux/clean;' # rm -rf build_dir/target-*/linux-*
alias makek='cdqsdk; make target/linux/compile; make package/kernel/linux/compile'
alias makekv='cdqsdk; make target/linux/compile -j1 V=scw; make package/kernel/linux/compile -j1 V=scw'

# make target/linux/clean   V=s  # kernel clean
# make target/linux/prepare V=s  # kernel prepare
# make target/linux/refresh V=s  # kernel refresh
# make target/linux/compile V=s  # kernel compile
# make target/linux/install V=s  # kernel install

# mkpkg -j1 V=scw; mkpkg compile -j1 V=scw
mkpkg (){
  local oldpwd=$(pwd)
  cdqsdk;
  local dir
  # dir=$(find -L package/ -type d | grep -v 'files\|patches\|src\|hotplug.d\|config\|.svn\|.git' | fzf -0 -1 +m)
  dir=$(find -L package/ -name Makefile | xargs dirname | grep -v 'src\|kernel\|boot' | fzf -0 -1 +m )
  [ -n "$dir" ] && dir=$(basename $dir)
  [ -n "$dir" ] && { package=$(basename $dir);
    [ -n "${1}" ] && { cmd="${1}"; shift; }
    if [[ -n $cmd ]] ; then
      make package/$package/$cmd "$@"
    else
      make package/$package/{clean,compile} -j1 V=scw
    fi
    echo "make package/$package/{clean,compile};"
  }
  cd "$oldpwd"
}

# mkmod -j1 V=scw;  mkmod compile -j1 V=scw
mkmod (){
  local oldpwd=$(pwd)
  cdqsdk;
  local dir
  dir=$(find -L package/kernel/ -maxdepth 1 -type d | fzf -0 -1 +m)
  [ -n "$dir" ] && { module=$(basename $dir);
    [ -n "${1}" ] && { cmd="${1}"; shift; }
    if [[ -n $cmd ]] ; then
      make package/kernel/$package/$cmd "$@"
    else
      make package/kernel/$module/{clean,compile} -j1 V=scw
    fi
    echo "make package/kernel/$module/{clean,compile} $@";
  }
  cd "$oldpwd"
}

mkqsdk(){ # reduce fzf interactive @openwrt
  local oldpwd=$(pwd)
  cdqsdk;
  ( eval "$@"; )
  cd "$oldpwd"
}

mkuser (){ # reduce fzf interactive @sdk
  local oldpwd=$(pwd)
  cduser;
  local dir
  dir=$(find -maxdepth 1 -type d | fzf -0 -1 +m)
  [ -n "$dir" ] && ( cd $dir; make "$@"; )
  echo "$(basename $dir)"
  cd "$oldpwd"
}

mkorig(){ # reduce fzf interactive @sdk
  local oldpwd=$(pwd)
  cduser;
  eval "cd $1; make"
  cd "$oldpwd"
}

makekm() {  # depreciated; replace by mkmod
  local oldpwd=$(pwd)
  local module
  [ -z "$1" ] && module=$( cdqsdk; ls package/kernel | fzf; ) || module="$1"
  [ -d build_dir ] || cdqsdk
  eval ${project_mk_arg} ${project_user_mk_arg}
  make package/kernel/$module/{clean,compile} -j1 V=scw
  echo "make package/kernel/$module/{clean,compile} -j1 V=scw"
  cd $oldpwd
}

makevv(){ # depreciated; need PRODUCT_DIR=MR890H-N PRODUCT_HARDWARE_VERSION=MR890 environment variable
    local output="make.${RANDOM}"
    make -j1 V=scw "$@" 2>&1 | tee $output
    echo "vim $output"
}

gitc(){ # init a c git project
    [ -d .git ] && return
    git config user.name "wangfuli"
    git config user.email "wangfl217@126.com"
    git init
    cp /home/wangfuli/git/gitignore/C.gitignore ./.gitignore
    git add *
}

# 删除文件末尾128位签名
# dd if=KF_Image bs=1 count=6408390 of=orig
ubin_orig(){
  [ "$#" -ne 0 ] && [ -f $1 ] && {
    filesize=$(stat -c "%s" $1)
    filesize=$((filesize-128))
    dd if=$1 bs=1 count=$filesize of=$1.orig
    echo "$1.orig is unsign ubin"
  } || {
    echo "$# specify filename"
  }
}

ubin_digital(){
  [ "$#" -ne 0 ] && [ -f $1 ] && {
    filesize=$(stat -c "%s" $1)
    filesize=$((filesize-128))
    dd if=$1 bs=1 skip=$filesize count=128 of=$1.digit
    echo "$1.digit is signature information(digital signature)"
  } || {
    echo "$# specify filename"
  }
}

ubin_sign(){
  which verSignature >/dev/null 2>&1 ||  { echo "verSignature command is not exist"; return 1; }
  [ -f cakey.pem ] || cp /home/wangfuli/versign/cakey.pem .
  if [ "$#" -eq 0 ]; then
    for fl in ./*.ubin ; do
      cp $fl $fl.orig
      verSignature sign $fl /home/wangfuli/versign/cakey.pem
    done
  else
    cp $1 $1.orig
    verSignature sign $1 /home/wangfuli/versign/cakey.pem
  fi
  [ -f cakey.pem ] && rm -f cakey.pem
}

ubin_assert(){
  which verSignature >/dev/null 2>&1 ||  { echo "verSignature command is not exist"; return 1; }
  [ -f cakey.pem ] || cp /home/wangfuli/versign/cakey.pem .
  if [ "$#" -eq 0 ]; then
    for fl in ./*.ubin ; do
      verSignature verify $fl /home/wangfuli/versign/pubkey.pem
    done
  else
    cp $1 $1.orig
    verSignature verify $1 /home/wangfuli/versign/pubkey.pem
  fi
  [ -f pubkey.pem ] && rm -f pubkey.pem
}

ubin_bin_step=1
alias ubin_dir='mkdir $(date "+%a")$((ubin_bin_step++))_$(date "+ubin_%Y%m%d_%H%M%S")'
ubin_bin(){
    local suffix=$(date "+ubin_%Y%m%d_%H%M%S")
    local prefix=$(date "+%a")
    bindir="${prefix}$((ubin_bin_step++))_${suffix}"
    mkdir $bindir
    cp KF_Image $bindir
    local newbin=$(ls -dlt *Build* | grep '^d' | head -1 | awk '{print $NF}')
    mv ${newbin}/* $bindir
    rmdir ${newbin}
}

put_ubin(){ # put newest ubin to /ftptmp
  local oldpwd=$(pwd)
  [ -d images ] && {
    newdir=$(ls -dlt images/*Build* | grep '^d' | head -n 1 | awk '{print $NF}')
  } || {
    stat *-Buildx*  > /dev/null 2>&1 || { cdproject; [ -d images ] && cd images; }
    newdir=$(ls -dlt *Build* | grep '^d' | head -n 1 | awk '{print $NF}')
  }

  # echo "$newdir"/*.ubin
  [ "$(uname)" = "Linux" ] && {
    put "$newdir"/*.ubin
  } || {
    cp "$newdir"/*.ubin /ftptmp
  }
  cd ${oldpwd}
}
put_rbin(){ # put newest rbin to /ftptmp
  local oldpwd=$(pwd)
  [ -d images ] && {
    newdir=$(ls -dlt images/*Build* | grep '^d' | head -n 1 | awk '{print $NF}')
  } || {
    stat *-Buildx*  > /dev/null 2>&1 || { cdproject; [ -d images ] && cd images; }
    newdir=$(ls -dlt *Build* | grep '^d' | head -n 1 | awk '{print $NF}')
  }

  # echo "$newdir"/*.rbin
  [ "$(uname)" = "Linux" ] && {
    put "$newdir"/*.rbin
  } || {
    cp "$newdir"/*.rbin /ftptmp
  }
  cd ${oldpwd}
}
put_KF(){ # put newest KF_Image to /ftptmp
  local oldpwd=$(pwd)
  [ -d images ] && {
    newdir=$(pwd)/images
  } || {
    stat *-Buildx*  > /dev/null 2>&1 || { cdproject; [ -d images ] && cd images; }
    newdir=$(pwd)
  }

  [ "$(uname)" = "Linux" ] && {
    put "$newdir"/KF_Image
  } || {
    cp "$newdir"/KF_Image /ftptmp
  }
  cd ${oldpwd}
}

put_img(){ # put newest img or cpio.lzma to /ftptmp
  local oldpwd=$(pwd)
  cdqsdk

  [ -d build_dir ] && {
    test -f bin/*/openwrt-*-squashfs-root.img && {
        # echo bin/*/openwrt-*-squashfs-root.img
        put bin/*/openwrt-*-squashfs-root.img
    }
    find  bin/targets/ramips/ -name "*.bin" > /dev/null 2>&1 && {
        # echo bin/targets/ramips/*/*.bin
        put bin/targets/ramips/*/*.bin
    }
  }

  [ -d source ] && {
    # echo source/linux-*/usr/initramfs_data.cpio.lzma
    put source/linux-*/usr/initramfs_data.cpio.lzma
  }

  cd ${oldpwd}
}

alias put_bin='put_pkg'
put_pkg(){ # put pkg include executable file
  local oldpwd=$(pwd)
  [ -d build_dir ] || { svnqsdk; }

  local cdb_var="$1"
  [ "$#" = "0" ] && [ -n "$__last_cdb" ] && { cdb_var=$__last_cdb; }
  [ -z "$cdb_var" ] && { cd build_dir; return; }

  cd build_dir/target-*/${cdb_var}*
  put $(file * 2>&1 | grep linked | awk -F ':' '{print $1}')
  export __last_cdb="$cdb_var"
  export __last_cdp="$cdb_var"
  cd ${oldpwd}
}

put_opkg(){ # put put_opkg file
  local oldpwd=$(pwd)
  [ -d build_dir ] || { svnqsdk; }
  cd bin
  put $(fzf)
  cd ${oldpwd}
}

putx() {
rm -rf /mnt/hgfs/ftptmp/code/*
putc *.c *.h Makefile
}
getx() {
getc *.c *.h Makefile
rm -rf /mnt/hgfs/ftptmp/code/*
}

makeromfs(){
# export CROSS_COMPILE=/opt/buildroot-gcc463/usr/bin/mipsel-linux-
# export CC=${CROSS_COMPILE}gcc
# in subshell; AR..ROMFSINST are not export
(
export AR="/opt/buildroot-gcc463/usr/bin/mipsel-linux-ar"
export CC="/opt/buildroot-gcc463/usr/bin/mipsel-linux-gcc"
export CPP="/opt/buildroot-gcc463/usr/bin/mipsel-linux-cpp"
export LD="/opt/buildroot-gcc463/usr/bin/mipsel-linux-ld"
export RANLIB="/opt/buildroot-gcc463/usr/bin/mipsel-linux-ranlib"
export STRIP="/opt/buildroot-gcc463/usr/bin/mipsel-linux-strip"
current=$(pwd)
export ROMFSDIR="${current%%user*}/romfs"
export ROMFSINST="${current%%user*}/tools/romfs-inst.sh"
make romfs
)
}

alias cdbin='svnbin'
svnbin(){
  local oldpwd=$(pwd)
  ls -tld *-ZHCN* > /dev/null 2>&1 && {
    cd $(ls -tld *-ZHCN* | head -n 1 | awk '{print $NF}')
    OLDPWD=${oldpwd}
  }
  ls -tld ./images/*-ZHCN* > /dev/null 2>&1 && {
    cd $(ls -tld ./images/*-ZHCN* | head -n 1 | awk '{print $NF}')
    OLDPWD=${oldpwd}
  }
}

alias cdromfs=svnromfs
svnromfs(){
  local oldpwd=$(pwd)
  while ! [ -d .svn ]; do
    cd ../
  done
  [ -d "$(pwd)/source/romfs/" ] && cd $(pwd)/source/romfs/
  [ -n $1 ] && eval "$@"
  OLDPWD=${oldpwd}
}

alias cduser=svnuser
svnuser(){
  local oldpwd=$(pwd)
  while ! [ -d .svn ]; do
    cd ../
  done
  [ -d "$(pwd)/source/user/" ] && cd $(pwd)/source/user/
  [ -n $1 ] && eval "$@"
  OLDPWD=${oldpwd}
}

put_user(){
  local oldpwd=$(pwd)
  while ! [ -d .svn ]; do
    cd ../
  done
  [ -d "$(pwd)/source/user/" ] && cd $(pwd)/source/user/
  local pkgdir
  [ -n "$1" ] && pkgdir="$1" || pkgdir=$(find -maxdepth 1 -type d | fzf)
  [ -n "$pkgdir" ] &&  (
    cd "$pkgdir"
    [ -d src ] && cd src
    put $(file * 2>&1 | grep linked | awk -F ':' '{print $1}')
  )
  cd "$oldpwd"
  OLDPWD=${oldpwd}
}

mkuser(){
  local oldpwd=$(pwd)
  while ! [ -d .svn ]; do
    cd ../
  done
  [ -d "$(pwd)/source/user/" ] && cd $(pwd)/source/user/
  local pkgdir
  [ -n "$1" ] && pkgdir="$1" || pkgdir=$(find -maxdepth 1 -type d | fzf)
  [ -n "$pkgdir" ] && ( cd "$pkgdir"; make clean; make; )
  cd "$oldpwd"
  OLDPWD=${oldpwd}
}

alias cdproduct=svnproduct
svnproduct(){
  local oldpwd=$(pwd)
  while ! [ -d .svn ]; do
    cd ../
  done
  product=$(find $(pwd)/product -maxdepth 1 -type d | fzf)
  [ -n "$product" ] && cd "$product"
  OLDPWD=${oldpwd}
}

alias _cdproduct=_svnproduct
_svnproduct(){
  local oldpwd=$(pwd)
  while ! [ -d .svn ]; do
    cd ../
  done
  [ -d "$(pwd)/product" ] && cd $(pwd)/product
  OLDPWD=${oldpwd}
}

alias cdroot=svnroot
svnroot(){
  local oldpwd=$(pwd)
  while ! [ -d .svn ]; do
    cd ../
  done
  [ -n $1 ] && eval "$@"
  OLDPWD=${oldpwd}
}

_gitroot() {
    git rev-parse --show-toplevel
}
cdgit() {
  cd "$(_gitroot)/${1:-}";
  [ -n $1 ] && eval "$@"
}


alias cdpackage=svnpackage
alias cdpkg=svnpackage
svnpackage(){
  local oldpwd=$(pwd)
  while ! [ -d .svn ]; do
    cd ../
  done
  [ -d qsdk ] && cd $(pwd)/qsdk
  [ -d package ] && cd package
  [ -n $1 ] && eval "$@"
  OLDPWD=${oldpwd}
}


alias project='export __project=$(pwd)'
cdproject(){
  local oldpwd=$(pwd)
  [ -n "$__project" ] && cd ${__project} || {
    _cdproduct
    local project_var=$(ls -dlt * | grep '^d' | head -n 1 | awk '{print $NF}')
    [ -n "project_var" ] && [ -d "$(pwd)/$project_var" ] && {
      cd $(pwd)/$project_var;
    }
  }
  OLDPWD=${oldpwd}
}

export project_user_mk_arg=  # '-j1 V=s'

# s: stdout+stderr        (equal to the old V=99) V=99 OPENWRT_VERBOSE:=s
# c: commands (for build systems that suppress commands by default,e.g. kbuild,cmake)
# w: warnings/errors only (equal to the old V=1)  V=1  OPENWRT_VERBOSE:=w
mklaste(){
  local oldpwd=$(pwd)
  [ -d build_dir ] || cdqsdk;
  __last_cdp=$1
  shift
  method=$(echo -e "compile\nprepare\nconfigure\ninstall\nclean\nrefresh\nupdate\ndownload\ncheck\nkernel_menuconfig\nmenuconfig\nclean\ntargetclean\ndirclean\n" | fzf)
  if [ "$method" = "kernel_menuconfig" ]; then
    make kernel_menuconfig
  elif [ "$method" = "menuconfig" ]; then
     make menuconfig
  elif [ "$method" = "clean" ]; then
     make clean
  elif [ "$method" = "targetclean" ]; then
     make targetclean
  elif [ "$method" = "dirclean" ]; then
     make dirclean
  else
    make package/$__last_cdp/$method "$@" # -j1 V=scw 
  fi
  cd $oldpwd
}

mklast() {
  local verbose
  local cmd
  local fuzzysel
  while getopts ':vxc:h' x; do
      case "$x" in
          v) verbose="1"   ;;
          x) fuzzysel="1"  ;;
          c) cmd=${OPTARG} ;;
          h) echo "mklast [-v|verbose] [-x|fuzzysel cmd] [-c|specified cmd] package";
             echo "mklast          netifd"; # {clean,compile}
             echo "mklast -v       netifd"; # {clean,compile} -j1 V=scw
             echo "mklast -x       netifd"; # command selected  by fzf
             echo "mklast -c clean netifd"; # command specified by user
             return
          ;;
      esac
  done
  shift $(( OPTIND - 1 ))
  unset x OPTARG OPTIND

  [ -n "${2}" ] && { cmd="${2}"; shift; shift; }
  [[ -n $verbose ]] && verbose="-j1 V=scw"

  local oldpwd=$(pwd)
  [ -d build_dir ] || cdqsdk
  [ -n "$1" ] && { __last_cdp="$1"; __last_cdb="$1"; }
  eval ${project_mk_arg} ${project_user_mk_arg}

  [[ -n $fuzzysel ]] && { mklaste $__last_cdp; cd $oldpwd; return; }
  [ -n "$__last_cdp" ] && {
    if [[ -n $cmd ]] ; then
      make package/$__last_cdp/$cmd $verbose "$@"
    else
      make package/$__last_cdp/{clean,compile} $verbose
    fi
  }
  cd $oldpwd
}

mklastv(){
  local oldpwd=$(pwd)
  [ -d build_dir ] || cdqsdk;
  [ -n "$1" ] && { __last_cdp="$1"; __last_cdb="$1"; }

  [ -n "${2}" ] && { cmd="${2}"; shift; shift; }
  eval ${project_mk_arg} ${project_user_mk_arg}
  [ -n "$__last_cdp" ] && {
    if [[ -n $cmd ]] ; then
      make package/$__last_cdp/$cmd -j1 V=s "$@"
    else
      make package/$__last_cdp/{clean,compile} -j1 V=s
    fi
  }
  cd $oldpwd
}

mklastq(){
  local oldpwd=$(pwd)
  [ -d build_dir ] || cdqsdk;
  [ -n "$1" ] && { __last_cdp="$1"; __last_cdb="$1"; }
  eval ${project_mk_arg} ${project_user_mk_arg}
  [ -n "$__last_cdp" ] && make package/$__last_cdp/compile -j1 V=s
  cd $oldpwd
}

project_env(){
  local makecmd=$(grep PRODUCT_DIR mkall.sh)
  makecmd=${makecmd#*PRODUCT_DIR}
  makecmd=PRODUCT_DIR${makecmd}
  export project_mk_arg=${makecmd}
}

mkall(){
  local oldpwd=$(pwd)

  while ! [ -d .svn ]; do
    cd ../
  done

  local product_path
  [ -n "$1" ] && product_path="$(pwd)/product/$1" || product_path=$(find $(pwd)/product -maxdepth 1 -type d | fzf)
  [ -d "$product_path" ] && {
    cd "$product_path"
    [ "$#" = "0" ] && { ./mkall.sh zh; export PRODUCT_DIR=$(basename $(pwd)); project_env; echo "mkall $(basename $product_path)"; } || \
    { ./mkall.sh ; export PRODUCT_DIR=$(basename $(pwd)); project_env; echo "mkall $(basename $product_path)"; };
  }
  cd ${oldpwd};
}

md5k(){ # tftp升级
  ls KF_Image > /dev/null 2>&1 && {
    md5sum KF_Image
  }

  cdproject;
  ls images/KF_Image > /dev/null 2>&1 && {
    md5sum images/KF_Image
  }
  ls /mnt/hgfs/ftptmp/KF_Image > /dev/null 2>&1 && {
    md5sum /mnt/hgfs/ftptmp/KF_Image
  }
}
md5u(){ # web升级
  ls *.ubin > /dev/null 2>&1 && {
    md5sum *.ubin
  }
  ls /mnt/hgfs/ftptmp/*.ubin > /dev/null 2>&1 && {
    md5sum /mnt/hgfs/ftptmp/*.ubin
  }
}
md5r(){ # 工厂升级
  ls *.rbin > /dev/null 2>&1  && {
    md5sum *.rbin
  }
  ls /mnt/hgfs/ftptmp/*.rbin > /dev/null 2>&1 && {
    md5sum /mnt/hgfs/ftptmp/*.rbin
  }
}

# default cd to last build_dir feeds
# cdb configmanage
cdb(){
  local oldpwd=$(pwd)
  [ -d build_dir ] || { svnqsdk; }

  local cdb_var="$1"

  if [[ "$cdb_var" = "fzf" || -z "$cdb_var" ]]; then
     dir=$(find build_dir/target-* -maxdepth 1 -type d | fzf -0 -1 +m)
     [ -n "$dir" ] && [ -d "$dir" ] && cd "$dir"
  else
    cd build_dir/target-*/${cdb_var}*
  fi

  eval xsync
  OLDPWD=${oldpwd}
}

# default cd to last package feeds
# cdp configmanage
cdp(){
  local oldpwd=$(pwd)
  [ -d package ] || { svnqsdk; }

  local cdp_var="$1"

  cd package
  if [[ "$cdp_var" = "fzf" || -z "$cdp_var" ]]; then
    dir=$(find -L -name Makefile | xargs dirname | grep -v 'src\|kernel\|boot' | fzf -0 -1 +m )
    [ -n "$dir" ] && [ -d "$dir" ] && cd "$dir"
  else
    cd $(find -L -maxdepth 4 -type d -name "*$cdp_var*" | head -n 1)
  fi

  [ -d src ] && { cd src; eval xsync; }
  eval xsync
  OLDPWD=${oldpwd}
}

cdrootfs(){
  local oldpwd=$(pwd)
  [ -d build_dir ] || { svnqsdk; }
  cd build_dir/target-*/linux-*/base-files/ipkg-*/base-files
  [ -n $1 ] && eval "$@"
  OLDPWD=${oldpwd}
}

cross_path_arm(){
  local oldpwd=$(pwd)
  [ -d build_dir ] || cdqsdk
  cd staging_dir/toolchain-aarch*/bin/
  local cross_path=$(pwd)
  cd -

  PATH=${cross_path}:${PATH}
  export PATH
  ls ${cross_path}
  cd $oldpwd
}

cross_path_mips(){
  local oldpwd=$(pwd)
  [ -d build_dir ] || cdqsdk
  cd staging_dir/toolchain-mips*/bin/
  local cross_path=$(pwd)
  cd -

  PATH=${cross_path}:${PATH}
  export PATH
  ls ${cross_path}
  cd $oldpwd
}

#
# cdp(){
# local t=$(pwd)
# cd $__old_dir
# export __old_dir=${t}
# }

alias cdftp='cd /mnt/hgfs/ftptmp/'
#[c]
indentlen='wc -L $@'
indentwfl(){
  dos2unix "$@"
  indent -kr -i4 -ts4 -sob -ss -sc -npsl -pcs -bs --ignore-newlines -l200 -nut -npro -brf -nbbo "$@"
}

indentyc(){
  for f in $@; do
    count=$(wc -L $f | awk '{print $1}')
    dos2unix $f
    sed -i 's/\s*$//g' $f;
    indent -kr -i4 -ts4 -sob -ss -sc -npsl -pcs -bs --ignore-newlines -l${count} -nut -npro -brf -nbbo $f
  done
}

indentycc(){
  indentyc *.c
  indentyc *.h
}

alias exptab="perl -pi -e 's/\t/ q( ) x ( 4 - pos() %4 ) /ge' "
alias cppcheckwfl='cppcheck --std=c99 --enable=warning,style -v '
#[bash]
alias shfmt='shfmt -l -w -i 2 -ci'
alias shfmt2='shfmt -l -w -i 2 -ci'
alias shfmt4='shfmt -l -w -i 4 -ci'
# shellcheck

alias tclsh='rlwrap tclsh'
alias lua="rlwrap -Ar -pcyan --always-readline lua"
alias iperl='rlwrap -A -S "iperl> " perl -MData::Printer -wnE '\'' BEGIN { say "HI"; } say eval()//$@'\' # sudo cpan Data::Printer 有返回值回显1
alias vi='vim -u ~/.vimrc-backup'

# ntpdate -s time.nist.gov
alias xsync='pwd > /mnt/hgfs/ftptmp/xsync'
alias eu='pwd > /mnt/hgfs/ftptmp/xsync'

alias psmem10='ps auxf | sort -nr -k 4 | head -10'
alias pscpu10='ps auxf | sort -nr -k 3 | head -10'

cdvim(){
  local oldpwd=$(pwd)
  cdroot
  [ -d vimwork ] && cd vimwork || cd ${oldpwd}
}


vimdone(){
  local oldpwd=$(pwd)
  cdroot
  [ -d vimwork ] && rm -rf vimwork
  cd ${oldpwd}
}

vimwork(){
  local oldpwd=$(pwd)
  cdroot
  [ -d vimwork ] || mkdir vimwork

  for dir in $@; do
    [ ${dir%/*} = ${dir} ] || {
      [ -d ${dir} ] && ln -sf ${dir} vimwork/${dir##*/}
      continue
    }

    if [ -d qsdk/package/system ]; then
      cdir=$(find qsdk/package -name "${dir}*" -type d)
      [ -d $(pwd)/${cdir} ] && ln -sf $(pwd)/${cdir} vimwork
      continue
    fi

    if [ -d source/user ]; then
      [ -d source/user/${dir} ] && ln -sf $(pwd)/source/user/${dir} vimwork
      continue
    fi

    if [ -d package/system ]; then
      cdir=$(find package -name "${dir}*" -type d)
      [ -d $(pwd)/${cdir} ] && ln -sf $(pwd)/${cdir} vimwork
      continue
    fi
  done

  [ -n "$1" ] && { cd ${oldpwd}; return; }

  if [ -d qsdk/package/system ]; then
    [ -d $(pwd)/qsdk/package/libs/libconfig_data_api    ] && ln -sf $(pwd)/qsdk/package/libs/libconfig_data_api      vimwork
    [ -d $(pwd)/qsdk/package/libs/libdev_op_api         ] && ln -sf $(pwd)/qsdk/package/libs/libdev_op_api           vimwork
    [ -d $(pwd)/qsdk/package/libs/libcomm_api           ] && ln -sf $(pwd)/qsdk/package/libs/libcomm_api             vimwork
    [ -d $(pwd)/qsdk/package/system/checkapp            ] && ln -sf $(pwd)/qsdk/package/system/checkapp              vimwork
    [ -d $(pwd)/qsdk/package/system/configmanage        ] && ln -sf $(pwd)/qsdk/package/system/configmanage          vimwork
    [ -d $(pwd)/qsdk/package/system/timertasket         ] && ln -sf $(pwd)/qsdk/package/system/timertasket           vimwork
    [ -d $(pwd)/qsdk/package/system/xc_acd              ] && ln -sf $(pwd)/qsdk/package/system/xc_acd                vimwork
    [ -d $(pwd)/qsdk/package/system/client-monitor      ] && ln -sf $(pwd)/qsdk/package/system/client-monitor        vimwork
    [ -d $(pwd)/qsdk/package/system/macmanage           ] && ln -sf $(pwd)/qsdk/package/system/macmanage             vimwork
    [ -d $(pwd)/qsdk/package/system/systemconf          ] && ln -sf $(pwd)/qsdk/package/system/systemconf            vimwork
    [ -d $(pwd)/qsdk/package/system/openCAPWAP          ] && ln -sf $(pwd)/qsdk/package/system/openCAPWAP            vimwork
    [ -d $(pwd)/qsdk/package/network/utils/cloud-client ] && ln -sf $(pwd)/qsdk/package/network/utils/cloud-client   vimwork
    [ -d $(pwd)/qsdk/package/network/utils/cgi-bin      ] && ln -sf $(pwd)/qsdk/package/network/utils/cgi-bin        vimwork
    [ -d $(pwd)/qsdk/package/network/utils/cloud-rzx    ] && ln -sf $(pwd)/qsdk/package/network/utils/cloud-rzx      vimwork
  fi


  if [ -d source/user ]; then
    [ -d source/user/client-monitor      ] && ln -sf $(pwd)/source/user/client-monitor     vimwork
    [ -d source/user/client_roaming      ] && ln -sf $(pwd)/source/user/client_roaming     vimwork
    [ -d source/user/cloudiot            ] && ln -sf $(pwd)/source/user/cloudiot           vimwork
    [ -d source/user/apmanage            ] && ln -sf $(pwd)/source/user/apmanage           vimwork
    [ -d source/user/cgi-bin             ] && ln -sf $(pwd)/source/user/cgi-bin            vimwork
    [ -d source/user/macaddr             ] && ln -sf $(pwd)/source/user/macaddr            vimwork
    [ -d source/user/uwifi_tools         ] && ln -sf $(pwd)/source/user/uwifi_tools        vimwork
    [ -d source/user/configmanage        ] && ln -sf $(pwd)/source/user/configmanage       vimwork
    [ -d source/user/json-c-0.12.1       ] && ln -sf $(pwd)/source/user/json-c-0.12.1      vimwork
    [ -d source/user/libcomm_api         ] && ln -sf $(pwd)/source/user/libcomm_api        vimwork
    [ -d source/user/libconfig_data_api  ] && ln -sf $(pwd)/source/user/libconfig_data_api vimwork
    [ -d source/user/libdev_op_api       ] && ln -sf $(pwd)/source/user/libdev_op_api      vimwork
    [ -d source/user/systemconf          ] && ln -sf $(pwd)/source/user/systemconf         vimwork
    [ -d source/user/sysupgrade          ] && ln -sf $(pwd)/source/user/sysupgrade         vimwork
    [ -d source/user/openCAPWAP          ] && ln -sf $(pwd)/source/user/openCAPWAP         vimwork
  fi

  if [ -d package/system ]; then
    [ -d $(pwd)/package/libs/libconfig_data_api    ] && ln -sf $(pwd)/qsdk/package/libs/libconfig_data_api     vimwork
    [ -d $(pwd)/package/libs/libdev_op_api         ] && ln -sf $(pwd)/qsdk/package/libs/libdev_op_api          vimwork
    [ -d $(pwd)/package/libs/libcomm_api           ] && ln -sf $(pwd)/qsdk/package/libs/libcomm_api            vimwork
    [ -d $(pwd)/package/system/checkapp            ] && ln -sf $(pwd)/qsdk/package/system/checkapp             vimwork
    [ -d $(pwd)/package/system/configmanage        ] && ln -sf $(pwd)/qsdk/package/system/configmanage         vimwork
    [ -d $(pwd)/package/system/timertasket         ] && ln -sf $(pwd)/qsdk/package/system/timertasket          vimwork
    [ -d $(pwd)/package/system/xc_acd              ] && ln -sf $(pwd)/qsdk/package/system/xc_acd               vimwork
    [ -d $(pwd)/package/system/client-monitor      ] && ln -sf $(pwd)/qsdk/package/system/client-monitor       vimwork
    [ -d $(pwd)/package/system/macmanage           ] && ln -sf $(pwd)/qsdk/package/system/macmanage            vimwork
    [ -d $(pwd)/package/system/systemconf          ] && ln -sf $(pwd)/qsdk/package/system/systemconf           vimwork
    [ -d $(pwd)/package/system/openCAPWAP          ] && ln -sf $(pwd)/qsdk/package/system/openCAPWAP           vimwork
    [ -d $(pwd)/package/network/utils/cloud-client ] && ln -sf $(pwd)/qsdk/package/network/utils/cloud-client  vimwork
    [ -d $(pwd)/package/network/utils/cgi-bin      ] && ln -sf $(pwd)/qsdk/package/network/utils/cgi-bin       vimwork
    [ -d $(pwd)/package/network/utils/cloud-rzx    ] && ln -sf $(pwd)/qsdk/package/network/utils/cloud-rzx     vimwork
  fi

  cd vimwork
  [ -d .git ] || {
      git init
      # cp /home/wangfuli/git/gitignore/C.gitignore ./.gitignore
      git add *
      git commit -m "init"
  }
  cd ${oldpwd}
}

putyc(){
  [ -d libconfig_data_api ] || svnuser;

  [ -n "$1" ] && dest="/mnt/hgfs/ftptmp/$1" || {
    [ -n "$PRODUCT_DIR" ] && dest="/mnt/hgfs/ftptmp/$PRODUCT_DIR" || {
       echo "putyc project_name"
    }
  }

  shift
  mkdir $dest
  [ -d client-monitor     ] && cp -r client-monitor      $dest > /dev/null 2>&1
  [ -d client_roaming     ] && cp -r client_roaming      $dest > /dev/null 2>&1
  [ -d cloudiot           ] && cp -r cloudiot            $dest > /dev/null 2>&1
  [ -d apmanage           ] && cp -r apmanage            $dest > /dev/null 2>&1
  [ -d cgi-bin            ] && cp -r cgi-bin             $dest > /dev/null 2>&1
  [ -d macaddr            ] && cp -r macaddr             $dest > /dev/null 2>&1
  [ -d uwifi_tools        ] && cp -r uwifi_tools         $dest > /dev/null 2>&1
  [ -d configmanage       ] && cp -r configmanage        $dest > /dev/null 2>&1
  [ -d json-c-0.12.1      ] && cp -r json-c-0.12.1       $dest > /dev/null 2>&1
  [ -d libcomm_api        ] && cp -r libcomm_api         $dest > /dev/null 2>&1
  [ -d libconfig_data_api ] && cp -r libconfig_data_api  $dest > /dev/null 2>&1
  [ -d libdev_op_api      ] && cp -r libdev_op_api       $dest > /dev/null 2>&1
  [ -d systemconf         ] && cp -r systemconf          $dest > /dev/null 2>&1
  [ -d sysupgrade         ] && cp -r sysupgrade          $dest > /dev/null 2>&1
  [ -d openCAPWAP         ] && cp -r openCAPWAP          $dest > /dev/null 2>&1
  for app in $@; do
    [ -d "$app" ] && cp -r "$app" $dest > /dev/null 2>&1
  done
  # ( cd /mnt/hgfs/ftptmp/$1; find -name "*.o" | xargs rm -f; find -name "*.so*" | xargs rm -f; find -name ".git" | xargs rm -f; )
}
putwrt(){
  [ -d build_dir ] || cdqsdk;
  [ -n "$1" ] && dest="/mnt/hgfs/ftptmp/$1" || {
    [ -n "$PRODUCT_DIR" ] && dest="/mnt/hgfs/ftptmp/$PRODUCT_DIR" || {
       echo "putwrt project_name"
    }
  }

  shift
  mkdir $dest
  mkdir -p $dest/{base-files,boot,devel,kernel,libs,network,system,utils}
  mkdir -p $dest/network/utils/
  [ -d package/libs/libconfig_data_api    ] && cp -rf package/libs/libconfig_data_api     $dest/libs/libconfig_data_api
  [ -d package/libs/libdev_op_api         ] && cp -rf package/libs/libdev_op_api          $dest/libs/libdev_op_api
  [ -d package/libs/libcomm_api           ] && cp -rf package/libs/libcomm_api            $dest/libs/libcomm_api
  [ -d package/system/checkapp            ] && cp -rf package/system/checkapp             $dest/system/checkapp
  [ -d package/system/configmanage        ] && cp -rf package/system/configmanage         $dest/system/configmanage
  [ -d package/system/timertasket         ] && cp -rf package/system/timertasket          $dest/system/timertasket
  [ -d package/system/xc_acd              ] && cp -rf package/system/xc_acd               $dest/system/xc_acd
  [ -d package/system/client-monitor      ] && cp -rf package/system/client-monitor       $dest/system/client-monitor
  [ -d package/system/macmanage           ] && cp -rf package/system/macmanage            $dest/system/macmanage
  [ -d package/system/systemconf          ] && cp -rf package/system/systemconf           $dest/system/systemconf
  [ -d package/system/openCAPWAP          ] && cp -rf package/system/openCAPWAP           $dest/system/openCAPWAP
  [ -d package/network/utils/cloud-client ] && cp -rf package/network/utils/cloud-client  $dest/network/utils/cloud-client
  [ -d package/network/utils/cgi-bin      ] && cp -rf package/network/utils/cgi-bin       $dest/network/utils/cgi-bin
  [ -d package/network/utils/cloud-rzx    ] && cp -rf package/network/utils/cloud-rzx     $dest/network/utils/cloud-rzx

  for app in $@; do
    [ -d "package/$app" ] && cp -r "package/$app" $dest/$app > /dev/null 2>&1
  done
}

# Syntax: "repeat_ok [command]"
repeat_ok()  { while :; do "$@" && return; done }
# Syntax: "repeat_err [command]"
repeat_err() { while :; do "$@" || return; done }
# Syntax: "repeat_sleep <timeout> <command>"
repeat_sleep() { timeout=$1; shift; while :; do "$@" && return; sleep $timeout; done }    # 加入延时


alias yuncore+='yuncore_help'
yuncore_help(){   cat - <<'yuncore_help'
cdp:       default cd to last cdp/cdb package   module, otherwise with name for specifying openwrt package   module;
cdb:       default cd to last cdp/cdb build_dir module, otherwise with name for specifying openwrt build_dir module;
cdf:       default cd to last cdf directory, otherwise with name for specifying directory or file in directory; # replace with fdf
cdromfs:   cd to default padavan romfs  directory
cdrootfs:  cd to default openwrt rootfs directory
cduser:    cd to default padavan user  directory
cdroot:    cd to default padavan/openwrt root directory
cdqsdk:    cd to default openwrt root  directory
cdpkg:     cd to default openwrt package  directory
cdproject: cd to current project directory
_cdproduct: cd to current product directory
put_ubin:  put last *.ubin to /ftptmp
put_rbin:  put last *.rbin to /ftptmp
put_FK:    put last KF_Image to /ftptmp
mklast:    default clean/compile cdb/cdp project, otherwise with name for specifying openwrt module;
mklastv:   likewise above with -j1 V=s*
mkall:     default build current project, project record with mkall.sh file or newest product/project
mkall0:    'mkall zh 0'
makeromfs:  make romfs option in padavan module
cross_path_arm:  add arm  cross compile tools to PATH
cross_path_mips: add mips cross compile tools to PATH
vimwork:   create vim work directory
vimdone:   remove vim work directory
cdvim:     cd to vim work directory
yuncore_help
}

alias wfl+='wfl_help'
wfl_help(){   cat - <<'wfl_help'
repeat_ok/repeat_err/repeat_sleep
gitc
sourcebash: source ~/.bashrc
sourcetmux: source ~/.tmux.conf
psmem10: sort mem top 10
pscpu10: sort cpu top 10
makee/makew: trace error/warning for making padavan
makes/makev: make quit or verbose for making openwrt
makek/makekv/makeclean: make quit or verbose for making openwrt or clean kernel
makekm: make linux kernel module;
wfl_help
}

# eval "$(starship init bash)" # 跨shell的可定制的提示符

source ~/.fzf/shell/key-bindings.bash
source ~/.fzf/shell/completion.bash
# FZF_ALT_C_COMMAND= eval "$(fzf --bash)"

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

export FZF_MARKS_JUMP='\C-x\C-g'
[ -d /home/wangfuli/git/fzf-marks ] && source /home/wangfuli/git/fzf-marks/fzf-marks.plugin.bash

FZF_CHEATSHEETS_DIR="/home/wangfuli/git/fzf-cheatsheets"
export PATH="$PATH:${FZF_CHEATSHEETS_DIR}/bin"
export PATH=/home/wangfuli/.vim/bin/:${PATH}
source "${FZF_CHEATSHEETS_DIR}/shell/fzf-cheatsheets.bash"
export PATH="$PATH:/home/wangfuli/git/cheatsheets"

#### fzf + vim ####
# fe [FUZZY PATTERN] - Open the selected file with the default editor
#   - Bypass fuzzy finder if there's only one match (--select-1)
#   - Exit if there's no match (--exit-0)
fe() {
  IFS=$'\n' files=($(fzf-tmux --query="$1" --multi --select-1 --exit-0))
  [[ -n "$files" ]] && ${EDITOR:-vim} "${files[@]}"
}

fzfrun(){  # tmux大量日志情况下,分析日志信息
  eval "$@" 2>&1 > /tmp/fzfrun.log
  cat /tmp/fzfrun.log | fzf --bind "enter:execute(vim /tmp/fzfrun.log)"
}

alias fzfv='vim $(fzf -m --bind "ctrl-e:execute(vim {})" --bind "ctrl-o:execute(xdg-open {})" --bind "ctrl-a:select-all" --bind "ctrl-d:deselect-all" --preview "bat --style=numbers --color=always {}" )' #用来多选:TAB选中和Shift-TAB取消
alias fzfe='fzf --bind "enter:execute(vim {})" --bind "ctrl-e:execute(vim {})" --bind "ctrl-o:execute(xdg-open {})" --bind "ctrl-a:select-all" --bind "ctrl-d:deselect-all" --preview "bat --style=numbers --color=always {}"'
alias fzftmp='find /mnt/hgfs/ftptmp -maxdepth 1 -type f | fzf -m --bind "enter:execute(vim {})" --bind "ctrl-o:execute(xdg-open {})" --bind "ctrl-e:execute(vim {})" --bind "ctrl-a:select-all" --bind "ctrl-d:deselect-all" --preview "bat {}"'
alias fzfcheat='find /home/wangfuli/git/fzf-cheatsheets/cheatsheets -type f | fzf -m --bind "enter:execute(vim {})" --bind "ctrl-e:execute(vim {})" --bind "ctrl-o:execute(xdg-open {})" --bind "ctrl-a:select-all"  --bind "ctrl-d:deselect-all" --preview "bat {}"'

viminfo (){
  local files;
  files=$(grep '^>' ~/.viminfo | cut -c3- |
    while read line; do
    [ -f "${line/\~/$HOME}" ] && echo "$line"
    done | fzf -d -m -q "$*" -1) && vim ${files//\~/$HOME}
}

vimdir () {
    local files;
    files=$(grep '^>' ~/.viminfo | cut -c3- |
    while read line; do
    [ -f "${line/\~/$HOME}" ] && echo "$line"
    done | fzf -d -m -q "$*" -1) && cd $(dirname $files)
}

dirdiff(){
    # Shell-escape each path:
    DIR1=$(printf '%q' "$1"); shift
    DIR2=$(printf '%q' "$1"); shift
    vim "$@" -c "DirDiff $DIR1 $DIR2"
}

# Modified version where you can press
#   - CTRL-O to open with `open` command,
#   - CTRL-E or Enter key to open with the $EDITOR
fo() {
  IFS=$'\n' out=("$(fzf-tmux --query="$1" --exit-0 --expect=ctrl-o,ctrl-e)")
  key=$(head -1 <<< "$out")
  file=$(head -2 <<< "$out" | tail -1)
  if [ -n "$file" ]; then
    [ "$key" = ctrl-o ] && open "$file" || ${EDITOR:-vim} "$file"
  fi
}

#### fzf + grep + vim ####
# vf - fuzzy open with vim from anywhere
# ex: vf word1 word2 ... (even part of a file name)
# zsh autoload function
vf() {
  local files

  files=(${(f)"$(locate -Ai -0 "$@" | grep -z -vE '~$' | fzf --read0 -0 -1 -m)"})

  if [[ -n $files ]]
  then
     vim -- $files
     print -l $files[1]
  fi
}

# fuzzy grep open via ag
vg() {
  local file

  file="$(ag --nobreak --noheading "$@" | fzf -0 -1 -m | awk -F: '{print $1}')"

  if [[ -n $file ]] ; then
     vim $file
  fi
}

# fuzzy grep open via ag with line number
vgf() {
  local file
  local line

  read -r file line <<<"$(ag --nobreak --noheading "$@" | fzf -m -0 -1 | awk -F: '{print $1, $2}')"

  if [[ -n $file ]] ; then
     vim $file +$line
  fi
}

vgd() {
  local file

  file="$(ag --nobreak --noheading "$@" | fzf -0 -1 | awk -F: '{print $1}')"

  if [[ -n $file ]] ; then
     cd $(dirname $file)
     eval xsync
  fi
}

#### fzf + cd ####
# fd - cd to selected directory
# fd() {
#   local dir
#   dir=$(find ${1:-.} -path '*/\.*' -prune \
#                   -o -type d -print 2> /dev/null | fzf +m) &&
#   cd "$dir"
#   eval xsync
# }
# fda - including hidden directories
fda() {
  local dir
  dir=$(find ${1:-.} -type d 2> /dev/null | fzf +m) && cd "$dir"
  eval xsync
}
# fdr - cd to selected parent directory
fdr() {
  local declare dirs=()
  get_parent_dirs() {
    if [[ -d "${1}" ]]; then dirs+=("$1"); else return; fi
    if [[ "${1}" == '/' ]]; then
      for _dir in "${dirs[@]}"; do echo $_dir; done
    else
      get_parent_dirs $(dirname "$1")
    fi
  }
  local DIR=$(get_parent_dirs $(realpath "${1:-$PWD}") | fzf-tmux --tac)
  cd "$DIR"
  eval xsync
}

# fdf - cd into the directory of the selected file
fdf() {
  local file
  local dir
  local searchfile
  local searchdir
  local regex
  local maxdepth
  local week
  while getopts ':m:fdxwhL' x; do
      case "$x" in
          m) maxdepth=${OPTARG} ;;
          f) searchfile="1" ;;
          d) searchdir="1" ;;
          x) regex="1" ;;
          w) week="1" ;;
          L) folllow="1" ;;
          h) echo "fdf [-m|maxdepth depth] [-f|searchfile] [-d|searchdir] [-x|regex] [-w|oneweek days]"
             echo "fdf "         # find filename and dirname
             echo "fdf -f "      # find filename
             echo "fdf -d "      # find dirname
             echo "fdf -m 2"     # find maxdepth include filename and dirname
             echo "fdf -m 2 -d " # find maxdepth and only dirname
             echo "fdf -m 2 -f " # find maxdepth and only filename
             return;
      esac
  done
  shift $(( OPTIND - 1 ))
  unset x OPTARG OPTIND

  FD_PREFIX="find"
  [[ -n $regex ]] && FD_PREFIX="$FD_PREFIX -regex "
  [[ -n $searchfile ]] && FD_PREFIX="$FD_PREFIX -type f "
  [[ -n $searchdir  ]] && FD_PREFIX="$FD_PREFIX -type d "
  [[ -n $searchdir  ]] && FD_PREFIX="$FD_PREFIX -type d "
  [[ -n $maxdepth  ]] && FD_PREFIX="$FD_PREFIX -maxdepth $maxdepth "
  [[ -n $folllow  ]] && FD_PREFIX="$FD_PREFIX --follow  "
  [[ -n $week  ]] && FD_PREFIX="$FD_PREFIX --atime 7 "
  file=$($FD_PREFIX | fzf +m -q "$1" --prompt 'Dirs+Files> ' --bind "start:show-header" --header '/ ctrl-o:open ctrl-e:vim / arguments: [-m|maxdepth depth] [-f|searchfile] [-d|searchdir] [-x|regex] [-w|oneweek days] [-L] /'  )

  [ -z "$file" ] && {
    return
  }
  [ -d "$file" ] && {
    cd "$file"
  } || {
    dir=$(dirname "$file") && cd "$dir"
  }
  eval xsync
}

# fdf0 - cd into the directory of the selected file
fdf0() {
  local file
  local dir
  file=$(find | fzf +m -q "$1" --prompt 'All> ' --bind "start:show-header" \
             --header 'CTRL-D: Dirs / CTRL-F: Files / CTRL-T : Dirs + Files / F9: maxdepth=1 / F10: maxdepth=2' \
             --bind 'del:execute(rm -ri {+})' \
             --bind 'ctrl-t:change-prompt(All> )+reload(find -L *)' \
             --bind 'ctrl-d:change-prompt(Dirs> )+reload(find * -type d)' \
             --bind 'f9:change-prompt(Dirs1> )+reload(find * -maxdepth 1 -type d)' \
             --bind 'f10:change-prompt(Dirs2> )+reload(find * -maxdepth 2 -type d)' \
             --bind 'ctrl-f:change-prompt(Files> )+reload(find * -type f)')
  [ -z "$file" ] && {
    return
  }
  [ -d "$file" ] && {
    cd "$file"
  } || {
    dir=$(dirname "$file") && cd "$dir"
  }
  eval xsync
}

# fdf1 - cd into the directory of the selected file
fdf1() {
  local file
  local dir
  local sorttime
  local sortsize
  local sortreverse
  while getopts ':tsrdh' x; do
      case "$x" in
          t) sorttime="1" ;;
          s) sortsize="1" ;;
          r) sortreverse="1" ;;
          d) jumpdir="1" ;;
          h) echo "fdf1 -t|sorttime -s|sortsize -r|sortreverse -d|jumpdir otherwise edit with vim"
             echo "fdf1 "       # sorttime older first
             echo "fdf1 -t "    # sorttime size
             echo "fdf1 -s "    # sortsize
             echo "fdf1 -t -r " # sorttime
             echo "fdf1 -s -r " # sorttime
             return;
      esac
  done
  shift $(( OPTIND - 1 ))
  unset x OPTARG OPTIND

  SORT_PREFIX="sort"
  [[ -n $sortreverse ]] && SORT_PREFIX="$SORT_PREFIX -r "
  if [[ -n $sorttime ]] ; then
    file=$(find -type f -printf '%T+ %p\n' | $SORT_PREFIX  | awk '{print $2}' | grep -v -e ".svn" -e ".git" -e ".github" | fzf +m -q "$1" --preview 'ls -hl {} ; ls -l {} ; stat {}')
    if [[ -n $file ]]; then
      if [[ -n $jumpdir ]] ; then
        dir=$(dirname "$file") && cd $dir
      else
        vim $file
      fi
      return;
    fi
  fi

  if [[ -n $sortsize ]] ; then
    file=$(find -type f -printf "%12s\t%p\n"  | $SORT_PREFIX -k1 -n | awk '{print $2}' | grep -v -e ".svn" -e ".git" -e ".github" | fzf +m -q "$1" --preview 'ls -hl {} ; stat {}')
    if [[ -n $file ]]; then
      if [[ -n $jumpdir ]] ; then
        dir=$(dirname "$file") && cd $dir
      else
        vim $file
      fi
      return;
    fi
  fi

  file=$(find -type f -printf '%T+ %p\n' | $SORT_PREFIX  | awk '{print $2}' | grep -v -e ".svn" -e ".git" -e ".github" | fzf +m -q "$1" --preview 'ls -hl {} ; ls -l {} ; stat {}')
  if [[ -n $file ]]; then
    if [[ -n $jumpdir ]] ; then
      dir=$(dirname "$file") && cd $dir
    else
      vim $file
    fi
  fi

  eval xsync
}

# fdf - cd into the directory of the selected file
fdf2() {
  local file
  local searchfile
  local searchdir
  local linkpath
  local hiddern
  while getopts ':m:fdlHh' x; do
      case "$x" in
          m) maxdepth=${OPTARG} ;;
          f) searchfile="1" ;;
          d) searchdir="1" ;;
          l) linkpath="1" ;;
          H) hiddern="1" ;;
          h) echo "fdf2 [-m|maxdepth depth] [-f|searchfile] [-d|searchdir] [-l|linkpath] [-H|hidden]"
             echo "fdf2 "         # find filename and dirname
             echo "fdf2 -f "      # find filename
             echo "fdf2 -d "      # find dirname
             echo "fdf2 -m 2"     # find maxdepth include filename and dirname
             echo "fdf2 -m 2 -d " # find maxdepth and only dirname
             echo "fdf2 -m 2 -f " # find maxdepth and only filename
             echo "fdf2 -l "      # find filename and dirname include linkpath
             echo "fdf2 -H "      # find filename and dirname include hidden
             return;
      esac
  done
  shift $(( OPTIND - 1 ))
  unset x OPTARG OPTIND

  FD_PREFIX="fd"
  [[ -n $searchfile ]] && FD_PREFIX="$FD_PREFIX --type file "
  [[ -n $searchdir ]] && FD_PREFIX="$FD_PREFIX --type directory "
  [[ -n $linkpath ]] && FD_PREFIX="$FD_PREFIX --follow "
  [[ -n $linkpath ]] && FD_PREFIX="$FD_PREFIX --hidden --exclude .git --exclude .svn"
  [[ -n $maxdepth  ]] && FD_PREFIX="$FD_PREFIX -maxdepth $maxdepth "

  local file
  file=$($FD_PREFIX | fzf +m -q "$1" )

  [ -z "$file" ] && {
    return
  }
  [ -d "$file" ] && {
    cd "$file"
  } || {
    dir=$(dirname "$file") && cd "$dir"
  }
  eval xsync
}

# fdp - put selected file to /mnt/hgfs/ftptmp 调到指定文件所在目录
# fdp () {
#   local file
#   local dir
#   file=$(fzf +m -q "$1") && put $file
#   eval xsync
# }

# vgp - put the selected file from /mnt/hgfs/ftptmp 调到指定文件所在目录
# vgp (){
#   local file
#   file="$(ag --nobreak --noheading "$@" | fzf -0 -1 | awk -F: '{print $1}')"

#   if [[ -n $file ]] ; then
#      put $file
#   fi
# }

# ftags - search ctags with preview
# only works if tags-file was generated with --excmd=number
# ftags() {
#   local line
#   [ -e tags ] &&
#   line=$(
#     awk 'BEGIN { FS="\t" } !/^!/ {print toupper($4)"\t"$1"\t"$2"\t"$3}' tags |
#     fzf \
#       --nth=1,2 \
#       --with-nth=2 \
#       --preview-window="50%" \
#       --preview="ccat {3} --color=always | tail -n +\$(echo {4} | tr -d \";\\\"\")"
#   ) && ${EDITOR:-vim} $(cut -f3 <<< "$line") -c "set nocst" \
#                                       -c "silent tag $(cut -f2 <<< "$line")"
# }

ftags() {
     [ -e tags ] || ctags -e -R --languages=C --langmap=C:.h.c --c-kinds=+px
    export PATH=${PATH}:/home/wangfuli/git/fzf-ctags/bin
    fzf-ctags
}

cscope_build(){
    find -L . -iname '*.c' -o -iname '*.cpp' -o -iname '*.h' -o -iname '*.hpp' > cscope.files &&
    sort cscope.files > cscope.files.sorted && mv cscope.files.sorted cscope.files &&
    cscope -kbq -i cscope.files -f cscope.out &&
    ctags -R --fields=+aimSl --c-kinds=+lpx --c++-kinds=+lpx --exclude='.svn' \
    --exclude='.git' --exclude='*.a' --exclude='*.js' --exclude='*.pxd' --exclude='*.pyx' --exclude='*.so' &&
    echo "Done."
}

bind -x '"\C-x\C-y":fzfy'      # fzf + ~/.local/share/yank_history   ==> yank

                             # 1. t (current direcory)
bind -x '"\C-x\C-t":cdm'     # 2. (all noted direcory)
bind -x '"\C-g":fdf'         # 3. (current direcory)
                             # 4. xg (fzf-marks)

                             # 1. r (bash noted command)
bind -x '"\C-x\C-r":chtfzf'  # 2 (networkd noted command)
                             # 3. xp (user noted command)

bind -x '"\C-x\C-f":frg'     # 1.xf (frg grep)
bind -x '"\C-x\C-v":viminfo' # 2.xv (current noted file)
bind -x '"\C-x\C-m":woman'   # 3.xm (current manual + chtfzf/user noted command)
bind -x '"\C-x\C-d":look'    # 4.xd (dict/words)

function pet-select() {
  BUFFER=$(pet search --query "$READLINE_LINE")
  READLINE_LINE=$BUFFER
  READLINE_POINT=${#BUFFER}
}
# bind -x '"\C-x\C-r": pet-select'
bind -x '"\C-t":__fzf_cd__'    # fzf + ubuntu
# bind -m emacs-standard '"\C-e": " \C-b\C-k \C-u`__fzf_select__`\e\C-e\er\C-m\C-y\C-h\e \C-y\ey\C-x\C-x\C-d"'

# CTRL-X-1 - Invoke Readline functions by name
__fzf_readline ()
{
    builtin eval "
        builtin bind ' \
            \"\C-x3\": $(
                builtin bind -X | command fzf +s +m --toggle-sort=ctrl-r
            ) \
        '
    "
}

builtin bind -x '"\C-x2": __fzf_readline';
builtin bind '"\C-x1": "\C-x2\C-x3"'

# export FZF_DEFAULT_COMMAND='fd'
export FZF_COMPLETION_TRIGGER='\\'
# export FZF_TMUX=1
export FZF_TMUX_HEIGHT='80%'
# export fzf_preview_cmd='[[ $(file --mime {}) =~ binary ]] && echo {} is a binary file || (bat --color=always || ccat --color=always {} || highlight -O ansi -l {} || cat {}) 2> /dev/null | head -500'


# bat
[[ -x $(command -v bat) ]] && { alias cat="bat"; alias more="bat";  export MANPAGER="sh -c 'col -bx | bat -p -l man'";  }
# V some command output; like git diff;svn diff; ls;
V() { "$@" | view - ; } # Quick way to view files in vim

# find fd ag for filename, end preivew or edit it
filef() { "$@" | awk '{print $NF}' | fzf ; }   # Quick way to view files in fzf preview

# grep rg with line number
rgf ()  {
rm -f /tmp/rg-fzf-{r,f}
RG_PREFIX="$@"
"$@" | fzf --ansi --disabled --query "$INITIAL_QUERY" \
    --bind "start:reload($RG_PREFIX )+unbind(ctrl-r)" \
    --bind "change:reload:sleep 0.1; $RG_PREFIX  || true" \
    --bind "ctrl-f:unbind(change,ctrl-f)+change-prompt(2. fzf> )+enable-search+rebind(ctrl-r)+transform-query(echo {q} > /tmp/rg-fzf-r; cat /tmp/rg-fzf-f)" \
    --bind "ctrl-r:unbind(ctrl-r)+change-prompt(1. grep> )+disable-search+reload($RG_PREFIX || true)+rebind(change,ctrl-f)+transform-query(echo {q} > /tmp/rg-fzf-f; cat /tmp/rg-fzf-r)" \
    --color "hl:-1:underline,hl+:-1:underline:reverse" \
    --prompt '1. grep> ' \
    --delimiter : \
    --header '╱ CTRL-R (ripgrep mode) ╱ CTRL-F (fzf mode) ╱' \
    --preview='bat -n --color=always --style=numbers,changes,header --highlight-line {2} {1}' \
    --preview-window 'right,45%,+{2}+1/3,~1' \
    --bind 'enter:become(vim {1} +{2})' \
    --bind "ctrl-o:execute(open {1})" \
    --bind "ctrl-e:execute(vim {1} +{2})"
}
#### input revsion -> preview difference; end view it ####
# git log --oneline
# git reflog
# git stash list
# git tag
gitf(){
  revsion=$($@ | fzf --ansi  --preview "echo {} | cut -d' ' -f1 | xargs -I{} git show --color --pretty=format:%b {}")
  [ -z "$revsion" ] && return
  revsion=$(echo $revsion | awk '{print $1}')
  [ -z "$revsion" ] && return
  git show $revsion | view -
  echo "$revsion"
}

#### input [filename], end view it  ####
svn_diff(){ svn diff "$@"      | view -; }
git_diff(){ git diff -w "$@" | view -; }
#### input [filename] -> preview difference ####
# git ls-files --deleted  # deleted files
# git ls-files --modified # modified and deleted files
# git status --short .    # current directory
# git status --short      # root directory
gitd(){
"$@" | fzf -m --print0 --preview "git diff -- {-1} | delta"
}

#### input [filename] -> preview difference; end view it ####
gitview(){
  revsion=$(git log --oneline "$@" | fzf --ansi  --preview "echo {} | cut -d' ' -f1 | xargs -I{} git show --color --pretty=format:%b {}")
  [ -z "$revsion" ] && return
  revsion=$(echo $revsion | awk '{print $1}')
  [ -z "$revsion" ] && return
  git show $revsion | view -
  echo "$revsion"
}

cdf(){
  local file
  file=$("$@"| fzf)

  [ -z "$file" ] && {
    return
  }
  file=$(echo $file | awk '{print $NF}')
  [ -d "$file" ] && {
    cd "$file"
  } || {
    dir=$(dirname "$file") && cd "$dir"
  }
  eval xsync
}

#  ~/.fzf-marks
#  ~/.config/fzf-bookmarks/bookmarks
cdm(){
  local cdm_marks cdm_bookmarks cdm_cdmmarks cdm_add_bookmark cdm_edit_bookmark
  while getopts 'mbiaeh' x; do
      case "$x" in
        m) cdm_marks=1 ;;
        b) cdm_bookmarks=1 ;;
        i) cdm_cdmmarks=1 ;;
        a) cdm_add_bookmark=1 ;;
        e) cdm_edit_bookmark=1 ;;
        h) echo "cdm [-m|fzf-marks] [-b|fzf-bookmarks] [-i|fzf-cdmmarks] | [-a|append] [-e|edit]"
           echo "1. -m/-b/-i jump; 2. [-m/-b/-i]+ -a append; 3. -e edit"
           echo "cdm -m [-a] " # find directory in fzf-marks    ; -a add to ~/.fzf-marks
           echo "cdm -b [-a] " # find directory in fzf-bookmarks; -a add to ~/.config/fzf-bookmarks/bookmarks
           echo "cdm -i [-a] " # find directory in fzf-cdmmarks ; -a add to ~/.cdm
           echo "cdm -e      " # edit ~/.config/fzf-bookmarks/bookmarks ~/.fzf-marks ~/.cdm
           return 0
      esac
  done
  shift $(( OPTIND - 1 ))
  unset x OPTARG OPTIND

  [ "$cdm_edit_bookmark" = "1" ] && {
    vim ~/.config/fzf-bookmarks/bookmarks ~/.fzf-marks ~/.cdm
    return 0
  }
  
  [ "$cdm_add_bookmark" = "1" ] && {
    [ "$cdm_marks" = "1" ] && {
      mark "$@" "$(pwd)"
    }
    [ "$cdm_bookmarks" = "1" ] && {
      fzf-bookmarks -a "$@" "$(pwd)"
    }
    [ "$cdm_cdmmarks" = "1" ] && {
      echo -e "$@ \t $(pwd)" >> ~/.cdm
    }
    return 0
  }
  [ "$cdm_marks" = "1" ] && {
    cdf cat ~/.fzf-marks
    return 0
  }
  [ "$cdm_bookmarks" = "1" ] && {
    cdf cat ~/.config/fzf-bookmarks/bookmarks
    return 0
  }
  [ "$cdm_cdmmarks" = "1" ] && {
   cdf cat ~/.cdm
    return 0
  }
  cat ~/.cdm | awk '{ print "cdm          \t " $0 }' > /tmp/cdfm.tmp
  cat ~/.config/fzf-bookmarks/bookmarks | awk '{ print "fzf-bookmarks\t " $0 }' >> /tmp/cdfm.tmp
  cat ~/.fzf-marks | awk '{ print "fzf-marks    \t " $0 }' >> /tmp/cdfm.tmp
  cdf cat /tmp/cdfm.tmp
  return 0
}

cdfm(){
  touch ~/.cdm
  [ -n $1 ] && {
    [ "$1" = "1" ] && {
      [ -f ~/.fzf-marks ] && { cdf cat ~/.fzf-marks; return; }
    }
    [ "$1" = "2" ] && {
      [ -f ~/.config/fzf-bookmarks/bookmarks ] && { cdf cat ~/.config/fzf-bookmarks/bookmarks; return; }
    }
    [ "$1" = "a" ] && {
      cdf cat ~/.cdm  ~/.fzf-marks ~/.config/fzf-bookmarks/bookmarks
    }
  } || {
  cdf cat ~/.cdm
  }
}

cdmf(){
  touch ~/.cdm
  [ -n $1 ] && {
    [ "$1" = "1" ] && {
      [ -f ~/.fzf-marks ] && { cdf cat ~/.fzf-marks; return; }
    }
    [ "$1" = "2" ] && {
      [ -f ~/.config/fzf-bookmarks/bookmarks ] && { cdf cat ~/.config/fzf-bookmarks/bookmarks; return; }
    }
    [ "$1" = "a" ] && {
      cdf cat ~/.cdm  ~/.fzf-marks ~/.config/fzf-bookmarks/bookmarks
    }
  } || {
  cdf cat ~/.cdm
  }
}

# Usage:
# f cd (hit enter, choose path)
# f cat (hit enter, choose files)
# f vim (hit enter, choose files)
# f vlc (hit enter, choose files)
fzff() {
    # Store the arguments from fzf
    IFS=$'\n' arguments=($(fzf --query="$2" --multi))

    # If no arguments passed (e.g. if Esc pressed), return to terminal
    if [ -z "${arguments}" ]; then
        return 1
    fi

    # We want the command to show up in our bash history, so write the shell's
    # active history to ~/.bash_history. Then we'll also add the command from
    # fzf, then we'll load it all back into the shell's active history
    history -w

    # RUN THE COMMANDS ########################################################
    # The cd command has no effect when run as background, and doesn't show up
    # as a job the can be brought to the foreground. So we make sure not to add
    # a '&' (more programs can be added separated by a '|')
    if ! [[ $1 =~ ^(cd)$ ]]; then
        $1 "${arguments[@]}" &
        
    else
        # $1 "${arguments[@]}"
          arguments[0]=$(echo ${arguments[0]} | awk '{print $NF}')
          [ -d "${arguments[0]}" ] && {
            cd "${arguments[0]}"
          } || {
            dir=$(dirname "${arguments[0]}") && cd "$dir"
          }
          return 0
    fi

    # If the program is not on the list of GUIs (e.g. vim, cat, etc.) bring it
    # to foreground so we can see the output. Also put cd on this list
    # otherwise there will be errors)
    if ! [[ $1 =~ ^(cd|zathura|vlc|eog|kolourpaint)$ ]]; then
        fg %%
    fi

    # ADD A REPEATABLE COMMAND TO THE BASH HISTORY ############################
    # Store the arguments in a temporary file for sanitising before being
    # entered into bash history
    : >/tmp/fzf_tmp
    for file in ${arguments[@]}; do
        echo $file >>/tmp/fzf_tmp
    done

    # Put all input arguments on one line and sanitise the command such that
    # spaces and parentheses are properly escaped. More sanitisation
    # substitutions can be added if needed
    sed -i 's/\n//g; s/ /\\ /g; s/(/\\(/; s/)/\\)/' /tmp/fzf_tmp

    # If the program is on the GUI list add a '&' to the command history
    if [[ $1 =~ ^(zathura|vlc|eog|kolourpaint)$ ]]; then
        sed -i '${s/$/ \&/}' /tmp/fzf_tmp
    fi

    # Grab the sanitised arguments
    arguments=$(cat /tmp/fzf_tmp)

    # Add the command with the sanitised arguments to our .bash_history
    echo ${1} ${arguments} >>~/.bash_history

    # Reload the ~/.bash_history into the shell's active history
    # history -r

    # Clean up temporary variables
    echo >/tmp/fzf_tmp
}

[[ -x $(command -v bat) ]] && [[ -x $(command -v fzf) ]] && alias preview="fzf --preview 'bat --color \"always\" {}'"

#### fzf + preview ####
fzfp() {
fzf --preview '[[ $(file --mime {}) =~ binary ]] && echo {} is a binary file || (bat --style=numbers --color=always{} || rougify {}  || highlight -O ansi -l {} || coderay {} || cat {}) 2> /dev/null | head -500'
}
alias tt='fzf --preview '"'"'[[ $(file --mime {}) =~ binary ]] && echo {} is a binary file || (bat --style=numbers --color=always{} || rougify {}  || highlight -O ansi -l {} || coderay {} || cat {}) 2> /dev/null | head -500'"'"

fzfk() {
  cat /usr/share/dict/words | fzf -e  --query "$@ "
}
alias fzfy='ag -g "" -f ~/.local/share/yank_history | fzf -m --bind "enter:execute(vim {})" --bind "ctrl-e:execute(vim {})" --bind "ctrl-a:select-all" --preview "bat --style=numbers --color=always {} " '

alias tmp='find -L /ftptmp -maxdepth 2 -name "*tmp*" -o -name "*diff*" | fzf '

#### fzf + tmux ####
# tmuxs [FUZZY PATTERN] - Select selected tmux session
#   - Bypass fuzzy finder if there's only one match (--select-1)
#   - Exit if there's no match (--exit-0)
tmuxs() {
  local session
  session=$(tmux list-sessions -F "#{session_name}" | \
    fzf --query="$1" --select-1 --exit-0) &&
  tmux switch-client -t "$session"
}

# tmuxw [FUZZY PATTERN] - Select selected tmux windows in self-session
tmuxw() {
  local index name
  read -r index name <<< $(tmux list-windows -F "#{window_index} #{window_name}" | \
    fzf --query="$1" --select-1 --exit-0)
  [ -n "$index" ] && tmux select-window -t ":=$index"
}

# tmuxw [FUZZY PATTERN] - Select selected tmux windows in all-session
tmuxx() {
local session index name

read -r ses1 ses2 ses3 <<< $(tmux ls -F "#{session_name}")

read -r session index name <<< $( (
tmux list-windows -F "#{session_name} #{window_index} #{window_name}" -t $ses1;
tmux list-windows -F "#{session_name} #{window_index} #{window_name}" -t $ses2;
tmux list-windows -F "#{session_name} #{window_index} #{window_name}" -t $ses2;
) | fzf --query="$1" --select-1 --exit-0 )

[ -n "$session" ] && [ -n "$index" ] && tmux switch-client -t "$session" && tmux select-window -t ":=$index"
}

# tmuxp - switch pane (@george-b)  # bind-key 0 run "tmux split-window -p 40 'bash -ci ftpane'"
tmuxp() {
  local panes current_window current_pane target target_window target_pane
  panes=$(tmux list-panes -s -F '#I:#P - #{pane_current_path} #{pane_current_command}')
  current_pane=$(tmux display-message -p '#I:#P')
  current_window=$(tmux display-message -p '#I')

  target=$(echo "$panes" | grep -v "$current_pane" | fzf +m --reverse) || return

  target_window=$(echo $target | awk 'BEGIN{FS=":|-"} {print$1}')
  target_pane=$(echo $target | awk 'BEGIN{FS=":|-"} {print$2}' | cut -c 1)

  if [[ $current_window -eq $target_window ]]; then
    tmux select-pane -t ${target_window}.${target_pane}
  else
    tmux select-pane -t ${target_window}.${target_pane} &&
    tmux select-window -t $target_window
  fi
}

#### fzf + history ####
# fh - repeat history
fh() {
  print -z $( ([ -n "$ZSH_NAME" ] && fc -l 1 || history) | fzf +s --tac | sed -E 's/ *[0-9]*\*? *//' | sed -E 's/\\/\\\\/g')
}

#### fzf + ps + kill ####
# fkill - kill process
fkill() {
  local pid
  pid=$(ps -ef | sed 1d | fzf -m | awk '{print $2}')

  if [ "x$pid" != "x" ]
  then
    echo $pid | xargs kill -${1:-9}
  fi
}
# fkill - kill processes - list only the ones you can kill. Modified the earlier script.
fkill() {
    local pid
    if [ "$UID" != "0" ]; then
        pid=$(ps -f -u $UID | sed 1d | fzf -m | awk '{print $2}')
    else
        pid=$(ps -ef | sed 1d | fzf -m | awk '{print $2}')
    fi

    if [ "x$pid" != "x" ]
    then
        echo $pid | xargs kill -${1:-9}
    fi
}


fman() {
    man -k . | fzf -q "$1" --prompt='man> '  --preview $'echo {} | tr -d \'()\' | awk \'{printf "%s ", $2} {print $1}\' | xargs -r man' | tr -d '()' | awk '{printf "%s ", $2} {print $1}' | xargs -r man
}


inorun() (
  # Run command whenever a given file or a file
  # in the given directory changes.
  # inorun <file> <cmd>...
  file="$1"
  shift
  cmd="$@"
  # Run the command once when we start.
  eval "$cmd"
  while true; do \
    eval "$cmd"
    inotifywait -qre close_write "$file"
  done
)

runn() {
  n="$1"
  shift
  i=0
  while [ "$i" -lt "$n" ]; do
      if ! $*; then
        echo "FAIL i = $i"
        break
      fi
      i="$(($i + 1))"
  done
}

testprogs() (
  for f in "$@"; do
    "./$f" &>/dev/null
    if [ "$?" != 0 ]; then
      echo "$f"
    fi
  done
)

export FZF_CTRL_T_OPTS=" \
  --header ':: ENTER (paste selected files and dirs onto command-line)'"
export FZF_CTRL_R_OPTS=" \
  --header ':: CTRL-Y (copy command into clipboard)'"
export FZF_ALT_C_OPTS=" \
  --header ':: ENTER (cd into the selected dir)'"

# fzf-header="(ctrl-\\: jump) (ctrl-/: toggle-preview) (f1: toggle-help)  (f2: toggle-preview)
# (ctrl-a:select-all) (ctrl-d:deselect-all) (ctrl-t:select-to-top) (ctrl-b:select-to-bottom)
# (tab:select-down) (stab:select-up) (ctrl-n:next-selected) (ctrl-p:prev-selected)
# (ctrl-d:half-page-down) (ctrl-u:half-page-up) (gpup:page-up) (pgdown:page-down) (up:up) (down:down)
# (alt-up:page-up) (alt-down:page-down) (shift-up:up) (shift-down:down)
# "

# defaultHeader="f1 → default, f2 → editor, f3 → clipboard, f4 → terminal, alt+shift+d → delete"
# unset FZF_DEFAULT_COMMAND  Linux: --bind="ctrl-o:execute:xdg-open {}"  --bind="ctrl-o:become: cd $(dirname {})"
export FZF_DEFAULT_OPTS='--no-height --no-reverse --multi --ansi --cycle
--bind "ctrl-a:select-all"
--bind "ctrl-d:deselect-all"
--bind "ctrl-n:next-selected,ctrl-p:prev-selected"
--bind "ctrl-d:half-page-down" --bind="ctrl-u:half-page-up"
--bind "alt-up:preview-page-up,alt-down:preview-page-down"
--bind "ctrl-y:execute-silent(echo {} | pbcopy)"
--walker "file,dir,hidden,follow" --walker-skip=".git,.github,.svn,node_modules,target"
--preview "preview {}"
--preview-window hidden
--bind "ctrl-/:toggle-preview"
--bind "f2:toggle-preview"
--bind "focus:transform-preview-label:echo [ {} ]"
--bind "start:hide-header"
--bind "ctrl-o:execute(cygstart {})"
--bind "ctrl-e:execute(vim {} < /dev/tty > /dev/tty 2>&1)"
--bind "ctrl-\\:change-header(Type jump label)+jump,jump-cancel:change-header:Jump cancelled"
--highlight-line --color gutter:-1,selected-bg:238,selected-fg:146,current-fg:189 --marker ▏ --pointer ▌ --prompt ▌'


fzf_my_header='------------------------------------ (keystroke:my binding) ------------------------------------
(ctrl-\\: jump)         (f1: toggle-help)     (f2: toggle-preview)   (ctrl-/: toggle-preview)
(ctrl-a:select-all)     (ctrl-d:deselect-all) (ctrl-t:select-to-top) (ctrl-b:select-to-bottom)
(tab:select-down)       (stab:select-up)      (ctrl-n:next-selected) (ctrl-p:prev-selected)
(ctrl-d:half-page-down) (ctrl-u:half-page-up) (gpup:page-up)         (pgdn:page-down)  (up:up)     (down:down)
(alt-up:page-up)        (alt-down:page-down)  (shift-up:up)          (shift-down:down) (ctrl-j:up) (ctrl-k:down)
(ctrl-l:clear-screen)   (ctrl-e:vim edit)     (ctrl-o:cygstart open)  # vim or cygstart | xdg-open
CTRL-/|F2 toggle preview window; F1 toggle my help; ? toggle fzf help'

export FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS --header \"$fzf_my_header\" --bind 'f1:toggle-header'"

echo "------------------------------------ (keystroke:default binding) ------------------------------------
------------------------------------ exit          || ---------------------|-------- layout
abort                | ctrl-c  ctrl-g  ctrl-q  esc || offset-down          |similar to CTRL-E of Vim)
accept               | enter   double-click        || offset-up            |similar to CTRL-Y of Vim)
---------------------|--------- readline           || ---------------------|-------- preview
backward-char        | ctrl-b  left                || preview-down         |shift-down
forward-char         | ctrl-f  right               || preview-up           |shift-up
backward-delete-char | ctrl-h  bspace              || preview-page-down    |alt-down
beginning-of-line    | ctrl-a  home                || preview-page-up      |alt-up
end-of-line          | ctrl-e  end                 || ---------------------|-------- history
delete-char          |         del                 || next-history         |(ctrl-n on --history)
delete-char/eof      | ctrl-d                      || prev-history         |(ctrl-p on --history)
clear-screen         | ctrl-l                      || ---------------------|-------- marker
unix-line-discard    | ctrl-u                      || deselect-all         |ctrl-d  #
unix-word-rubout     | ctrl-w                      || select-all           |ctrl-a  #
---------------------|--------- layout             || toggle+up            |btab    (shift-tab)
down                 |ctrl-j  ctrl-n  down         || toggle+down          |ctrl-i  (tab)
up                   |ctrl-k  ctrl-p  up           ||
page-down            |pgdn                         ||
page-up              |pgup                         ||
------------------------------------ (search:fuzzy-match) ------------------------------------
------------------------------------ extended-search mode (Search syntax)
Token       Match type                   Description
sbtrkt      fuzzy-match                  匹配sbtrkt     fuzzy
^music      prefix-exact-match           以music开头    ^
.mp3$       suffix-exact-match           以.mp3结尾     $
'wild       exact-match(quoted)          精确包含wild   '
!fire       inverse-exact-match          不包含fire     !
!.mp3$      inverse-suffix-exact-match   不以.mp3结尾   !*$
^core go$ | rb$ | py$   以core开头,以go或rb或py结尾的   |
switch\                 switch后紧接空格                \
------------------------------------ Fuzzy completion for bash and zsh ------------------------------------
vim **<TAB>;        cd **<TAB>                || fif    find-in-file - usage: fif <searchTerm>
vim ../**<TAB>                                || ftags  browse; ctags-generated index of symbols in the sources
vim ../fzf**<TAB>;  cd ~/github/fzf**<TAB>    || vgd    cd into the directory of the selected file - usage: vgd  [FUZZY PATTERN]
vim ~/**<TAB>                                 || git fuzzy        run git add and git reset by selecting or cursoring
kill -9 **<TAB>                               || ugit / git undo  helps undo git commands. Your damage control git buddy
ssh **<TAB>                                   || git forgit       A utility tool powered by fzf for using git interactively.
telnet **<TAB>                                || export FZF_DEFAULT_OPTS_FILE=~/.fzfrc
unset **<TAB>                                 || ctrl-r     Paste the selected command from history onto the command-line
export **<TAB>                                || ctrl-t     cd into the selected directory
unalias **<TAB>                               || alt-a      Paste the selected files and directories onto the command-line
------------------------------------Key bindings for command-line ------------------------------------
bind -x '\C-x\C-o:fzfo'      # fzf + cygstart                      ==> open
bind -x '\C-x\C-e:fzfv'      # fzf + vim                           ==> vim
bind -x '\C-x\C-v:fzfe'      # fzf + edit                          ==> editor
bind -x '\C-x\C-y:fzfy'      # fzf + ~/.local/share/yank_history   ==> yank
bind -x '\C-x\C-d:fdf'       # fzf + cd                            ==> directory
bind -x '\C-x\C-t:fzftmp'    # fzf + tmp                           ==> tmp
bind -x '\C-x\C-x:fzfcheat'  # fzf + cheat                         ==> cheat
bind -x '\C-x\C-u:eu'        # fzf + ubuntu                        ==> ubuntu
bind -x '\C-x\C-m:fman'      # fzf + manual                        ==> manual
bind -x '\C-x\C-r:ugit'      # fzf + manual                        ==> revert
CTRL-X CTRL-G fzf-marks/fzf-marks.plugin.bash  FZF_MARKS_JUMP='\C-x\C-g'
CTRL-X CTRL-P james-w/fzf-cheatsheets          bind -m emacs-standard -x '\C-x\C-p: fzf-cheatsheets-widget'
CTRL-X CTRL-L cheat-fzf/src/cht-fzf.sh         bind -m emacs-standard -x '\C-x\C-l: chtfzf'
"> /var/tmp/fzf_self_header

export FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS --bind '?:preview: preview /var/tmp/fzf_self_header' "

# z() {
#   [ $# -gt 0 ] && fasd_cd -d "$*" && return 0
#   local dir
#   dir="$(fasd -Rdl "$1" | fzf -1 -0 --no-sort +m)" && cd "${dir}" || return 1
# }

[ -f ~/.fzf/fzf_complete.sh  ] && source ~/.fzf/fzf_complete.sh
# [ -f ~/.fzf/fzf_frg_frgi_frgl.sh  ] && source ~/.fzf/fzf_frg_frgi_frgl.sh

# Fig post block. Keep at the bottom of this file.
# [[ -f "$HOME/.fig/shell/bashrc.post.bash" ]] && builtin source "$HOME/.fig/shell/bashrc.post.bash"


[ -f ~/.vim/bin/zoxide ] && { # https://github.com/ajeetdsouza/zoxide same fzf-marks
eval "$(zoxide init bash)"
alias zq='zoxide query --interactive'
alias za='zoxide add $(pwd)'
alias zr='zoxide remove '

z() {
  local dir=$(
    zoxide query --list --score |
    fzf --height 40% --layout reverse --info inline \
        --nth 2.. --tac --no-sort --query "$*" \
        --bind 'enter:become:echo {2..}'
  ) && cd "$dir"
}
}

alias upnice="sudo renice -n -15 -p $(ps -o pid,cmd | awk '/bash/{print $1}') "
alias dnnice="sudo renice -n 0 -p $(ps -o pid,cmd | awk '/bash/{print $1}') "
alias disable_ipv6="sudo bash -c 'echo 1 > /proc/sys/net/ipv6/conf/all/disable_ipv6'"

# 自动解压：判断文件后缀名并调用相应解压命令
function q-extract() {
    if [ -f $1 ] ; then
        case $1 in
        *.tar.bz2)   tar -xvjf $1    ;;
        *.tar.gz)    tar -xvzf $1    ;;
        *.tar.xz)    tar -xvJf $1    ;;
        *.bz2)       bunzip2 $1     ;;
        *.rar)       rar x $1       ;;
        *.gz)        gunzip $1      ;;
        *.tar)       tar -xvf $1     ;;
        *.tbz2)      tar -xvjf $1    ;;
        *.tgz)       tar -xvzf $1    ;;
        *.zip)       unzip $1       ;;
        *.Z)         uncompress $1  ;;
        *.7z)        7z x $1        ;;
        *)           echo "don't know how to extract '$1'..." ;;
        esac
    else
        echo "'$1' is not a valid file!"
    fi
}

# 自动压缩：判断后缀名并调用相应压缩程序
function q-compress() {
    if [ -n "$1" ] ; then
        FILE=$1
        case $FILE in
        *.tar) shift && tar -cf $FILE $* ;;
        *.tar.bz2) shift && tar -cjf $FILE $* ;;
        *.tar.xz) shift && tar -cJf $FILE $* ;;
        *.tar.gz) shift && tar -czf $FILE $* ;;
        *.tgz) shift && tar -czf $FILE $* ;;
        *.zip) shift && zip $FILE $* ;;
        *.rar) shift && rar $FILE $* ;;
        esac
    else
        echo "usage: q-compress <foo.tar.gz> ./foo ./bar"
    fi
}

# 漂亮的带语法高亮的 color cat ，需要先 pip install pygments
function ccat() {
    local style="monokai"
    if [ $# -eq 0 ]; then
        pygmentize -P style=$style -P tabsize=4 -f terminal256 -g
    else
        for NAME in $@; do
            pygmentize -P style=$style -P tabsize=4 -f terminal256 -g "$NAME"
        done
    fi
}

which drop      >/dev/null 2>&1 && alias f=drop
which floaterm  >/dev/null 2>&1 && alias f=floaterm
alias task='asynctask -f'

# argc-completions
export ARGC_COMPLETIONS_ROOT="/ftptmp/snippets/argc-completions"
export ARGC_COMPLETIONS_PATH="$ARGC_COMPLETIONS_ROOT/completions/linux:$ARGC_COMPLETIONS_ROOT/completions"
export PATH="$ARGC_COMPLETIONS_ROOT/bin:$PATH"
# To add completions for only the specified command, modify next line e.g. argc_scripts=( cargo git )
argc_scripts=( $(ls -p -1 "$ARGC_COMPLETIONS_ROOT/completions/linux" "$ARGC_COMPLETIONS_ROOT/completions" | sed -n 's/\.sh$//p') )
source <(argc --argc-completions bash "${argc_scripts[@]}")

export FZF_COMPLETION_TRIGGER='\'
source ~/.fzf/shell/key-bindings.bash
source ~/.fzf/shell/completion.bash
# FZF_ALT_C_COMMAND= eval "$(fzf --bash)"
_fzf_setup_completion dir ranger tree
_fzf_setup_completion path code bat e np npe npp nppe

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# Amazon Q post block. Keep at the bottom of this file.
[[ -f "${HOME}/.local/share/amazon-q/shell/bashrc.post.bash" ]] && builtin source "${HOME}/.local/share/amazon-q/shell/bashrc.post.bash"
bind -x '"\C-t":fdf0'
