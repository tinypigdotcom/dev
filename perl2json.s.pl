#!/usr/bin/perl
# <- my $code = <<'END_OF_CODE';

use DMB::Tools ':all';
use JSON;

sub main {
    my @argv = @_;
    my $VAR1;
    my $json = JSON->new->allow_nonref;
    my $dumper_output = multi_input();
    eval $dumper_output;
    if ( $pretty ) {
        $json = $json->pretty;
    }
    my $utf8_encoded_json_text = $json->encode( $VAR1 );
    print "$utf8_encoded_json_text\n";
    return;
}

my $rc = ( main(@ARGV) || 0 );

exit $rc;

# <- END_OF_CODE

# <- $VAR1 = {
# <-                VERSION => '0.0.2',
# <-                purpose => 'convert perl Dumper data structure to JSON',
# <-                 params => '',
# <-                example => '--pretty',
# <-                   CODE => $code,
# <-                 target => "$ENV{HOME}/bin/perl2json",
# <-     options => [
# <-         {
# <-             long_switch => 'pretty',
# <-              short_desc => 'pretty print',
# <-               long_desc => "pretty print (versus condensed) the output",
# <-                    init => '0',
# <-         },
# <-     ],
# <- };

