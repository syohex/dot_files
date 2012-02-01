#!/home/syohei/perl5/perlbrew/perls/perl-5.14.1/bin/perl
use strict;
use warnings;
use File::Which qw/which/;

use utf8;
use Encode qw(encode_utf8);

local $SIG{__DIE__} = sub {
    exec qw/zenity --error --text/, encode_utf8(shift);
};

check_environment();

my $option = shift or die "Usage: $0 [top|right|bottom|left]";

my ($desktop_width, $desktop_height);
my $id = get_display_info();
my $window_info = get_window_info($id);

if (grep { $option eq $_ } qw/top right bottom left/ ) {
    move_window($window_info);
} else {
    zoom_window($window_info);
}

sub get_display_info {
    my @cmd = qw/xprop -root/;

    open my $fh, '-|', @cmd or die "Can't exec '@cmd'";

    my $window_id;
    my ($is_set_window_size, $does_get_id) = (0, 0);
    while ( my $line = <$fh> ) {
        chomp $line;

        if ($line =~ m{^_NET_DESKTOP_GEOMETRY [^=]+ = \s+ (\d+), \s+ (\d+)}x) {
            ($desktop_width, $desktop_height) = ($1, $2);
            $is_set_window_size = 1;
        }

        if ($line =~ m{^_NET_ACTIVE_WINDOW}) {
            if ($line =~ m{window \s+ id \s+ \# \s+ ( [^\s,]+ )}x) {
                $window_id = $1;
                $does_get_id = 1;
            }
        }

        last if $is_set_window_size && $does_get_id;
    }

    close $fh;

    unless ($is_set_window_size && $does_get_id) {
        die "Can't get window info";
    }

    return $window_id;
}

sub move_window {
    my $window_info = shift;

    my $panel_height = 0;
    if ($ENV{DESKTOP_SESSION} ne 'gnome') {
        $panel_height = get_panel_height();
    }

    my @cmd = ('wmctrl', '-i', '-r', $window_info->{id}, '-e');

    my $move_parameter;
    if ($option eq 'top') {
        my $y_pos = $panel_height;
        $move_parameter = "0,-1,$panel_height,-1,-1";
    } elsif ($option eq 'right') {
        my $x_pos = $desktop_width - $window_info->{width};
        $move_parameter =  "0,$x_pos,-1,-1,-1";
    } elsif ($option eq 'bottom') {
        my $y_pos = $desktop_height - $window_info->{height} - $panel_height;
        $move_parameter =  "0,-1,$y_pos,-1,-1";
    } elsif ($option eq 'left') {
        $move_parameter = '0,0,-1,-1,-1';
    } else {
        die "Unknown option '$option'";
    }

    push @cmd, $move_parameter;
    system(@cmd) == 0 or die "Can't exec '@cmd'";
}

sub zoom_window {
    my $window_info = shift;

    my @cmd = ('wmctrl', '-i', '-r', $window_info->{id}, '-e');

    my $fix_size = 50;
    my $zoom_parameter;
    if ($option eq 'j' || $option eq 'k') {
        my $size = $option eq 'j' ? -$fix_size : $fix_size;
        my $h = $window_info->{height} + $size;
        $zoom_parameter = "0,-1,-1,-1,$h";
    } elsif ($option eq 'h' || $option eq 'l') {
        my $size = $option eq 'h' ? -$fix_size : $fix_size;
        my $w = $window_info->{width} + $size;
        $zoom_parameter = "0,-1,-1,$w,-1";
    } else {
        die "Unknown option '$option'";
    }

    push @cmd, $zoom_parameter;
    system(@cmd) == 0 or die "Can't exec '@cmd'";
}

sub get_panel_height {
    my @cmd = qw/wmctrl -l -G/;

    open my $fh, "-|", @cmd or die "Can't exec '@cmd'";

    my $panel_height = 0;
    while ( my $line = <$fh> ) {
        chomp $line;

        if ( $line =~ m{xfce4-panel} ) {
            my ($id, $workspace, $x_pos, $y_pos, $width, $height, @rest)
                = split /\s+/, $line;

            $panel_height = $height;
            last;
        }

    }
    close $fh;

    return $panel_height;
}

sub get_window_info {
    my $id = shift;
    my @cmd = (qw/xwininfo -id/, $id);

    open my $fh, '-|', @cmd or die "Can't exec '@cmd'";

    my $window_info = { id => $id };
    while ( my $line = <$fh> ) {
        chomp $line;

        if ($line =~ m{Width:\s+(\d+)}) {
            $window_info->{width} = $1;
        } elsif ($line =~ m{Height:\s+(\d+)}) {
            $window_info->{height} = $1;
        }
    }
    close $fh;

    return $window_info;
}

sub check_environment {
    for my $cmd (qw/wmctrl xprop xwininfo zenity/) {
        die "Please install '$cmd'" unless defined which($cmd);
    }
}
