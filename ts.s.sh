#!/bin/bash
# <- my $code = <<'END_OF_CODE';

date -u +'%Y-%m-%dT%H:%M:%S.%N'|perl -pe 's/..$/Z/g'

# <- END_OF_CODE
# <- $VAR1 = {
# <-                VERSION => '0.0.1',
# <-                   PROG => 'ts',
# <-                purpose => 'generate timestamp',
# <-                 params => '',
# <-                example => '',
# <-                   exit => 'exit',
# <-                   CODE => $code,
# <-                 target => "$ENV{HOME}/bin/ts",
# <- };

