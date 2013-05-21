#!perl
use strict;
use warnings;

# Usage: % cat module_lists.pl | cpanm

my $file_notify = do {
    if ($^O eq 'linux') {
        'Linux::Inotify2';
    } elsif ($^O eq 'darwin') {
        'Mac::FSEvents';
    }
};

my @modules = (
    'Milla',

    'Text::Xslate', 'Text::Xslate::Bridge::TT2Like',

    'Test::Spelling',
    'Test::Perl::Critic',
    'Test::Pod',
    'Test::CPAN::Meta',
    'Test::MinimumVersion',

    'Pod::Wordlist::hanekomu',
    'Perl::Tidy',
    'Config::Pit',
    'Software::License',
    'Project::Libs',

    'Term::ReadLine::Gnu',

    'Mouse', 'MouseX::Getopt',
    'Class::Accessor::Lite',

    'IO::Socket::SSL',

    'Plack',
    'Amon2', 'Amon2::Lite', 'Protocol::WebSocket',
    'LWP::UserAgent', 'LWP::Protocol::https',
    'Furl',

    'XML::LibXML',
    'XML::RSS::LibXML',

    'AnyEvent',
    'App::cpanoutdated',

    'Text::MultiMarkdown',
    'Data::Section::Simple',

    'YAML',

    $file_notify,
);

print "$_\n" for @modules;
