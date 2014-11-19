#!/bin/bash
# <- my $top_comments_block = <<'END_OF_COMMENTS';
# The point of it is to use as a quick backup for if I am working on something
# outside a repository and I want to make sure I don't lose it.
# bs stands for "backup script" I swear.
# <- END_OF_COMMENTS
# <- my $code = <<'END_OF_CODE';

if [ "$#" -lt 1 ]; then
    do_short_usage
fi

FILE=$1
if [ ! -f "$FILE" ]; then
    errout "File \"$FILE\" not found."
fi

DIR=`dirname $FILE`
BASE=`basename $FILE`
HERE=`pwd`
cd $DIR
FDIR=`pwd`
cd $HERE
FULL=`echo "$FDIR/$BASE" | sed -e 's?/?%?g'`

mkdir ~/archive 2>/dev/null
cp $FILE ~/archive/$FULL
cd ~/archive
git init >/dev/null 2>&1
git add $FULL
git commit -m "archived"
git push origin master 2>/dev/null

# <- END_OF_CODE
# <- $VAR1 = {
# <-     VERSION            => '1.0.5',
# <-     purpose            => 'to quickly back up a script version into ~/archive via git',
# <-     params             => 'FILE',
# <-     example            => 'menu.h',
# <-     CODE               => $code,
# <-     top_comments_block => $top_comments_block,
# <-     target             => "$ENV{HOME}/bin/bs",
# <- };

