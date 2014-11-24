#!/bin/bash
# <- my $top_comments_block = <<'END_OF_COMMENTS';
#    $ u
#    Usage: $ u n
#    where n is one of:
#         g   update_gits
#         l   ls -la $* | less
#         p   ps aux | grep $*
#         s   sudo su -
#         v   lsb_release -a
#         x   chmod +x $*

# -------------------------- Data: map option letter to its associated command
# <- END_OF_COMMENTS
# <- my $code = <<'END_OF_CODE';

A="


     g   update_gits
     l   ls -la $* | less
     p   ps aux | grep $*
     s   sudo su -
     v   lsb_release -a
     x   chmod +x $*


"

# -------------------------- Setup -------------------------------------------
lookup=$1
shift

# -------------------------- Create or read other commands from config file --
if [ "x$HOME" != "x" ]; then
    UTILITY_DIR=$HOME/.utility
    CONFIG=$UTILITY_DIR/$u_PROG
    if [ ! -d "$UTILITY_DIR" ]; then
        mkdir $UTILITY_DIR
    fi
    if [ ! -f "$CONFIG" ]; then
        echo "# example config for $u_PROG script" >$CONFIG
        echo "$A" | sed -e 's/^/#/' >>$CONFIG
    fi
    if [ -r "$CONFIG" ]; then
        B=`grep -v '^ *#' $HOME/.utility/$u_PROG 2>/dev/null`
    fi
fi

# -------------------------- Display usage function --------------------------
usage() {
    echo "Usage: $ $u_PROG n" >&2
    echo "where n is one of:" >&2
    i=0
    while [  $i -lt ${#option[@]} ]; do
        printf "    %4s   %4s\n" "${option[$i]}" "${cmd[$i]}" >&2
        let i=i+1
    done
}

# -------------------------- Read data into array ----------------------------
let i=0
option[0]=
cmd[0]=
while read a b
do
    if [ "x$a" == "x" ]; then
        continue
    fi
    option[$i]="$a"
    cmd[$i]="$b"
    let i=i+1
done < <(echo "$B$A" | sort)

# -------------------------- Search array for chosen option ------------------
mycmd=
i=0
while [  $i -lt ${#option[@]} ]; do
    if [ "$lookup" == ${option[$i]} ]; then
        mycmd=${cmd[$i]}
        break
    fi
    let i=i+1
done

if [ -n "$mycmd" ]; then
    eval "echo \"$mycmd\"" >&2
    eval $mycmd
else
    usage
fi

# <- END_OF_CODE
# <- $VAR1 = {
# <-     VERSION => '0.1.2',
# <-     purpose => 'shorcut script for Unix commands',
# <-     params  => 'shortcut',
# <-     example => 'x',
# <-     CODE    => $code,
# <-     top_comments_block => $top_comments_block,
# <-     target  => "$ENV{HOME}/bin/u",
# <- };

