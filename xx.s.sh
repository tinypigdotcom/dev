#!/bin/bash
# <- my $top_comments_block = <<'END_OF_COMMENTS';
# These comments come first.
# <- END_OF_COMMENTS
# <- my $code = <<'END_OF_CODE';

grep -iv $* $HOME/.stickies >>$HOME/.stickies2
mv $HOME/.stickies2 $HOME/.stickies

# <- END_OF_CODE
# <- $VAR1 = {
# <-                VERSION => '0.0.1',
# <-                   PROG => 'xx',
# <-                purpose => '"x" out entries in clocky notifications.',
# <-                 params => 'TEXT',
# <-                example => 'lawnmower',
# <-                   exit => 'return',
# <-                   CODE => $code,
# <-     top_comments_block => $top_comments_block,
# <-                 target => "$ENV{HOME}/bin/xx",
# <-     options => [
# <-     ],
# <- };

