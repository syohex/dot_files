# Common functions used any operating system

# Set keyboard for US keymap
us_keyboard () {
    setxkbmap -model us -layout us

    if [ "$1" = "think" ]; then
        xmodmap ~/dot_files/keyboard/thinkpad_xmodmap
    elif [ "$1" = "happy" ]; then
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

## utils between Emacs and shell
## Invoke the ``dired'' of current working directory in Emacs buffer.
dired () {
    emacsclient -e "(dired \"${1:-$PWD}\")"
}

## Chdir to the ``default-directory'' of currently opened in Emacs buffer.
cde () {
    EMACS_CWD=`emacsclient -e "
      (if (featurep 'elscreen)
          (elscreen-current-directory)
        (non-elscreen-current-directory))" | sed 's/^"\(.*\)"$/\1/'`

    if [ "$EMACS_CWD" eq "nil" ]; then
        echo "Failed cde"
        exit
    fi

    echo "chdir to $EMACS_CWD"
    cd "$EMACS_CWD"
}

cdp () {
    dir=$(git rev-parse --show-toplevel 2>/dev/null)
    if [ $? -eq 0 ]; then
        CDP=$dir
        cd $dir
    else
        echo "'$PWD' is not git repos"
    fi
}
