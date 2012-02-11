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

export CDD_PWD_FILE=$HOME/.zsh/cdd_pwd_list

function _reg_pwd_screennum() {
    if [ "$STY" != "" ]
    then
        _reg_cdd_pwd "$WINDOW" "$PWD"
    fi
}

function _reg_cdd_pwd() {
    sed -i".t" -e "/^$1:/d" "$CDD_PWD_FILE"
    sed -i".t" -e "1i \\
$1:$2" "$CDD_PWD_FILE"
}

function cdadd {
    if [ -z "$1" ] || [ -z "$2" ]; then
        echo "Usage: cdd add name path"
        echo "Example: cdd add w ~/myworkspace"
        return 1
    fi

    local -A real_path
    if which realpath >/dev/null 2>&1;then
        real_path=`realpath $2`
    else
        if which perl >/dev/null 2>&1;then
            real_path=`perl -MCwd=realpath -le 'print realpath("$2")'`
        else
            echo "cdd add require realpath or perl"
        fi
    fi
    echo "add $1:$real_path"
    _reg_cdd_pwd "$1" "$real_path"
}

function cddel () {
    if [ -z "$1" ]; then
        echo "Usage: cdd del name"
        return 1
    fi
    sed -i".t" -e "/^$1:/d" "$CDD_PWD_FILE"
}

function cdd () {
    if [ "$1" = "add" ]; then
        shift
        cdadd $@
        return 0
    elif [ "$1" = "del" ]; then
        shift
        cddel $@
        return 0
    fi

    local -A wid
    wid=`echo $1|cut -d':' -f1`
    if \grep "^$wid:" "$CDD_PWD_FILE" > /dev/null 2>&1
    then
        local -A res
        res=`\grep "^$wid:" "$CDD_PWD_FILE"|sed -e "s/^$wid://"|tr -d "\n"`
        echo "$res"
        cd "$res"
    else
        sed -e '/^$/d' "$CDD_PWD_FILE"
    fi
}

compctl -K _cdd cdd
functions _cdd() {
    reply=(`\grep -v "(^$WINDOW:|^$)" "$CDD_PWD_FILE"|sort -k1 -t: -n`)
}

function chpwd() {
    _reg_pwd_screennum
}
