#!/bin/bash
# <- my $top_comments_block = <<'END_OF_COMMENTS';
# These comments come first.
# <- END_OF_COMMENTS

#    $ t a foo
#    task add foo due:today;sleep 1;~/taskrpt
#    Created task 235.
#    $ t b 235
#    task 235 modify pri:M
#    Modifying task 235 'foo'.
#    Modified 1 task.
#    $ t i 235
#    echo n | task 235 rc.confirmation:no delete;sleep 1;~/taskrpt
#    Deleting task 235 'foo'.
#    Deleted 1 task.
#    Usage: $ t n
#    where n is one of:
#           a   task add $* due:today;sleep 1;~/taskrpt
#           b   task $* modify pri:M
#           i   echo n | task $* rc.confirmation:no delete;sleep 1;~/taskrpt
#           l   task rc._forcecolor:on list | less -R
#           n   task now;echo task now >/home/dave/taskrpt
#           x   task $* done;sleep 1;~/taskrpt

# -------------------------- Data: map option letter to its associated command
#     h  task proj:heap; echo task proj:heap >$HOME/taskrpt
#     i  echo n | task \$* rc.confirmation:no delete;sleep 1;~/taskrpt
#     j  task proj:job;echo task proj:job >$HOME/taskrpt
#     u  echo n | task \$* modify -postponed;sleep 1;~/taskrpt
#     l  task rc._forcecolor:on list | less -R

# <- my $code = <<'END_OF_CODE';

A="


     a  task add \$*
     b  task \$* modify pri:M
     c  task \$* modify pri:L
     l  task
     o  task proj:tools
     p  task proj:presentations
     r  task proj:articles
     t  task pri:H or pri:M or pri:L
     x  task \$* done


"

# -------------------------- Setup -------------------------------------------
lookup=$1
shift

# -------------------------- Display usage function --------------------------
usage() {
    echo "Usage: $ $PROG n" >&2
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
done < <(echo "$A" )

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
# <-     purpose => 'shortcut script for task warrior',
# <-     params  => 'shortcut',
# <-     example => 'x',
# <-     CODE    => $code,
# <-     top_comments_block => $top_comments_block,
# <-     target  => "$ENV{HOME}/bin/t",
# <- };

