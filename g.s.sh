#!/bin/bash
# <- my $top_comments_block = <<'END_OF_COMMENTS';
#    $ g a myfile
#    git add myfile
#    $ g s
#    git status -s
#    M  myfile
#    ?? myfile.old
#    $ g
#    Usage: $ g n
#    where n is one of:
#           a   git add $*
#           c   git commit -a
#          cl   git clone git@github.com:tinypigdotcom/utility.git
#           d   git checkout develop $*
#           m   git checkout master $*
#          pm   git push origin master $*
#           s   git status -s $*
#
# <- END_OF_COMMENTS
# <- my $code = <<'END_OF_CODE';

# -------------------------- Data: map option letter to its associated command
A='


    a      git add $*                  # Add
    b      git branch                  # Branch
    c      git commit -a               # Commit All
    ca     git commit -a -m "$*"       # Commit All With Message
    cm     git commit -m "$*"          # Commit With Message
    v      git checkout develop $*     # Develop Checkout
    d      git diff $*                 # Diff
    m      git checkout master $*      # Master Checkout
    pd     git push origin develop $*  # Push Develop
    pm     git push origin master $*   # Push Master
    rev    git checkout $*             # Revert
    s      git status -s $*            # Status


'

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
        printf "    %-4s   ${cmd[$i]}\n" "${option[$i]}"
        let i=i+1
    done | sort -k 2 -t '#' >&2
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
# <-     VERSION => '1.1.4',
# <-     purpose => 'shorcut script for git commands',
# <-     params  => 'shortcut',
# <-     example => 'x',
# <-     CODE    => $code,
# <-     top_comments_block => $top_comments_block,
# <-     target  => "$ENV{HOME}/bin/g",
# <- };

