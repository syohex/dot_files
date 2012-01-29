# This file defines functions on Mac OSX

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