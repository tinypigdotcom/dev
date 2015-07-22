#!/usr/bin/perl
# <- my $code = <<'END_OF_CODE';

use DMB::Tools ':all';
use URI::Escape;

sub main {
    my @argv = @_;
    my $VAR1;
    my $input = do { local $/; <STDIN> };
    eval $input;
    my $uri_encoded_text = uri_escape_utf8( $input );
    print "$uri_encoded_text\n";
    return;
}

my $rc = ( main(@ARGV) || 0 );

exit $rc;

# <- END_OF_CODE

# <- $VAR1 = {
# <-                VERSION => '0.0.1',
# <-                purpose => 'percent encode text for URLs',
# <-                 params => '',
# <-                example => '',
# <-                   CODE => $code,
# <-                 target => "$ENV{HOME}/bin/percent_encode",
# <-     options => [
# <-     ],
# <- };

