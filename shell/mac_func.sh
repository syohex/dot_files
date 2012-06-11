# This file defines functions on Mac OSX

# java setting for using iterm on mac
alias javac='javac -J-Dfile.encoding=UTF-8'
alias java='java -Dfile.encoding=UTF-8'

# for Homebrew at MacOSX
export PATH=/usr/local/share/python:$PATH

export LESS='-r'

firefox_profile_manger () {
    /Applications/Firefox.app/Contents/MacOS/firefox-bin -Profilemanager
}

# open with CotEditor
open_cot () {
    if [ "$1" = "" ]
    then
        "Usage open_cot filename"
    fi

    open -a CotEditor $1
}

launch_emacs () {
    local pwd=$PWD
    cd ${HOME}
    case "$OSTYPE" in
        darwin*)
            open -n /Applications/Emacs.app --args --reverse
            ;;
    esac
    cd ${pwd}
}
