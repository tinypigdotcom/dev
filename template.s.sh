#!/bin/bash
# <- my $top_comments_block = <<'END_OF_COMMENTS';
# These comments come first.
# <- END_OF_COMMENTS
# <- my $code = <<'END_OF_CODE';

echo "replace this with code"

# <- END_OF_CODE
# <- $VAR1 = {
# <-                VERSION => '0.0.6',
# <-                   PROG => 'c',?
# <-                purpose => 'Search for a file and add it to the current "p" project.',
# <-                 params => 'FILENAME_PART',
# <-                example => 'menu.h',
# <-                   exit => 'return',?
# <-                   CODE => $code,
# <-     top_comments_block => $top_comments_block,
# <-                 target => "$ENV{HOME}/bin/",
# <-     options => [
# <-         {
# <-             long_switch => 'backdate=i',
# <-              short_desc => 'backdate=#DAYS',
# <-               long_desc => 'edit # days ago instead of today',
# <-                    init => '0',
# <-         },
# <-         {
# <-             long_switch => 'yesterday',
# <-              short_desc => 'yesterday',
# <-               long_desc => "edit yesterday's data instead of today's",
# <-                    init => '0',
# <-         },
# <-     ],
# <- };

