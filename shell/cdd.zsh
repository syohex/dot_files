# -*- mode:shell-script -*-
# * cdd
#  $ cdd WINDOW番号 でその screen の WINDOW 番号へ移動
# するための zsh function
# 他にも cdadd でショートカットの作成、cddel でショートカットの削除とか
#
# * 使い方
# 1.
# .zshrc でなにはともあれ
#  autoload -U compinit
#  compinit
#  source ~/path/cdd  # (cdd はこのファイル) する
# を書く
#
# 2.
# .zshrc などで chpwd フックで _reg_pwd_screennum を呼び出す
#  # 例
#  function chpwd() {
#    _reg_pwd_screennum
#  }
# 3.
# enjoy!
#
# * Q&A
# - なんで cdd という名前？
# -- cd からの type が楽だから。
#
# * FIXME/TODO: 誰か直して
# - compctl という一世代前のコマンドで補完してる。かっこいい補完にしたい。
# - その他リファクタリング
#
# * 備考
#
# BSD, GNU どっちの sed でもうごくようにした BK:
# - GNU は -i "suffix" の場合に "suffix" を処理対象ファイルとみなす (スペースをいれてはいけない)
# - BSD は -i"" の場合に "" を無視して次の引数を suffix として認識してしまう (うえとあわせると常にバックアップをつくることになる)
# - BSD は i\ コマンドのあとに改行が必須 (GNU もこれを解釈できる)
#
# * author
# - Yuichi Tateno
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

function _reg_pwd_screennum() {
    if [ "$STY" != "" ] || [ "$TMUX" != "" ]; then
        if [ ! -f "$CDD_PWD_FILE" ]; then
            echo "\n" >>! "$CDD_PWD_FILE"
        fi
        _reg_cdd_pwd "$WINDOW" "$PWD"
    fi
}

function _reg_cdd_pwd() {
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

function _cdadd {
    if [ -z "$1" ] || [ -z "$2" ]; then
        echo "Usage: cdd add name path"
        echo "Example: cdd add w ~/myworkspace"
        return 1
    fi

    local -A real_path
    real_path=$(perl -MCwd -e 'print Cwd::realpath("$2")');
    echo "add $1:$real_path"
    _reg_cdd_pwd "$1" "$real_path"
}

function _cddel() {
    if [ -z "$1" ]; then
        echo "Usage: cdd del name"
        return 1
    fi
    sed -i".t" -e "/^$1:/d" "$CDD_PWD_FILE"
}

function cdd() {
    if [ "$1" = "add" ]; then
        shift
        _cdadd $@
        return 0
    elif [ "$1" = "del" ]; then
        shift
        _cddel $@
        return 0
    fi

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
functions _cdd() {
    reply=(`\grep --color=none -v "^$WINDOW:" "$CDD_PWD_FILE"`)
}
