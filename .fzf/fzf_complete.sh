_fzf_package_list(){
  echo apmanage             #
  echo cgi-bin              # CONFIG_PACKAGE_cgi-bin=y
  echo checkapp             #
  echo client-monitor       # # CONFIG_PACKAGE_client-monitor is not set
  echo cloud-client         # CONFIG_PACKAGE_cloud-client=y
  echo cloud-rzx            #
  echo configmanage         # CONFIG_PACKAGE_configmanage=y
  echo libcomm_api          # CONFIG_PACKAGE_libcomm_api=y
  echo libconfig_data_api   #
  echo libdev_op_api        # CONFIG_PACKAGE_libdev_op_api=y
  echo libxc_acd_api        # CONFIG_PACKAGE_libxc_acd_api=y
  echo macmanage            # CONFIG_PACKAGE_macmanage=y
  echo openCAPWAP           # CONFIG_PACKAGE_libconfig_data_api=y
  echo systemconf           # CONFIG_PACKAGE_systemconf=y
  echo timertasket          # # CONFIG_PACKAGE_timertasket is not set
  echo xc_acd               # CONFIG_PACKAGE_xc_acd=y
  echo ylmonit              # CONFIG_PACKAGE_ylmonit=y
  echo yllog                # CONFIG_PACKAGE_yllog=y
  echo strace               # CONFIG_PACKAGE_strace=y
  echo socat                # CONFIG_PACKAGE_socat is not set
  echo mac_traffic_monit    #
  echo ylmonitext           # CONFIG_PACKAGE_ylmonitext=y
  echo wide-dhcpv6          # CONFIG_PACKAGE_wide-dhcpv6-client=y; CONFIG_PACKAGE_wide-dhcpv6-control=y; CONFIG_PACKAGE_wide-dhcpv6-relay=y; CONFIG_PACKAGE_wide-dhcpv6-server=y
  echo radvd                # CONFIG_PACKAGE_radvd=y; CONFIG_PACKAGE_radvdump=y
  echo phddns              # CONFIG_PACKAGE_phddns=y
  echo tcpdump             # CONFIG_DEFAULT_tcpdump=y; CONFIG_PACKAGE_tcpdump=y
  echo dhcp-check          # CONFIG_PACKAGE_dhcp-check=y
  echo proftpd             # CONFIG_PACKAGE_proftpd=y
  echo ylwmpd              #
  echo aproaming           # CONFIG_PACKAGE_aproaming=y
  echo devtest             # CONFIG_PACKAGE_devtest=y
  echo resolveip           # CONFIG_PACKAGE_resolveip=y
  echo swctrl              # # CONFIG_PACKAGE_swctrl is not set
  echo owipcalc            # # CONFIG_PACKAGE_owipcalc is not set
  echo maccalc             # # CONFIG_PACKAGE_maccalc is not set
  echo interface-monitor   # CONFIG_PACKAGE_interface-monitor=y
  echo rssileds            # # CONFIG_PACKAGE_rssileds is not set
  echo updatedd            # # CONFIG_PACKAGE_updatedd is not set
  echo producttools        # CONFIG_PACKAGE_producttools=y
  echo timereboot          # CONFIG_PACKAGE_timereboot=y
  echo mac_traffic_monit    # CONFIG_PACKAGE_mac_traffic_monit  is not set
}


_fzf_complete_mklast() {
  _fzf_complete --multi --reverse --prompt="mklast> " -- "$@" < <(
    _fzf_package_list
  )
}

_fzf_complete_mklastv() {
  _fzf_complete --multi --reverse --prompt="mklastv> " -- "$@" < <(
    _fzf_package_list
  )
}

_fzf_complete_mklaste() {
  _fzf_complete --multi --reverse --prompt="mklaste> " -- "$@" < <(
    _fzf_package_list
  )
}

_fzf_complete_mklastq() {
  _fzf_complete --multi --reverse --prompt="mklastq> " -- "$@" < <(
    _fzf_package_list
  )
}

_fzf_complete_mksdk() {
  _fzf_complete --multi --reverse --prompt="mksdk> " -- "$@" < <(
    _fzf_package_list
  )
}

_fzf_complete_cdb() {
  _fzf_complete --multi --reverse --prompt="cdb> " -- "$@" < <(
    _fzf_package_list
  )
}

