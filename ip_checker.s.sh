#!/bin/bash
# <- my $top_comments_block = <<'END_OF_COMMENTS';
# inet addr:192.168.1.166  Bcast:192.168.1.255  Mask:255.255.255.0
# These comments come first.
# <- END_OF_COMMENTS
# <- my $code = <<'END_OF_CODE';

set -x
UTIL=$HOME/.utility
FILE=$UTIL/ip_address
FILE1=$UTIL/ip_address1
h=$(/bin/hostname)
DROPFILE=$HOME/info/${h}_ip

if [ -d /cygdrive ]; then
    /cygdrive/c/WINDOWS/system32/ipconfig | perl -ne '/IP Address/ && s/\D*(\d)/$1/ && print' >$FILE1
else
    ifconfig -a | perl -ne '/Bcast/ && s/\D*([\d\.]+).*/$1/ && print' >$FILE1
fi

if [ ! -f "$FILE" -a ! -f "$FILE1" ]; then
    echo one >$FILE
    echo two >$FILE1
fi

if [ -f "$FILE" -a -f "$FILE1" ]; then
    if cmp $FILE $FILE1; then
        :
    else
        cp $FILE1 $FILE
        cp $FILE1 $DROPFILE
        rm $FILE1
    fi
else
    cp $FILE1 $FILE
fi

if [ ! -f "$DROPFILE" ]; then
    cp $FILE $DROPFILE
fi

# <- END_OF_CODE
# <- $VAR1 = {
# <-     VERSION => '0.0.2',
# <-     purpose => "keep file on Dropbox updated with this machine's current IP",
# <-     params  => '',
# <-     example => '',
# <-     CODE    => $code,
# <-     top_comments_block => $top_comments_block,
# <-     target  => "$ENV{HOME}/bin/ip_checker",
# <- };

