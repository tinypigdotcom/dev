#!/bin/bash
# <- my $code = <<'END_OF_CODE';

set -x

INBOX_PATH=/cygdrive/c/shared/Dropbox/dmb/email
OUTFILE="$INBOX_PATH/$*"

echo >"$OUTFILE"

# <- END_OF_CODE
# <- $VAR1 = {
# <-                VERSION => '0.0.2',
# <-                purpose => 'email xvn style note',
# <-                 params => '',
# <-                example => '',
# <-                   CODE => $code,
# <-                 target => "$ENV{HOME}/bin/xn",
# <- };

