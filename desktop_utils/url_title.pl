#!/usr/bin/env perl
package App::UrlTitle;
use Mouse;

# reference http://code.google.com/intl/ja/apis/urlshortener/

use LWP::UserAgent;

has ua => (
    is => 'rw',
    isa => 'LWP::UserAgent',
    lazy_build => 1,
);

sub _build_ua {
    LWP::UserAgent->new(
        agent => __PACKAGE__ . "/0.01",
        timeout => 10,
    );
}

has url => (
    is => 'rw',
    isa => 'Str',
    required => 1,
);

__PACKAGE__->meta->make_immutable;

no Mouse;

use Carp;
use Config::Pit;
use JSON::XS;
use HTTP::Request;
use LWP::UserAgent;

use Encode;

sub run {
    my $self = shift;

    my $long_url = $self->url;
    my $shorten = $self->_get_shorten( $long_url );

    my $title = $self->_get_title($long_url);

    print encode_utf8("$title $shorten");
}

sub _get_title {
    my ($self, $url) = @_;

    my $res = $self->ua->get($url);
    unless ($res->is_success) {
        Carp::croak("Can't download $url\n");
    }

    my $content = $res->decoded_content;

    my $title_regexp = qr{<title[^>]*>([^<]*)</title>}ixms;

    unless ($content =~ m{$title_regexp}ixms) {
        Carp::croak("Can't extract title tag\n");
    }

    my $title = $1;
    Carp::croak("title is undefined\n") unless defined $title;

    # remove spaces, tabs, newline
    $title =~ s{\s\s+}{ }gxms;

    return $title;
}

sub _get_shorten {
    my ($self, $long_url) = @_;

    my $config = pit_get("goo.gl", require =>{
        key => "Google API Key",
    });

    my $posting_json = encode_json({
        key     => $config->{key},
        longUrl => $long_url,
    });

    my $api_url = 'https://www.googleapis.com/urlshortener/v1/url';
    my $req = HTTP::Request->new('POST', $api_url);
    $req->header('Content-Type' => 'application/json');
    $req->content($posting_json);

    my $res = $self->ua->request($req);
    unless ($res->is_success) {
        Carp::croak "Error ", $res->status_line;
    }

    my $shorten_info = decode_json($res->decoded_content);
    return $shorten_info->{id};
}

package main;
use strict;
use warnings;

my $url = shift or die "Usage $0 url\n";

unless (caller) {
    my $app = App::UrlTitle->new(url => $url);
    $app->run;
}
