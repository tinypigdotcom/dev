#!/usr/bin/env perl
# <- my $code = <<'END_OF_CODE';

use DMB::Tools ':all';
use JSON;

sub main {
    my @argv = @_;
    my $json = JSON->new->allow_nonref;
    my $json_input = multi_input();
    $json_input =~ s{^(\s*)(\w+)}{$1"$2"}mg;
    if ( !$ugly ) {
        $json = $json->pretty;
    }
    my $perlvar = $json->decode( $json_input );
    my $utf8_encoded_json_text = $json->encode( $perlvar );
    print "$utf8_encoded_json_text\n";
    my $cfh = IO::File->new('/dev/clipboard', '>');
    if (defined $cfh) {
        print $cfh $utf8_encoded_json_text;
        $cfh->close;
    }
    return;
}

my $rc = ( main(@ARGV) || 0 );

exit $rc;

# <- END_OF_CODE

# <- $VAR1 = {
# <-                VERSION => '0.0.2',
# <-                purpose => 'verify and nicely format JSON',
# <-                 params => '',
# <-                example => '--ugly',
# <-                   CODE => $code,
# <-                 target => "$ENV{HOME}/bin/json",
# <-     options => [
# <-         {
# <-             long_switch => 'ugly',
# <-              short_desc => 'ugly',
# <-               long_desc => "condense (versus  pretty print) the output",
# <-                    init => '0',
# <-         },
# <-     ],
# <- };

