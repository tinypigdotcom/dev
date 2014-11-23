#!/bin/bash
# <- my $code = <<'END_OF_CODE';

set -x
h=$(/bin/hostname)
DROPFILE=$HOME/info/${h}_heartbeat
d=$(/usr/bin/date)
d=heartbeat
echo $d >$DROPFILE

# <- END_OF_CODE
# <- $VAR1 = {
# <-     VERSION => '0.0.2',
# <-     purpose => 'update a heartbeat file in Dropbox',
# <-     params  => '',
# <-     example => '',
# <-     CODE    => $code,
# <-     target  => "$ENV{HOME}/bin/heartbeat",
# <- };

