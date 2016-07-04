#!/usr/bin/env perl
# <- my $code = <<'END_OF_CODE';

use strict;
use warnings FATAL => 'all';

use IO::File;

if ( @ARGV < 1 ) {
    do_short_usage();
}

sub do_renumbering {
    my ($file) = @_;

    my $ifh = IO::File->new($file, '<');
    die if (!defined $ifh);

    my $count = 1;
    while(<$ifh>) {
        chomp;
        if ( /#(\d+)$/ ) {
            my $pcount = sprintf('%03d', $count++);
            s/#\d+$/#$pcount/;
        }
        print "$_\n";
    }
    $ifh->close;
}

sub main {
    my @argv = @_;
    do_renumbering(@argv);
    return;
}

my $rc = ( main(@ARGV) || 0 );

exit $rc;

# <- END_OF_CODE

# <- $VAR1 = {
# <-                VERSION => '0.0.1',
# <-                purpose => 'renumber perl tests',
# <-                 params => 'TEST_FILENAME',
# <-                example => '01-shopping_cart.t',
# <-                   CODE => $code,
# <-                 target => "$ENV{HOME}/bin/renumber",
# <-     options => [
# <-     ],
# <- };

