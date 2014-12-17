#!/bin/bash
# <- my $code = <<'END_OF_CODE';

if [ "$#" -lt 1 ]; then
    u_do_short_usage
fi

echo '1. -h'
$1 -h
echo "exit status $?"
echo

echo '2. -v'
$1 -v
echo "exit status $?"
echo

echo '3. --help'
$1 --help
echo "exit status $?"
echo

echo '4. --version'
$1 --version
echo "exit status $?"
echo

# <- END_OF_CODE
# <- $VAR1 = {
# <-     VERSION => '0.0.2',
# <-     purpose => 'run help and version switches on script',
# <-     params  => 'script',
# <-     example => 'af',
# <-     CODE    => $code,
# <-     target  => "$ENV{HOME}/bin/ch",
# <- };
