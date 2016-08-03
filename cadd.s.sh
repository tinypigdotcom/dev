#!/bin/bash
# <- my $top_comments_block = <<'END_OF_COMMENTS';
# These comments come first.
# <- END_OF_COMMENTS
# <- my $code = <<'END_OF_CODE';

echo $* >>$HOME/.stickies

# <- END_OF_CODE
# <- $VAR1 = {
# <-                VERSION => '0.0.1',
# <-                   PROG => 'cadd',
# <-                purpose => 'Add notifications to clocky.',
# <-                 params => 'TEXT',
# <-                example => 'Take out the trash',
# <-                   exit => 'return',
# <-                   CODE => $code,
# <-     top_comments_block => $top_comments_block,
# <-                 target => "$ENV{HOME}/bin/cadd",
# <-     options => [
# <-     ],
# <- };

