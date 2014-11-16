#!/bin/bash

VERSION=0.0.1
PROG=`basename $0`
USAGE_FIRST_LINE="Usage: $PROG [OPTION]... [FILE]..."

errout() {
    cat <<EOF_errout >&2
$PROG: $*
$USAGE_FIRST_LINE
Try '$PROG --help' for more information.
EOF_errout

    exit 1
}

usage() {

    cat <<EOF_usage >&2
$USAGE_FIRST_LINE
Search for whatchamacallit in each FILE or standard input.
Example: $PROG -i 'hello world' menu.h main.c

  -h, --help                display this help text and exit
  -v, --version             display version information and exit
  -f, --foo=ACTION          do foo things:
                            ACTION is 'bar', 'baz', or 'bletch'
EOF_usage

}

OPTS=`getopt -o vhf -l 'version,help,foo:' -- "$@"`
if [ $? != 0 ]; then
    usage
    exit 1
fi

eval set -- "$OPTS"

OPT_f=0
OPT_foo=

while [ $# -gt 0 ]
do
    case "$1" in
               -f) OPT_f=1
                   ;;
      -h | --help) usage
                   exit
                   ;;
            --foo) OPT_foo=$2
                   shift # extra shift for argument to foo
                   ;;
   -v | --version) echo "$PROG $VERSION" >&2
                   exit
                   ;;
               --) shift
                   break
                   ;;
                *) errout "Invalid option: $1"
                   ;;
    esac
    shift
done

echo "Remaining args:"
for ipsum
do
    echo $ipsum
done

if [ "$OPT_f" -eq 1 ]; then
    echo "f stuff happens here" >&2
fi

if [ "$OPT_foo" != "" ]; then
    echo "foo stuff happens here: $OPT_foo" >&2
fi

