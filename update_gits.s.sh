#!/bin/bash
# <- my $code = <<'END_OF_CODE';

SKIPFILE=.upd_skip
GITLIST=$HOME/.update_gits
if [ -d /cygdrive ]; then
    ROOT_DIR=/cygdrive
else
    ROOT_DIR=/
fi

echo
echo -n "Started "
date +'%F %T'

REASON=
if [ ! -f $GITLIST ]; then
    REASON="index file was not found"
else
    ONE_WEEK=$(expr 60 \* 60 \* 24 \* 7)
    NOW=$(date +%s)

    MOD_EPOCH=$(stat -c %Y $GITLIST)
    DIFF=$(expr $NOW - $MOD_EPOCH)

    MOD_DATE=$(stat -c %y $GITLIST)
    MOD_DATE=${MOD_DATE%%.*}

    STALE=
    if [ "$DIFF" -gt "$ONE_WEEK" ]; then
        REASON="index file out-of-date"
    fi
    echo "Last index update: $MOD_DATE"
fi
echo

if [ -n "$u_OPT_REBUILD" ]; then
    REASON="forced via command line switch '-r'"
fi

if [ -n "$REASON" ]; then
    echo "Rebuilding index ($REASON)" >&2
    echo
    rm -f $GITLIST
    find $ROOT_DIR -type d -name .git 2>/dev/null | while read a
    do
        cd "$a/.."
        mv upd_skip $SKIPFILE 2>/dev/null # remove after all upgraded
        if [ -f $SKIPFILE ]; then
            echo "(skipping $a)"
            continue
        fi
        echo $a >>$GITLIST
    done
    echo
fi

while read a
do
    cd "$a/.."
    mv upd_skip $SKIPFILE 2>/dev/null # remove after all upgraded

    if [ -f $SKIPFILE ]; then
        echo "(skipping $a)"
        continue
    fi

    status=$(git status -s 2>&1)
    status_status=$?
    pull=$(git pull 2>&1)
    pull_status=$?

    push=$(git push origin master 2>&1)
    push_status=$?


    if [[ $pull =~ No\ remote\ repository\ specified ]] ; then
        touch $SKIPFILE
        echo "(skipping $a)"
        continue
    fi

    if [ -z "$status" -a "$pull" == "Already up-to-date." -a "$push" == "Everything up-to-date" ]; then
        echo "[OK] $a "
    else
        if [ "$pull" == "Already up-to-date." -a "$push" == "Everything up-to-date" ]; then
            echo "[OK] $a "
            if [ -n "$status" ]; then
                echo "$status"
            fi
        else
            echo "**** $a "
            if [ -n "$status" ]; then
                echo "$status"
            fi
            echo "$pull"
            echo "$push"
        fi
        echo
    fi

done <$GITLIST

cmp $HOME/.vimrc $HOME/.vim/_vimrc
diff $HOME/.vimrc $HOME/.vim/_vimrc
cmp $HOME/.bash_profile $HOME/utility/_bash_profile
diff $HOME/.bash_profile $HOME/utility/_bash_profile

echo
cd $HOME/tests;./tt

echo
echo -n "Finished "
date +'%F %T'
echo

# <- END_OF_CODE
# <- $VAR1 = {
# <-     VERSION => '1.1.0',
# <-     purpose => 'update all git directories on this system',
# <-     params => '[OPTION]...',
# <-     example => '-r',
# <-     CODE    => $code,
# <-     target  => "$ENV{HOME}/bin/update_gits",
# <-     options => [
# <-         {
# <-             long_switch => 'rebuild',
# <-             short_desc  => 'rebuild',
# <-             long_desc   => 'rebuild list of .git directories',
# <-             init        => '0',
# <-         },
# <-     ],
# <- };

