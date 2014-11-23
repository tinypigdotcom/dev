#!/bin/bash
# <- my $code = <<'END_OF_CODE';

if [ "$#" -lt 1 ]; then
    u_do_short_usage
fi

cmd="cd $HOME/.utility; vim $1"

echo $cmd >&2
eval $cmd

# <- END_OF_CODE
# <- $VAR1 = {
# <-     VERSION => '0.0.2',
# <-     purpose => 'edit file in your .utility directory',
# <-     params  => 'file',
# <-     example => 'g',
# <-     CODE    => $code,
# <-     target  => "$ENV{HOME}/bin/ee",
# <- };

