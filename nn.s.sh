#!/bin/bash
# <- my $code = <<'END_OF_CODE';

if [ "$#" -lt 1 ]; then
    u_do_short_usage
fi

OUTFILE=$HOME/.nnotes

echo '-----' >>$OUTFILE
date >>$OUTFILE
echo $* >>$OUTFILE

# <- END_OF_CODE
# <- $VAR1 = {
# <-     VERSION => '0.0.3',
# <-     purpose => 'note to self',
# <-     params  => 'whatever you want to say',
# <-     example => 'I just did something awesome',
# <-     CODE    => $code,
# <-     target  => "$ENV{HOME}/bin/nn",
# <- };

