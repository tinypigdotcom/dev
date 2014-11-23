#!/bin/bash
# <- my $top_comments_block = <<'END_OF_COMMENTS';
# NOTE: DO NOT USE "exit" ONLY "return" as this is sourced in the current
# <- END_OF_COMMENTS
# <- my $code = <<'END_OF_CODE';

if [ "$#" -lt 1 ]; then
    u_do_short_usage
    return $ERR_EXIT
fi


cd $(zdir $1)

# <- END_OF_CODE
# <- $VAR1 = {
# <-     VERSION => '0.0.3',
# <-     PROG    => 'd',
# <-     purpose => 'cd to directory of file in "p" project system',
# <-     params  => 'shortcut',
# <-     example => 'a',
# <-     exit    => 'return',
# <-     CODE    => $code,
# <-     top_comments_block => $top_comments_block,
# <-     target  => "$ENV{HOME}/bin/d",
# <- };

