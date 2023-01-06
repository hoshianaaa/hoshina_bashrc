
alias p=python3
alias b=bash
alias v=vim
alias e=exit
alias c=cd
alias f=firefox
alias cl=clear
alias s=source

cdls ()
{
    \cd "$@" && ls
}
alias cd="cdls"

python_node ()
{
  python3 ~/ros_template_creator/python_node.py $@       
}

launch_template ()
{
  python3 ~/ros_template_creator/launch_template.py $@
}

sudoa ()
{
    \sudo -A "$@"
}
alias sudo="sudoa"

apty ()
{
    \apt -y "$@"
}
alias apt="apty"

function arpscan () {
  sudo -A arp-scan -l -I wlp0s20f3
}

function gp () {
  git add .
  git commit -m "$@"
  git push origin master
}

function gip () {
  git push origin master
}

function gitp () {
  git push origin master
}

function gitpu () {
  git push origin master
}

function gitpush () {
  git push origin master
}

function gitpull () {
  git pull origin master
}

function ga () {
  git add .
}

function gitadd () {
  git add .
}

function gm () {
  git commit -m "$@"
  git push origin master
}

function gam () {
  git add .

  if [ -z "$@" ]; then
    git commit -m "update"
  fi
  if [ -n "$@" ]; then
    git commit -m "$@"
  fi

  git push origin master
  git push origin2 master
}

function gd () {
  git diff
}

function gc () {
  git clone "$@"
}

function cb () {
  catkin build "$@"
}

function d () {
  bash debug
}

function o () {
  bash open
}

function r () {
  bash run
}

function setpath () {
  path="$(pwd)"
  echo "echo $path" > /home/$USER/ask_path
}

function bd () {
  bash build
}

function pf() {
  sudo -A poweroff
}

function reb () {
  sudo -A reboot
}

# ros 

function rl () {
  ros launch "$@"
}

function re () {
  rostopic echo "$@"
}

function rcd () {
  roscd "$@"
}

function rc () {
  roscore
}

function rl () {
  rostopic list
}

function _func_ud() {
    if [ -n "$1" ]; then
        for i in `seq 1 $1`; do
            cd ..
        done
    else
        cd ..
    fi
}

alias ud=_func_ud

function _func_fsize() {
    if [ -n "$1" ]; then
        du -sh $1
    else
        du -sh .
    fi
}

alias fsize=_func_fsize

function _func_mac2ip() {
    # Reference
    # https://stackoverflow.com/questions/13552881/can-i-determine-the-current-ip-from-a-known-mac-address
    ip neighbor | grep $1 | cut -d" " -f1
}

function _func_ip2mac() {
    # Reference
    # https://stackoverflow.com/questions/13552881/can-i-determine-the-current-ip-from-a-known-mac-address
    ip neighbor | grep $1 | cut -d" " -f5   
}

alias mac2ip=_func_mac2ip
alias ip2mac=_func_ip2mac

# For rosaddress command
if [ ! -d ~/.rosaddress ]; then
    pushd ~/ && git clone https://github.com/RyodoTanaka/.rosaddress.git && popd
fi
source ~/.rosaddress/rosaddress.bash

export SUDO_ASKPASS=$HOME/askpass

# super cd command : https://qiita.com/omega999/items/4346ae57c9ff8bb1d50d
## 履歴を記録するcdの再定義（pushdの利用）
function cd {
    if [ -z "$1" ] ; then
        # cd 連打で余計な $DIRSTACK を増やさない
        test "$PWD" != "$HOME" && pushd $HOME > /dev/null
    else
        pushd "$1" > /dev/null
    fi
}

## cdの履歴の中から移動したいディレクトリを選択するcd historyの定義
function cdh {
    local dirnum
    dirs -v | sort -k 2 | uniq -f 1 | sort -n -k 1 | head -n $(( LINES - 3 ))
    read -p "select number: " dirnum
    if [ -z "$dirnum" ] ; then
        echo "$FUNCNAME: Abort." 1>&2
    elif ( echo $dirnum | egrep '^[[:digit:]]+$' > /dev/null ) ; then
        cd "$( echo ${DIRSTACK[$dirnum]} | sed -e "s;^~;$HOME;" )"
    else
        echo "$FUNCNAME: Wrong." 1>&2
    fi
}
##cd履歴を辿るcd backの定義（popdの利用）
function cdb {
    local num=$1 i
    if [ -z "$num" -o "$num" = 1 ] ; then
        popd >/dev/null
        return
    elif [[ "$num" =~ ^[0-9]+$ ]] ; then
        for (( i=0 ; i<num ; i++ )) ; do
            popd >/dev/null
        done
        return
    else
        echo "cdback: argument is invalid." >&2
    fi
}

## カレントディレクトリの中にあるディレクトリを番号指定で移動するcd listの定義
function cdl {
    local -a dirlist opt_f=false
    local i d num=0 dirnum opt opt_f
    while getopts ":f" opt ; do
        case $opt in
            f ) opt_f=true ;;
        esac
    done
    shift $(( OPTIND -1 ))
    dirlist[0]=..
    for d in * ; do test -d "$d" && dirlist[$((++num))]="$d" ; done
    for i in $( seq 0 $num ) ; do printf "%3d %s%b\n" $i "$( $opt_f && echo -n "$PWD/" )${dirlist[$i]}" ; done
    read -p "select number: " dirnum
    if [ -z "$dirnum" ] ; then
        echo "$FUNCNAME: Abort." 1>&2
    elif ( echo $dirnum | egrep '^[[:digit:]]+$' > /dev/null ) ; then
        cd "${dirlist[$dirnum]}"
    else
        echo "$FUNCNAME: Something wrong." 1>&2
    fi
}

cd $(bash ~/ask_path)

function kensaku {
find . -type f -print | xargs grep $@
}
