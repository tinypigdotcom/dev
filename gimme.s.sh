#!/bin/bash
# <- my $code = <<'END_OF_CODE';

set -x
cp ~/.vim/_vimrc ~/.vimrc
cp ~/utility/_bashrc ~/.bashrc

# <- END_OF_CODE
# <- $VAR1 = {
# <-     VERSION => '0.0.2',
# <-     purpose => 'to update local .vimrc and .bash_profile',
# <-     params  => '',
# <-     example => '',
# <-     CODE    => $code,
# <-     target  => "$ENV{HOME}/bin/gimme",
# <- };

