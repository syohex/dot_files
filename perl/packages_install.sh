#!/bin/sh

if ! which perlbrew > /dev/null 2>&1
then
    echo "perlbrew not found!! Please install perlbrew(App::perlbrew)"
fi

if ! which cpanm > /dev/null 2>&1
then
    echo "cpanm not found!!"
    perlbrew install-cpanm
fi

cpanm --interactive App::cpanoutdated

# readline. You should install libreadline6-dev
cpanm Term::ReadLine::Gnu

# for Miyagawa san's pmsetup
cpanm Template
cpanm YAML
cpanm Module::Install
cpanm Module::Install::Repository
cpanm Module::Install::ReadmeFromPod
cpanm Module::Install::ReadmeMarkdownFromPod;
cpanm Module::Install::AuthorTests;

# OOP Programming
cpanm Mouse
cpanm MouseX::Getopt
cpanm Class::Accessor::Lite

# Web Programming
cpanm Plack
cpanm Text::Xslate
cpanm Furl
cpanm XML::RSS::LibXML
cpanm Config::Pit
cpanm IO::Socket::SSL
case "$OSTYPE" in
linux-gnu*)
        cpanm Linux::Inotify2
        ;;
darwin*)
        cpanm Mac::FSEvents
        ;;
esac

# Encode
cpanm Encode::Guess
cpanm Data::Recursive::Encode

# Email
cpanm Email::Sender::Simple
cpanm Net::SMTP::SSL
cpanm Net::IMAP::Client

# AnyEvent
cpanm AnyEvent
