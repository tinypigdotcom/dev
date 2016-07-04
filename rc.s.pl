#!/usr/bin/env perl
# <- my $code = <<'END_OF_CODE';

if ( !@ARGV ) {
    short_usage();
}

use LWP;
my $ua = LWP::UserAgent->new;
$ua->agent("linux");    # HAVE to or else redirect to mobile

sub response_redirect {
    my ( $response, $ua, $h ) = @_;
    my $location = $response->header('location') || '';
    print $response->code(), " $location\n";
    return;
}

$ua->add_handler( response_redirect => \&response_redirect );

my $url = shift @ARGV;
$url = "http://$url" if $url !~ m{://};

my $req = HTTP::Request->new(GET => $url);
my $res = $ua->request($req);

# <- END_OF_CODE

# <- $VAR1 = {
# <-                VERSION => '0.0.1',
# <-                purpose => 'get HTTP code from URL',
# <-                 params => 'URL',
# <-                example => 'http://www.google.com',
# <-                   CODE => $code,
# <-                 target => "$ENV{HOME}/bin/rc",
# <- };

