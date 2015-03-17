#!/bin/bash
# <- my $code = <<'END_OF_CODE';

set -x
cp ~/.vimrc ~/.vim/_vimrc
cp ~/.bashrc ~/utility/_bashrc

# <- END_OF_CODE
# <- $VAR1 = {
# <-     VERSION => '0.0.3',
# <-     purpose => 'to update remote .vimrc and .bashrc',
# <-     params  => '',
# <-     example => '',
# <-     CODE    => $code,
# <-     target  => "$ENV{HOME}/bin/takeit",
# <- };

