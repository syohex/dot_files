# -*- mode:shell-script -*-
# * Light weight cdd
#
# * Original Author
#   - Yuichi Tateno
#

CDD_BASE_DIR=$HOME/.zsh/cdd

if [ "$TMUX" != "" ]; then
    export CDD_PWD_FILE=$CDD_BASE_DIR/tmux.$(echo $TMUX | cut -d ',' -f 3)
    export WINDOW=$(tmux respawn-window 2>&1 > /dev/null | cut -d ':' -f 3)
    if [ "$WINDOW" = "" ]; then
        export WINDOW=$(tmux respawn-window > /dev/null | cut -d ':' -f 3)
    fi
elif [ "$STY" != "" ]; then
    export CDD_PWD_FILE=$CDD_BASE_DIR/screen.$(echo $STY | cut -d '.' -f 1)
else
    export CDD_PWD_FILE=$CDD_BASE_DIR/default
fi

echo "\n" >>! "$CDD_PWD_FILE";

_reg_pwd_screennum() {
    if [ "$STY" != "" ] || [ "$TMUX" != "" ]; then
        if [ ! -f "$CDD_PWD_FILE" ]; then
            echo "\n" >>! "$CDD_PWD_FILE"
        fi
        _reg_cdd_pwd "$WINDOW" "$PWD"
    fi
}

_reg_cdd_pwd() {
    if [ ! -f "$CDD_PWD_FILE" ]; then
        echo "\n" >> "$CDD_PWD_FILE"
        if [ $? = 1 ]; then
            echo "Error: Don't wrote $CDD_PWD_FILE."
            return 1
        fi
    fi
    sed -i".t" -e "/^$1:/d" "$CDD_PWD_FILE"
    sed -i".t" -e "1i \\
$1:$2" "$CDD_PWD_FILE"
}

cdd() {
    local -A arg
    arg=`echo $1|cut -d':' -f1`
    if \grep "^$arg:" "$CDD_PWD_FILE" > /dev/null 2>&1 ;then
        local -A res
        res=`\grep "^$arg:" "$CDD_PWD_FILE"|sed -e "s/^$arg://;"|tr -d "\n"`
        echo "$res"
        cd "$res"
    else
        sed -e '/^$/d' "$CDD_PWD_FILE"
    fi
}

compctl -K _cdd cdd
_cdd() {
    reply=(`\grep --color=none -v "^$WINDOW:" "$CDD_PWD_FILE"`)
}

chpwd() {
    _reg_pwd_screennum
}
