#!/usr/bin/perl
# <- my $top_comments_block = <<'END_OF_COMMENTS';
# These comments come first.
# <- END_OF_COMMENTS
# <- my $code = <<'END_OF_CODE';

print "replace this with code";

# <- END_OF_CODE

# <- $VAR1 = {
# <-                VERSION => '1.04',
# <-                purpose => 'edit work log',
# <-                 params => 'FILENAME_PART',
# <-                example => '--backdate=3',
# <-                   CODE => $code,
# <-     top_comments_block => $top_comments_block,
# <-                 target => "$ENV{HOME}/bin/elog",
# <-     options => [
# <-         {
# <-             long_switch => 'backdate=i',
# <-              short_desc => 'backdate=#DAYS',
# <-               long_desc => 'edit # days ago instead of today',
# <-         },
# <-         {
# <-             long_switch => 'yesterday',
# <-              short_desc => 'yesterday',
# <-               long_desc => "edit yesterday's data instead of today's",
# <-         },
# <-     ],
# <- };

