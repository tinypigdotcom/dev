#!/usr/bin/perl
# <- my $code = <<'END_OF_CODE';

print "replace this with code";

# <- END_OF_CODE

# <- $VAR1 = {
# <-     VERSION => '1.04',
# <-     purpose => 'edit work log',
# <-     example => '--backdate=3',
# <-     CODE    => $code,
# <-     target  => "$ENV{HOME}/bin/elog",
# <-     options => [
# <-         {
# <-             long_switch => 'backdate=i',
# <-             short_desc  => 'backdate=#DAYS',
# <-             long_desc   => 'edit # days ago instead of today',
# <-         },
# <-         {
# <-             long_switch => 'yesterday',
# <-             short_desc  => 'yesterday',
# <-             long_desc   => "edit yesterday's data instead of today's",
# <-         },
# <-     ],
# <- };

