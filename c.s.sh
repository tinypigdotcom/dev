#!/bin/bash
# <- my $top_comments_block = <<'END_OF_COMMENTS';
#    !!!!!!!!!
#    ! NOTE: ! DON'T "exit" ONLY "return"-this is sourced in the current shell
#    !!!!!!!!!

#    Usage:
#    $ . c b
#    $ pwd
#    /home/dbradford/bin
#    $ . c s
#    $ pwd
#    /some/arbitrarily/log/path/you/dont/want/to/type
#    (enter c by itself to get a list of u_options)
#    $ c
#    Usage: $ . c n
#    where n is one of:
#       b  cd $HOME/bin
#       s  cd /some/arbitrarily/log/path/you/dont/want/to/type
#       u  cd $HOME/utility
# <- END_OF_COMMENTS

# <- my $code = <<'END_OF_CODE';
if [ "$#" -lt 1 ]; then
    u_do_short_usage
    return $ERR_EXIT
fi

# -------------------------- Data: map u_option letter to its associated command
u_HERE_DIRS="




"

# -------------------------- Setup -------------------------------------------
u_lookup=$1
shift

# -------------------------- Create or read other directories from config file
if [ "x$HOME" != "x" ]; then
    u_UTILITY_DIR=$HOME/.utility
    u_CONFIG=$u_UTILITY_DIR/$u_PROG
    if [ ! -d "$u_UTILITY_DIR" ]; then
        mkdir $u_UTILITY_DIR
    fi
    if [ ! -f "$u_CONFIG" ]; then
        echo "# example config for $u_PROG script" >$u_CONFIG
        echo "$u_HERE_DIRS" | sed -e 's/^/#/' >>$u_CONFIG
    fi
    if [ -r "$u_CONFIG" ]; then
        u_CONFIG_DIRS=`grep -v '^ *#' $HOME/.utility/$u_PROG 2>/dev/null`
    fi
fi

# -------------------------- Display usage function --------------------------
usage() {
    echo "Usage: $ . $u_PROG n" >&2
    echo "where n is one of:" >&2
    u_i=0
    while [  $u_i -lt ${#u_option[@]} ]; do
        printf "    %-4s   ${u_cmd[$u_i]}\n" "${u_option[$u_i]}"
        let u_i=u_i+1
    done | sort -k 2 -t '#' >&2
}

# -------------------------- Read data into array ----------------------------
let u_i=0
u_option=( )
u_cmd=( )
while read u_a u_b
do
    if [ "x$u_a" == "x" ]; then
        continue
    fi
    u_option[$u_i]="$u_a"
    u_cmd[$u_i]="$u_b"
    let u_i=u_i+1
done < <(echo "$u_CONFIG_DIRS$u_HERE_DIRS" | sort )

# -------------------------- Search array for chosen u_option ------------------
u_my_cmd=
u_i=0
while [  $u_i -lt ${#u_option[@]} ]; do
    if [ "$u_lookup" == ${u_option[$u_i]} ]; then
        u_my_cmd=${u_cmd[$u_i]}
        break
    fi
    let u_i=u_i+1
done

if [ -n "$u_my_cmd" ]; then
    echo $u_my_cmd >&2
    eval $u_my_cmd
else
    usage
fi

u_do_cleanup
unset u_options
unset u_a
unset u_b
unset u_CONFIG
unset u_HERE_DIRS
unset u_CONFIG_DIRS
unset u_option
unset u_cmd
unset u_i
unset u_my_cmd
unset u_lookup
unset u_UTILITY_DIR
unset u_PROG

# <- END_OF_CODE
# <- $VAR1 = {
# <-     VERSION => '0.1.4',
# <-     PROG    => 'c',
# <-     purpose => 'shorcut script for easy change directory',
# <-     params  => 'shortcut',
# <-     example => 's',
# <-     exit    => 'return',
# <-     CODE    => $code,
# <-     top_comments_block => $top_comments_block,
# <-     target  => "$ENV{HOME}/bin/c",
# <- };

