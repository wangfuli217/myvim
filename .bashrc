# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
    *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

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

alias sourcebash='source ~/.bashrc'
alias sourcetmux='tmux source-file ~/.tmux.conf'

alias tmux_WB_5G03='tmux attach -t WB_5G03'
alias tmux_FAP680M1='tmux attach -t FAP680-M1'

alias resovl='sudo cp /etc/resolv.conf.bak /etc/resolv.conf'

alias makee='make 2>&1 | tee ./makeerror.log | grep error'
alias makew='make 2>&1 | tee ./makewarn.log | grep warning'
alias makes='make -j'nproc' V=1 QUILT=1'
alias makev='make -j1 V=sc'
alias makekclean='make target/linux/clean'
alias makek='make target/linux/compile'
alias makekv='make target/linux/compile -j1 V=scw'
makevv(){
    local output="make.${RANDOM}"
    make -j1 V=scw $@ 2>&1 | tee $output
    echo "vim $output"
}

gitc(){
    [ -d .git ] && return
    git init
    cp /home/wangfuli/git/gitignore/C.gitignore ./.gitignore
    git add *
    git commit -m "init"
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
    local newbin=$(ls -dlt *Build* | head -1 | awk '{print $NF}')
    mv ${newbin}/* $bindir
    rmdir ${newbin}
}

put_ubin(){
  local oldpwd=$(pwd)
  [ -d images ] && {
    newdir=$(ls -dlt images/*Build* | head -n 1 | awk '{print $NF}')
  } || {
    stat *-Buildx*  > /dev/null 2>&1 || { cdproject; [ -d images ] && cd images; }
    newdir=$(ls -dlt *Build* | head -n 1 | awk '{print $NF}')
  }

  echo "$newdir"/*.ubin
  [ "$(uname)" = "Linux" ] && {
    put "$newdir"/*.ubin
  } || {
    cp "$newdir"/*.ubin /ftptmp
  }
  cd ${oldpwd}
}
put_rbin(){
  local oldpwd=$(pwd)
  [ -d images ] && {
    newdir=$(ls -dlt images/*Build* | head -n 1 | awk '{print $NF}')
  } || {
    stat *-Buildx*  > /dev/null 2>&1 || { cdproject; [ -d images ] && cd images; }
    newdir=$(ls -dlt *Build* | head -n 1 | awk '{print $NF}')
  }

  echo "$newdir"/*.rbin
  [ "$(uname)" = "Linux" ] && {
    put "$newdir"/*.rbin
  } || {
    cp "$newdir"/*.rbin /ftptmp
  }
  cd ${oldpwd}
}
put_KF(){
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
put_img(){
  local oldpwd=$(pwd)
  [ -d package ] || { cdqsdk; }
  echo bin/*/openwrt-*-squashfs-root.img
  put bin/*/openwrt-*-squashfs-root.img
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
  cd $(pwd)/source/romfs/
  OLDPWD=${oldpwd}
}

alias cduser=svnuser
svnuser(){
  local oldpwd=$(pwd)
  while ! [ -d .svn ]; do
    cd ../
  done
  cd $(pwd)/source/user/
  OLDPWD=${oldpwd}
}

alias cdproduct=svnproduct
svnproduct(){
  local oldpwd=$(pwd)
  while ! [ -d .svn ]; do
    cd ../
  done
  cd $(pwd)/product
  OLDPWD=${oldpwd}
}

alias cdroot=svnroot
svnroot(){
  local oldpwd=$(pwd)
  while ! [ -d .svn ]; do
    cd ../
  done
  OLDPWD=${oldpwd}
}

alias cdqsdk=svnqsdk
svnqsdk(){
  local oldpwd=$(pwd)
  while ! [ -d .svn ]; do
    cd ../
  done
  cd $(pwd)/qsdk
  OLDPWD=${oldpwd}
}

alias project='export __project=$(pwd)'
cdproject(){
  local oldpwd=$(pwd)
  [ -n "$__project" ] && cd ${__project} || {
    cdproduct
    local project_var=$(ls -dlt * | head -n 1 | awk '{print $NF}')
    [ -n "project_var" ] && {
      cd $(pwd)/$project_var;
    }
  }
  OLDPWD=${oldpwd}
}

mklast() {
  local oldpwd=$(pwd)
  [ -d build_dir ] || cdqsdk
  [ -n "$1" ] && { __last_cdp="$1"; __last_cdb="$1"; }
  [ -n "$__last_cdp" ] && make package/$__last_cdp/{clean,compile}
  cd $oldpwd
}

mklastv(){
  local oldpwd=$(pwd)
  [ -d build_dir ] || cdqsdk;
  [ -n "$1" ] && { __last_cdp="$1"; __last_cdb="$1"; }
  [ -n "$__last_cdp" ] && make package/$__last_cdp/{clean,compile} -j1 V=s
  cd $oldpwd
}

mkall(){
  local oldpwd=$(pwd)
  [ -f mkall.sh ] && {
    project;
    [ "$#" = "0" ] && { ./mkall.sh zh; export PRODUCT_DIR=$(basename $(pwd)); } || { ./mkall.sh $@; export PRODUCT_DIR=$(basename $(pwd)); };
    cd ${oldpwd};
    return;
  }

  [ -n "$__project" ] && {
    cd ${__project};
    [ "$#" = "0" ] && { ./mkall.sh zh; export PRODUCT_DIR=$(basename $(pwd)); } || { ./mkall.sh $@; export PRODUCT_DIR=$(basename $(pwd)); };
    cd ${oldpwd};
    return;
  }

  cdproduct
  local project_var=$(ls -dlt * | head -n 1 | awk '{print $NF}')
  [ -n "project_var" ] && {
    cd $(pwd)/$project_var;
    project;
    [ "$#" = "0" ] && { ./mkall.sh zh; export PRODUCT_DIR=$(basename $(pwd)); } || { ./mkall.sh $@; export PRODUCT_DIR=$(basename $(pwd)); };
  }
  cd ${oldpwd};
}
alias mkall0='mkall zh 0'

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
cdb(){
  local oldpwd=$(pwd)
  [ -d build_dir ] || { svnqsdk; }

  local cdb_var="$1"
  [ "$#" = "0" ] && [ -n "$__last_cdb" ] && { cdb_var=$__last_cdb; }
  [ -z "$cdb_var" ] && { cd build_dir; return; }

  cd build_dir/target-*/${cdb_var}*
  export __last_cdb="$cdb_var"
  export __last_cdp="$cdb_var"
  OLDPWD=${oldpwd}
}
# default cd to last package feeds
cdp(){
  local oldpwd=$(pwd)
  [ -d package ] || { svnqsdk; }

  local cdp_var="$1"
  [ "$#" = "0" ] && [ -n "$__last_cdp" ] && { cdp_var=$__last_cdp; }
  [ -z "$cdp_var" ] && { cd package; return; }

  cd package
  cd $(find -L -maxdepth 4 -type d -name "*$cdp_var*" | head -n 1)
  export __last_cdp="$cdp_var"
  export __last_cdb="$cdp_var"
  ( [ -d src ] && { cd src; eval xsync; } )
  OLDPWD=${oldpwd}
}

