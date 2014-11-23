#!/bin/bash
# <- my $code = <<'END_OF_CODE';

function ask()
{
    echo -n "$@" '(y/[N]) ' ; read ans </dev/tty
    case "$ans" in
        y*|Y*) return 0 ;;
        *) return 1 ;;
    esac
}

if ! ask "Version numbers updated?"
    then exit 1
fi

# <- END_OF_CODE
# <- $VAR1 = {
# <-     VERSION => '1.1',
# <-     purpose => 'script to run prior to git commit',
# <-     params  => '',
# <-     example => '',
# <-     CODE    => $code,
# <-     target  => "$ENV{HOME}/bin/git-pre-commit",
# <- };

