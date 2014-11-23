#!/bin/bash
# <- my $code = <<'END_OF_CODE';

if [ -n "$1" ]; then
    lookup=$1
    shift
fi

case $lookup in
       "") cmd="f 1" ;;
        *) if [ -f $HOME/bin2/$lookup ]; then
               cmd="cd $HOME/bin2; vim $lookup $*"
           else
               cmd="cd $HOME/bin; vim $lookup $*"
           fi;;
esac

echo $cmd >&2
eval $cmd

# <- END_OF_CODE
# <- $VAR1 = {
# <-     VERSION => '0.0.2',
# <-     purpose => 'edit file in your bin or bin2 directory',
# <-     params  => 'file',
# <-     example => 'af',
# <-     CODE    => $code,
# <-     target  => "$ENV{HOME}/bin/e",
# <- };

