#!/usr/bin/perl
# <- my $code = <<'END_OF_CODE';

use Data::Dumper;
use DMB::Tools ':all';
use JSON;

$Data::Dumper::Indent=0;

sub main {
    my @argv = @_;
    my $json = JSON->new->allow_nonref;
    my $json_input = multi_input();
    if ( $pretty ) {
        $Data::Dumper::Indent=2;
    }
    my $perlvar = $json->decode( $json_input );
    print Dumper($perlvar), "\n";
    return;
}

my $rc = ( main(@ARGV) || 0 );

exit $rc;

# <- END_OF_CODE

# <- $VAR1 = {
# <-                VERSION => '0.0.1',
# <-                purpose => 'convert JSON to perl data structure',
# <-                 params => '',
# <-                example => '--pretty',
# <-                   CODE => $code,
# <-                 target => "$ENV{HOME}/bin/json2perl",
# <-     options => [
# <-         {
# <-             long_switch => 'pretty',
# <-              short_desc => 'pretty print',
# <-               long_desc => "pretty print (versus condensed) the output",
# <-                    init => '0',
# <-         },
# <-     ],
# <- };

