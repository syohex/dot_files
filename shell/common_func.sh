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
        echo "Usage: us_keyboard 'happy' or 'think'"
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
