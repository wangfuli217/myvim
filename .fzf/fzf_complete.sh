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

_taskwarrior_package_list(){
  echo active           # Active tasks (has start date)
  echo all              # All tasks
  echo blocked          # Blocked tasks
  echo blocking         # Blocking tasks
  echo burndown.daily   # Shows a graphical burndown chart, by day
  echo burndown.monthly # Shows a graphical burndown chart, by month
  echo burndown.weekly  # Shows a graphical burndown chart, by week
  echo completed        # Completed tasks
  echo ghistory.annual  # Shows a graphical report of task history, by year
  echo ghistory.monthly # Shows a graphical report of task history, by month
  echo ghistory.weekly  # Shows a report of task history, by year
  echo ghistory.daily   # Shows a report of task history, by month
  echo history.annual   # Shows a report of task history, by year
  echo history.monthly  # Shows a report of task history, by month
  echo history.weekly   # Shows a report of task history, by year
  echo history.daily    # Shows a report of task history, by month
  echo information      # Shows all data and metadata
  echo list             # Most details of tasks
  echo long             # All details of tasks (show annotations,pending only)
  echo ls               # Few details of tasks (pending only)
  echo minimal          # Minimal details of tasks (Reports with waiting tasks)
  echo newest           # Newest tasks (Pending or waiting tasks sorted by entry date)
  echo next             # Most urgent tasks (is pending)
  echo oldest           # Oldest tasks (Pending or waiting tasks sorted by entry date)
  echo overdue          # Overdue tasks (pending or waiting and overdue)
  echo projects         # Shows all project names used
  echo ready            # Most urgent actionable tasks (is pending, unblocked, unscheduled (or scheduled < now))
  echo recurring        # Recurring Tasks
  echo summary          # Shows a report of task status by project
  echo tags             # Shows a list of all tags used
  echo unblocked        # Unblocked tasks
  echo waiting          # Waiting (hidden) tasks
  echo commands         # Shows all the supported commands, with some details of each.
  echo calendar         # Shows a monthly calendar with due tasks marked
  echo columns          # Displays all supported columns and formatting styles
  echo count            # Displays only a count of tasks matching the filter.
  echo export           # Exports all tasks in the JSON format.
  echo help             # Shows the long usage text
  echo ids              # Applies the filter then extracts only the task IDs and presents them as a space-separated list.
  echo uuids            # Applies the filter on all tasks
  echo calc now + 8d
  echo calc eom
  echo diagnostics      # Shows diagnostic information, of the kind needed when reporting a problem
  echo reports          # Lists all supported reports
  echo show all         # Shows all the current settings
  echo stats            # Shows statistics of the tasks defined by the filter
  echo timesheet weeks  # Shows a weekly report of tasks completed and started
  echo undo             # Reverts the most recent action
}


_ftask_add_package_list(){
  echo "due:2016-11-08 scheduled:2016-11-04 wait:november until:2016-11-10"
  echo "due:2016-11-08 scheduled:due-4d     wait:due-7d   until:due+2d"
}

_fzf_complete_task() {
  _fzf_complete --multi --reverse --prompt="task> " -- "$@" < <(
    _taskwarrior_package_list
  )
}

