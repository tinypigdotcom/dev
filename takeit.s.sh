#!/bin/bash
# <- my $code = <<'END_OF_CODE';

set -x
cp ~/.vimrc ~/.vim/_vimrc
cp ~/.bash_profile ~/utility/_bash_profile

# <- END_OF_CODE
# <- $VAR1 = {
# <-     VERSION => '0.0.2',
# <-     purpose => 'to update remote .vimrc and .bash_profile',
# <-     params  => '',
# <-     example => '',
# <-     CODE    => $code,
# <-     target  => "$ENV{HOME}/bin/takeit",
# <- };

