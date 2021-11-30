#!/bin/bash
# <- my $code = <<'END_OF_CODE';

set -x
grep -R "$@" . 2>/dev/null | cut -c-180

# <- END_OF_CODE
# <- $VAR1 = {
# <-     VERSION => '0.0.2',
# <-     purpose => 'recursive grep at current directory',
# <-     params  => '',
# <-     example => '',
# <-     CODE    => $code,
# <-     target  => "$ENV{HOME}/bin/grp",
# <- };

