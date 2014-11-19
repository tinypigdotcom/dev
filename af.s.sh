#!/bin/bash
# <- my $code = <<'END_OF_CODE';

if [ "$#" -lt 1 ]; then
    do_short_usage
fi

cd /www
b=-1
while read a
do
    let b=b+1
    file[b]=$a
done < <(find . -iname "*$**" )

let i=0
until [ "$i" -gt "$b" ]
do
    echo "$i ${file[$i]}"
    let i=i+1
done

echo
f
echo -n "f "
read key index

f $key ${file[$index]}
# <- END_OF_CODE
# <- $VAR1 = {
# <-     VERSION => '0.0.6',
# <-     purpose => 'Search for a file and add it to the current "p" project.',
# <-     params  => 'FILENAME_PART',
# <-     example => 'menu.h',
# <-     CODE    => $code,
# <-     target  => "$ENV{HOME}/bin/af",
# <- };
