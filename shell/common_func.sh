# Common functions used any operating system

# Set keyboard for US keymap
us_keyboard () {
    setxkbmap -model us -layout us

    if [ "$1" = "think" ]
    then
        xmodmap ~/dot_files/keyboard/thinkpad_xmodmap
    elif [ "$1" = "happy" ]
    then
        xmodmap ~/dot_files/keyboard/hhk_xmodmap
    else
        select type in hhk thinkpad
        do
            xmodmap ~/dot_files/keyboard/${type}_xmodmap
            break
        done
    fi
}

# Set keyboard for Japanese keymap
jp_keyboard () {
    setxkbmap -model jp -layout jp
}

# serching english word at ALC
function alc() {
    if [ $# != 0 ]; then
        w3m "http://eow.alc.co.jp/$*/UTF-8/?ref=sa"
    else
        echo 'usage: alc word'
    fi
}

# open Trash box in GNOME
gomibako () {
    nautilus ${HOME}/.local/share/Trash/files
}

# tmux utilty
nw(){
    local CMDNAME split_opts spawn_command
    CMDNAME=`basename $0`

    while getopts dhvPp:l:t:b: OPT
    do
        case $OPT in
        "d" | "h" | "v" | "P" )
            split_opts="$split_opts -$OPT";;
        "p" | "l" | "t" )
            split_opts="$split_opts -$OPT $OPTARG";;
        * ) echo "Usage: $CMDNAME [-dhvP]" \
                 "[-p percentage|-l size] [-t target-pane] [command]" 1>&2
            return 1;;
        esac
    done
    shift `expr $OPTIND - 1`

    spawn_command=$@
    [[ -z $spawn_command ]] && spawn_command=$SHELL

    tmux split-window `echo -n $split_opts` "cd $PWD ; $spawn_command"
}

_nw(){
    local args
    args=(
        '-d[do not make the new window become the active one]'
        '-h[split horizontally]'
        '-v[split vertically]'
        '-l[define new pane'\''s size]: :_guard "[0-9]#" "numeric value"'
        '-p[define new pane'\''s size in percent]: :_guard "[0-9]#" "numeric value"'
        '-t[choose target pane]: :_guard "[0-9]#" "numeric value"'
        '*:: :_normal'
    )
    _arguments ${args} && return
}

compdef _nw nw