cdrootfs(){
  local oldpwd=$(pwd)
  [ -d build_dir ] || { svnqsdk; }
  cd build_dir/target-*/linux-*/base-files/ipkg-*/base-files
  OLDPWD=${oldpwd}
}

#
# cdp(){
# local t=$(pwd)
# cd $__old_dir
# export __old_dir=${t}
# }

alias cdftp='cd /mnt/hgfs/ftptmp/'
#[c]
alias indentwfl='indent -kr -i4 -ts4 -sob -ss -sc -npsl -pcs -bs --ignore-newlines -l200 -nut -npro -brf '
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

ntpdate -s time.nist.gov

alias tt0='tmux select-window -t :=10'
alias tt1='tmux select-window -t :=11'
alias tt2='tmux select-window -t :=12'
alias tt3='tmux select-window -t :=13'
alias tt4='tmux select-window -t :=14'
alias tt5='tmux select-window -t :=15'
alias tt6='tmux select-window -t :=16'
alias tt7='tmux select-window -t :=17'
alias tt8='tmux select-window -t :=18'
alias tt9='tmux select-window -t :=19'

alias tt680='tmux switch -t FAP680-M1'
alias tt5G03='tmux switch -t WB_5G03'
alias tttmp='tmux switch -t tmp'
alias ttplast='tmux rotate-window; tmux resize-pane -Z'

alias xsync='pwd > /mnt/hgfs/ftptmp/xsync'


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
repeat_ok()  { while :; do $@ && return; done }
# Syntax: "repeat_err [command]"
repeat_err() { while :; do $@ || return; done }
# Syntax: "repeat_sleep <timeout> <command>"
repeat_sleep() { timeout=$1; shift; while :; do $@ && return; sleep $timeout; done }    # 加入延时