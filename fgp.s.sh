#!/bin/bash
# <- my $code = <<'END_OF_CODE';

find . | grep "$@" 2>/dev/null

# <- END_OF_CODE
# <- $VAR1 = {
# <-     VERSION => '0.0.2',
# <-     purpose => 'find file matching pattern from current directory',
# <-     params  => '',
# <-     example => '',
# <-     CODE    => $code,
# <-     target  => "$ENV{HOME}/bin/fgp",
# <- };

