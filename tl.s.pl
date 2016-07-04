#!/usr/bin/env perl
# <- my $code = <<'END_OF_CODE';

use 5.16.0;
use warnings FATAL => 'all';

use IO::File;
use DMB::Tools ':all';

sub rand_referrer {
    my $first  = (random_words(5,1))[0];
    my $second = (random_words(4,1))[0];
    for ( $first, $second ) {
        s/(\w)/\u$1/;
    }
    return "$first $second";
}

my $words; #->

if ( !$words ) {
    $words = 5;
}

print rand_referrer(), "\n";

# <- END_OF_CODE

# <- $VAR1 = {
# <-                VERSION => '0.0.1',
# <-                purpose => 'implement tools from DMB::Tools module',
# <-                 params => 'ARGS',
# <-                example => '--words=8',
# <-                   CODE => $code,
# <-                 target => "$ENV{HOME}/bin/tl",
# <-     options => [
# <-         {
# <-             long_switch => 'words=i',
# <-              short_desc => 'words',
# <-               long_desc => "get random word of i length",
# <-                    init => '0',
# <-         },
# <-     ],
# <- };

