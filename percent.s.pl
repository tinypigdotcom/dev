#!/usr/bin/perl
# <- my $code = <<'END_OF_CODE';

use DMB::Tools ':all';
use URI::Escape;

my $encode; #->
my $decode;  #->

sub main {
    my @argv = @_;
    my $VAR1;
    my $input = multi_input();
    eval $input;
    my $transformed_text;
    if ( $encode ) {
        $transformed_text = uri_escape_utf8( $input );
    }
    elsif ( $decode ) {
        $transformed_text = uri_unescape( $input );
    }
    else {
        errout("Please select either encode or decode options.");
    }
    print "$transformed_text\n";
    return;
}

my $rc = ( main(@ARGV) || 0 );

exit $rc;

# <- END_OF_CODE

# <- $VAR1 = {
# <-                VERSION => '0.0.1',
# <-                purpose => 'percent encode or decode text for URLs',
# <-                 params => '',
# <-                example => '',
# <-                   CODE => $code,
# <-                 target => "$ENV{HOME}/bin/percent",
# <-     options => [
# <-         {
# <-             long_switch => 'encode',
# <-             short_desc  => 'encode',
# <-             long_desc   => 'percent encode for URLs',
# <-             init        => '0',
# <-         },
# <-         {
# <-             long_switch => 'decode',
# <-             short_desc  => 'decode',
# <-             long_desc   => 'percent decode for URLs',
# <-             init        => '0',
# <-         },
# <-     ],
# <- };