_fzf_complete_cdp() {
  _fzf_complete --multi --reverse --prompt="cdp> " -- "$@" < <(
    _fzf_package_list
  )
}

_fzf_complete_put_pkg() {
  _fzf_complete --multi --reverse --prompt="put_pkg> " -- "$@" < <(
    _fzf_package_list
  )
}

_fzf_complete_mkuser() {
  _fzf_complete --multi --reverse --prompt="mkuser> " -- "$@" < <(
    _fzf_package_list
  )
}

_fzf_complete_tv() {
  _fzf_complete --multi --reverse --prompt="mklast> " -- "$@" < <(
    tv list-channels
    echo "list-channels"
    echo "update-channels"
    echo "./"
  )
}
[ -n "$BASH" ] && complete -F _fzf_complete_mklast  -o default -o bashdefault mklast
[ -n "$BASH" ] && complete -F _fzf_complete_mklastv -o default -o bashdefault mklastv
[ -n "$BASH" ] && complete -F _fzf_complete_mklaste -o default -o bashdefault mklaste
[ -n "$BASH" ] && complete -F _fzf_complete_mklastq -o default -o bashdefault mklastq
[ -n "$BASH" ] && complete -F _fzf_complete_mksdk   -o default -o bashdefault mksdk
[ -n "$BASH" ] && complete -F _fzf_complete_cdb     -o default -o bashdefault cdb
[ -n "$BASH" ] && complete -F _fzf_complete_cdp     -o default -o bashdefault cdp
[ -n "$BASH" ] && complete -F _fzf_complete_put_pkg -o default -o bashdefault put_pkg
[ -n "$BASH" ] && complete -F _fzf_complete_mkuser -o default -o bashdefault put_pkg
[ -n "$BASH" ] && complete -F _fzf_complete_tv -o default -o bashdefault      tv

_fzf_complete_git() {
    ARGS="$@"
    local branches
    branches=$(git branch -vv --all | sed "s/remotes\/origin\///g" | sed "s/\*/ /g")
    if [[ $ARGS == 'git co'* ]]; then
        _fzf_complete "--reverse --multi" "$@" < <(
            echo $branches
        )
    else
        eval "zle ${fzf_default_completion:-expand-or-complete}"
    fi
}

_fzf_complete_git_post() {
    awk '{print $1}'
}

[ -n "$BASH" ] && complete -F _fzf_complete_git  -o default -o bashdefault git

_fzf_complete_foo() {
  _fzf_complete --multi --reverse --header-lines=3 -- "$@" < <(
    ls -al
  )
}

_fzf_complete_foo_post() {
  awk '{print $NF}'
}

# Old API
_fzf_complete_f() {
  _fzf_complete "+m --multi --prompt \"prompt-f> \"" "$@" < <(
    echo foo
    echo bar
  )
}

# New API
_fzf_complete_g() {
  _fzf_complete +m --multi --prompt "prompt-g> " -- "$@" < <(
    echo foo
    echo bar
  )
}

_fzf_complete_f_post() {
  awk '{print "f" $0 $0}'
}

_fzf_complete_g_post() {
  awk '{print "g" $0 $0}'
}

# Custom fuzzy completion for "doge" command
#   e.g. doge **<TAB>
_fzf_complete_doge() {
  _fzf_complete --multi --reverse --prompt="doge> " -- "$@" < <(
    echo very
    echo wow
    echo such
    echo doge
  )
}

[ -n "$BASH" ] && complete -F _fzf_complete_f   -o default -o bashdefault f
[ -n "$BASH" ] && complete -F _fzf_complete_g   -o default -o bashdefault g
[ -n "$BASH" ] && complete -F _fzf_complete_doge -o default -o bashdefault doge
[ -n "$BASH" ] && complete -F _fzf_complete_foo -o default -o bashdefault foo


_fzf_complete_pacman() {
  _fzf_complete --multi --reverse --prompt="packages> " -- "$@" < <(pacman -Ss | paste -d" " - -)
}

_fzf_complete_pacman_post() {
  awk '{print $1}' | cut -f 2 -d /
}

complete -F _fzf_complete_pacman -o default -o bashdefault pacman
