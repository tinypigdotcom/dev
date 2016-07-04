#!/usr/bin/env perl
# <- my $code = <<'END_OF_CODE';

use warnings;
use strict;

for my $module ( @ARGV ) {
    my $package = $module;

    # From This::That to This/That.pm
    s/::/\//g, s/$/.pm/ for $module;

    if ( require $module ) {
        print $package . " => " . $INC{$module} . "\n";
        system("vim $INC{$module}") if $Vim;
    }
}

# <- END_OF_CODE

# <- $VAR1 = {
# <-     VERSION => '0.0.2',
# <-     purpose => 'print full path of a Perl module',
# <-     example => 'File::Finder',
# <-     CODE    => $code,
# <-     target  => "$ENV{HOME}/bin/ptype",
# <-     options => [
# <-         {
# <-             long_switch => 'Vim',
# <-             short_desc  => 'Vim',
# <-             long_desc   => "edit module with vim",
# <-             init        => '0',
# <-         },
# <-     ],
# <- };