_fzf_complete_taskadd() {
  _fzf_complete --multi --reverse --prompt="taskadd> " -- "$@" < <(
    _ftask_add_package_list
  )
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

_fzf_complete_mklastp() {
  _fzf_complete --multi --reverse --prompt="mklastp> " -- "$@" < <(
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
  _fzf_complete --multi --reverse --prompt="tv> " -- "$@" < <(
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
[ -n "$BASH" ] && complete -F _fzf_complete_mklastp -o default -o bashdefault mklastp
[ -n "$BASH" ] && complete -F _fzf_complete_mksdk   -o default -o bashdefault mksdk
[ -n "$BASH" ] && complete -F _fzf_complete_cdb     -o default -o bashdefault cdb
[ -n "$BASH" ] && complete -F _fzf_complete_cdp     -o default -o bashdefault cdp
[ -n "$BASH" ] && complete -F _fzf_complete_put_pkg -o default -o bashdefault put_pkg
[ -n "$BASH" ] && complete -F _fzf_complete_mkuser -o default -o bashdefault put_pkg
[ -n "$BASH" ] && complete -F _fzf_complete_tv -o default -o bashdefault      tv
[ -n "$BASH" ] && complete -F _fzf_complete_task -o default -o bashdefault    tasks
[ -n "$BASH" ] && complete -F _ftask_add_package_list -o default -o bashdefault ftask-add

###############################################################################
_fzf_run_list(){
  echo vim
  echo bat
  echo bash
  echo put
}

_fzf_complete_run() {
  _fzf_complete --multi --reverse --prompt="cmd> " -- "$@" < <(
    _fzf_run_list
  )
}
[ -n "$BASH" ] && complete -F _fzf_complete_run -o default -o bashdefault fzfr

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

_fzf_cdm_list(){
    echo " -m [-a] " # find directory in fzf-marks    ; -a add to ~/.fzf-marks
    echo " -b [-a] " # find directory in fzf-bookmarks; -a add to ~/.config/fzf-bookmarks/bookmarks
    echo " -i [-a] " # find directory in fzf-cdmmarks ; -a add to ~/.cdm
    echo " -e      " # edit ~/.config/fzf-bookmarks/bookmarks ~/.fzf-marks ~/.cdm
}
_fzf_complete_cdm() {
  _fzf_complete --multi --reverse --prompt="goto> " -- "$@" < <(
    _fzf_cdm_list
  )
}
[ -n "$BASH" ] && complete -F _fzf_complete_cdm -o default -o bashdefault cdm


_fzf_cdfm_list(){
    echo " -1 " # find directory in fzf-marks    ; -a add to ~/.fzf-marks
    echo " -2 " # find directory in fzf-bookmarks; -a add to ~/.config/fzf-bookmarks/bookmarks
    echo " -a " # find directory in fzf-cdmmarks ; -a add to ~/.cdm
}
_fzf_complete_cdfm() {
  _fzf_complete --multi --reverse --prompt="goto> " -- "$@" < <(
    _fzf_cdfm_list
  )
}
[ -n "$BASH" ] && complete -F _fzf_complete_cdfm -o default -o bashdefault cdfm
[ -n "$BASH" ] && complete -F _fzf_complete_cdfm -o default -o bashdefault cdmf


_fzf_filef_list(){
    echo " ls     " # ascii
    echo " ls -r  " # ascii
    echo " ls -t  " # time
    echo " ls -rt " # time
    echo " ls -c  " # ctime
    echo " ls -rc " # ctime
    echo " ls -S  " # size
    echo " ls -rS " # size
    echo " ls -X  " # sort alphabetically by entry extension
    echo " ls -rX " # sort alphabetically by entry extension

    echo " git ls-files                             "  #
    echo " git ls-files --cached                    "  # tracked files                     展示所有 tracked 的文件
    echo " git ls-files --deleted                   "  # deleted files
    echo " git ls-files --modified                  "  # modified and deleted files
    echo " git ls-files --others                    "  # ignored and untracked files       展示所有 untracked 的文件
    echo " git ls-files --others --exclude-standard "  # Show untracked files, not ignored 展示所有忽略的文件
    echo " git ls-files -c -i --exclude-standard    "  # only ignored files
    echo " git ls-files --cached --others --exclude-standard "

    echo " git ls-tree -r --name-only HEAD "
    echo " git ls-tree --name-only HEAD    "

    echo " fd                 " # 所有文件
    echo " fd netfl           " # 简单搜索 -s:--case-sensitive -i:--ignore-case
    echo " fd "string|regex"  " # 正则表达式搜索
    echo " fd "^string"       " # 正则表达式搜索        使用 regex
    echo " fd -g libc.so /usr " # 搜索一个特定的文件名  使用 -g(或 --glob)
    echo " fd -F libc.so /usr " # 搜索一个特定的文件名  使用 -F(或 --fixed-strings)
    echo " fd --extension txt " # 指定扩展名
    echo " fd --max-depth 2   " # 指定搜索深度
    echo " fd -L              " # 遵循符号链接
}

_fzf_complete_filef() {
  _fzf_complete --multi --reverse --prompt="filef> " -- "$@" < <(
    _fzf_filef_list
  )
}

[ -n "$BASH" ] && complete -F _fzf_complete_filef -o default -o bashdefault filef

_fzf_gitf_list(){
echo 'git log --oneline                                           '
echo 'git log --oneline -5                                        '
echo 'git log --oneline master                                    '
echo 'git log --oneline feature                                   '
echo 'git log --oneline --reverse                                 '
echo 'git log --oneline --since="yesterday"                       '
echo 'git log --oneline --since="5 minutes ago"                   '
echo 'git log --oneline --until="5 minutes ago"                   '
echo 'git log --oneline --since="2022-04-22" --until="2022-04-24" '
echo 'git log --oneline --max-count=2                             '

echo ' git log --oneline main         ' # reachable parents from main
echo ' git log --oneline ^main        ' # exclude reachable parents from main
echo ' git log --oneline main..fix    ' # reachable from fix but not main
echo ' git log --oneline main...fix   ' # reachable from fix and main, but not both
echo ' git log --oneline HEAD^@       ' # parents of HEAD
echo ' git log --oneline HEAD^!       ' # HEAD, then excluding parents's ancestors
echo ' git log --oneline HEAD^{:/fix} ' # search previous HEADs matching criteria

echo ' git log --oneline origin/master  ' # branch, remote
echo ' git log --oneline v1.0.0         ' # tag
echo ' git log --oneline master develop ' 
echo ' git log --oneline v2.0..master   ' # reachable from *master* but not *v2.0*
echo ' git log --oneline v2.0...master  ' # reachable from *master* and *v2.0*, but not both

echo ' git log --oneline --grep="fzf" ' # search in commit messages
echo ' git log --oneline -S"fzf"      ' # search in code
echo ' git log --oneline -G"preview*" ' # search in code (regex)
}

_fzf_complete_gitf() {
  _fzf_complete --multi --reverse --prompt="gitf> " -- "$@" < <(
    _fzf_gitf_list
  )
}

[ -n "$BASH" ] && complete -F _fzf_complete_gitf -o default -o bashdefault gitf


###############################################################################

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
