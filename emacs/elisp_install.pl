#!/usr/bin/env perl
use strict;
use warnings;

use LWP::UserAgent;
use File::Basename qw/basename/;
use File::Path qw/make_path/;
use File::Spec;
use Cwd;
use File::Copy qw/copy/;
use Getopt::Long;
use Time::HiRes;

local $| = 1; # Force flush, not buffering

my $elisp_base =  File::Spec->catfile($ENV{HOME}, '.emacs.d', 'myelisp');
my %elisp_dir = (
    install => File::Spec->catfile($elisp_base, 'install'),
    repos   => File::Spec->catfile($elisp_base, 'repos'),
);

my @packages;
Getopt::Long::GetOptions(
    'clean'         => \my $clean_flag,
    'byte-compile'  => \my $bytecompile_flag,
    'download-only' => \my $download_only,
    'p|package'     => \@packages,
) or usage();

my $elisp_config = shift or die "Usage: $0 config_file";

my %package;
if (@packages) {
    map { $package{$_} = 1; } @packages;
}

my @load_pathes;

main();

sub main {
    my $conf = do $elisp_config or die "Can't load $elisp_config";

    init();

    if ($clean_flag) {
        clean_dirs();
    }

    if ($bytecompile_flag) {
        clean_compiled_files();
    }

    get_git_package($conf->{git});

    get_direct_package($conf->{tar}, sub {
        my $filename = shift;

        my @cmd = (qw/tar xf/, $filename, "-C", $elisp_dir{repos});
        system(@cmd) == 0 or warn "[tar] Can't extract $filename\n";
        unlink $filename;
    });

    if ($bytecompile_flag) {
        bytecompile();
    }

    generate_path_file();
}

sub generate_path_file {
    my $orig_dir = Cwd::getcwd;

    chdir $elisp_dir{repos};
    opendir my $dh, $elisp_dir{repos} or die "Can't opendir: $!";
    for my $dir (readdir $dh) {
        next if $dir eq '.' || $dir eq '..';
        push @load_pathes, File::Spec->catfile($elisp_dir{repos}, $dir);
    }
    closedir $dh;
    chdir $orig_dir;

    my $load_file = File::Spec->catfile($elisp_base, 'load.el');
    open my $fh, '>', $load_file or die "Can't open $load_file: $!";
    for my $load_path (@load_pathes) {
        print {$fh} qq{(add-to-list 'load-path "$load_path")\n};
    }
    close $fh;
}

sub clean_compiled_files {
    print "Clean byte compiled files\n";
    my $orig_dir = Cwd::getcwd;

    chdir $elisp_dir{install};
    for my $elc (glob '*.elc') {
        unlink $elc or die "Can't unlink $elc: $!";
    }
    chdir $orig_dir;
}

sub clean_dirs {

    print "Clean elisp dirs\n";
    for my $dir (values %elisp_dir) {
        print "  $dir\n";
        File::Path::remove_tree($dir) or die "Can't remove $dir: $!";
    }
}

sub init {
    my @dirs;

    for my $dir (values %elisp_dir) {
        unless (-d $dir) {
            print "Create directory: $dir\n";
            make_path($dir) or die "Can't create $dir";
        }
    }
}

sub bytecompile {
    my $orig_dir = Cwd::getcwd;
    chdir $elisp_dir{install};

    my @fails;
    for my $elisp ( glob('*.el') ) {
        my @cmd = (qw/emacs --batch -L . -f batch-byte-compile/, $elisp);

        next if -e "${elisp}c";

        print "  bytecompile $elisp\n";

        my $status = system @cmd;
        if ($status != 0) {
            @cmd = (qw/emacs --batch -f batch-byte-compile/, $elisp);
            $status = system @cmd;
            if ($status != 0) {
                warn "bytecompile failed: $elisp\n";
                push @fails, $elisp;
            }
        }
    }

    if (@fails) {
        print "[Bytecompile] Failed: $_\n" for @fails;
    }

    chdir $orig_dir;
}

sub get_git_package {
    my $conf = shift;

    my $orid_dir = Cwd::getcwd;
    chdir $elisp_dir{repos} or die "Can't chdir $elisp_dir{repos}";

    my @fails;
    while (my ($name, $repo_info) = each %{$conf}) {
        if (@packages) {
            next unless exists $package{$name};
        }

        print "Git repository: '$name'\n";

        my $url = $repo_info->{url};
        my $repo_dir = File::Basename::basename($url);
        $repo_dir =~ s{\.git$}{};

        my $is_clone = 0;
        my $orig_dir = Cwd::getcwd;

        my @cmd;
        unless(-d $repo_dir) {
            next if $download_only;
            @cmd = (qw/git clone/, $url);

            print "@cmd\n";
            my $status = system @cmd;
            if ($status != 0) {
                warn "Failed '@cmd'\n";
                push @fails, $name;
            }

            $is_clone = 1;
        }

        chdir $repo_dir or die "Can't chdir $repo_dir: $!";

        unless ($is_clone) {
            @cmd = qw/git pull origin master/;
            my $status = system @cmd;
            if ($status != 0) {
                warn "Failed '@cmd'\n";
                push @fails, $name;
            }
        }

        if (-e 'Makefile') {
            my $status = system qw/make/;
            if ($status != 0) {
                warn "Failed 'make'\n";
                push @fails, $name;
            }
        }

        for my $rel_path (@{$repo_info->{path}}) {
            my $load_path = File::Spec->catfile(Cwd::getcwd, $rel_path);
            push @load_pathes, $load_path;
        }

        chdir $orig_dir or die "Can't chdir $orig_dir: $!";

        sleep 0.5;
    }
    chdir $orid_dir;

    if (@fails) {
        print "[GIT] Failed: $_\n" for @fails;
    }
}

sub get_direct_package {
    my ($conf, $cb) = @_;
    my $ua = LWP::UserAgent->new;

    my @fails;
    while (my ($name, $urls) = each %{$conf}) {
        if (@packages) {
            next unless exists $package{$name};
        }

        print "Download '$name' package\n";
        for my $url (@{$urls}) {
            my $output_name = File::Basename::basename($url);
            if ($output_name !~ m{\.el$} && $output_name =~ m{\.(?:tar.?|tgz$)}) {
                $output_name =~ s{^([^\.]+)$}{$1.el};
            }

            print "  ==> $output_name\n";

            $output_name = File::Spec->catfile($elisp_dir{install}, $output_name);
            if ($download_only) {
                next if -e $output_name;
            }

            my $res = $ua->get($url);

            unless ($res->is_success) {
                warn "  Can't download $url\n";
                push @fails, $url;
                next;
            }

            print "  write out $output_name\n";
            open my $fh, '>', $output_name;
            print {$fh} $res->content;
            close $fh;

            if ($cb) {
                $cb->($output_name);
            }

            sleep 0.5;
        }
    }

    if (@fails) {
        print "[Download] Failed: $_\n" for @fails;
    }
}

sub usage {
    die <<"...";
$0 [options] config_file

Options:
    clean           Clean installed directory before setup
    byte-compile    Bytecompile elisps downloaded
    download-only   Not download files If file is exist
    p,package       Install specified packages
...
}

sub show_all_packages {
    my $conf = shift;

    for my $way (sort keys %{$conf}) {
        for my $name (%{$conf->{$way}}) {
            print "[$way] $name\n";
        }
    }
}
