#!/bin/bash
# <- my $code = <<'END_OF_CODE';

OUTFILE=$HOME/data/full.cat

if [ -n "$u_opt_r$u_opt_rebuild" ]; then
    echo "Rebuilding index..." >&2
    find /cygdrive >$OUTFILE
elif [ "$#" -lt 1 ]; then
    u_do_short_usage
fi

if (($#)); then
    grep -i "$*[^/]*$" $OUTFILE | less -FX
fi

# <- END_OF_CODE
# <- $VAR1 = {
# <-     VERSION => '1.1.7',
# <-     purpose => 'locate file on local machine',
# <-     params  => 'FILENAME_PART',
# <-     example => 'menu.h',
# <-     CODE    => $code,
# <-     target  => "$ENV{HOME}/bin/lf",
# <-     options => [
# <-         {
# <-             long_switch => 'rebuild',
# <-             short_desc  => 'rebuild',
# <-             long_desc   => 'rebuild list of files',
# <-             init        => '0',
# <-         },
# <-     ],
# <- };

