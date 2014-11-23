#!/bin/bash
# <- my $code = <<'END_OF_CODE';

if [ "$#" -lt 1 ]; then
    u_do_short_usage
fi

echo '1. -h'
$1 -h
echo

echo '2. -v'
$1 -v
echo

echo '3. --help'
$1 --help
echo

echo '4. --version'
$1 --version
echo

# <- END_OF_CODE
# <- $VAR1 = {
# <-     VERSION => '0.0.1',
# <-     purpose => 'run help and version switches on script',
# <-     params  => 'script',
# <-     example => 'af',
# <-     CODE    => $code,
# <-     target  => "$ENV{HOME}/bin/ch",
# <- };
