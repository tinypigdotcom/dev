#!/usr/bin/perl
# <- my $code = <<'END_OF_CODE';

use strict;
use warnings FATAL => 'all';

use Data::Dumper;

sub main {
    my @argv = @_;
    my $target = '.';
    my $new;
    for ('a'..'z') {
        if ( ! -f "$_.pl" ) {
            $new = "$_.pl";
            last;
        }
    }
    my $editor = $ENV{EDITOR} || 'vim';
    system "$editor $new";
    return;
}

my $rc = ( main(@ARGV) || 0 );

exit $rc;

# <- END_OF_CODE

# <- $VAR1 = {
# <-                VERSION => '0.0.1',
# <-                purpose => 'get new perl',
# <-                 params => '',
# <-                example => '',
# <-                   CODE => $code,
# <-                 target => "$ENV{HOME}/bin/newp",
# <- };

