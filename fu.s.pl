#!/usr/bin/perl
# <- my $code = <<'END_OF_CODE';

use DMB::Random ':all';

sub main {
    print get_fake_uuid(), "\n";
    return;
}

my $rc = ( main(@ARGV) || 0 );

exit $rc;


# <- END_OF_CODE

# <- $VAR1 = {
# <-                VERSION => '0.0.1',
# <-                purpose => 'get fake uuid',
# <-                 params => '',
# <-                example => '',
# <-                   CODE => $code,
# <-                 target => "$ENV{HOME}/bin/fu",
# <- };

