#!/bin/bash
# <- my $top_comments_block = <<'END_OF_COMMENTS';
# These comments come first.
# <- END_OF_COMMENTS
# <- my $code = <<'END_OF_CODE';

while true
do
    date +'%l:%M:%S %p %a %m/%d'
    tail -3 $HOME/.stickies
    sleep 1
done

# <- END_OF_CODE
# <- $VAR1 = {
# <-                VERSION => '0.0.1',
# <-                   PROG => 'clocky',
# <-                purpose => 'Cheesy system clock plus notifications.',
# <-                 params => '',
# <-                example => '',
# <-                   exit => 'return',
# <-                   CODE => $code,
# <-     top_comments_block => $top_comments_block,
# <-                 target => "$ENV{HOME}/bin/clocky",
# <-     options => [
# <-     ],
# <- };

