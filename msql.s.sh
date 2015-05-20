#!/bin/bash
# <- my $code = <<'END_OF_CODE';

password=`cat $HOME/.dbradford`
mysql -u dbradford -D menagerie --password=$password

# <- END_OF_CODE
# <- $VAR1 = {
# <-                VERSION => '0.0.1',
# <-                   PROG => 'msql',
# <-                purpose => 'Connect to MySQL',
# <-                 params => '',
# <-                example => '',
# <-                   exit => 'exit',
# <-                   CODE => $code,
# <-                 target => "$ENV{HOME}/bin/msql",
# <- };

