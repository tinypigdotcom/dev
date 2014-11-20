#!/bin/bash
# Built from sh.t template
# purpose: [< $purpose >]
[< $exit ||= 'exit'; '' >]
[< $LICENSE >]
[< $top_comments_block >]

u_do_init() {
    u_VERSION=[< $VERSION >]
    u_PROG=[< $PROG || '`basename $0`' >]
    u_EXIT=
    u_ERR_EXIT=2
}

u_do_cleanup() {
    unset u_VERSION
    unset u_PROG
    unset u_EXIT
    unset u_ERR_EXIT
    unset u_EXIT_STATUS
    unset u_OPTS
    unset FIXMEEEEEEEE_u_OPT_

    unset -f u_do_cleanup
    unset -f u_do_exit
    unset -f u_do_init
    unset -f u_do_short_usage
    unset -f u_errout
    unset -f u_short_usage
    unset -f u_usage
    unset -f u_usage_top
    unset -f u_version
}

u_do_exit() {
    u_do_cleanup
    u_EXIT=1
    [< $exit >] $u_EXIT_STATUS
}

u_usage_top()   {
    echo "Usage: $u_PROG [< $params >]" >&2
}

u_short_usage() {
    u_usage_top
    echo "Try '$u_PROG --help' for more information." >&2
}

u_errout() {
    echo "$u_PROG: $*" >&2
    u_short_usage
    u_EXIT_STATUS=$u_ERR_EXIT
    u_do_exit
}

u_do_init

[<
$switch_max_len=0;
unshift @options,
{
    long_switch => 'help',
    short_desc  => 'help',
    long_desc   => 'display this help text and exit',
    init        => '0',
    skip_case   => 1,
},
{
    long_switch => 'version',
    short_desc  => 'version',
    long_desc   => 'display version information and exit',
    init        => '0',
    skip_case   => 1,
};
for (@options) {
    my $len = length $_->{short_desc};
    $switch_max_len = $len if $len > $switch_max_len;
}
>]

u_usage() {

    u_usage_top
    cat <<EOF_usage >&2
[< $purpose >]
Example: $PROG [< $example >]

[<
    for (@options) {
        my $ff = substr $_->{long_switch}, 0, 1;
        $_->{one_key} = $ff;
        $_->{varname} = $_->{long_switch};
        $_->{varname} =~ s/\W.*//; # turn backdate=i into backdate
        $OUT .= sprintf(" %3s, --%-${switch_max_len}s  $_->{long_desc}\n", "-$ff", $_->{short_desc});
    }
>]
EOF_usage

}

u_do_short_usage() {
    u_short_usage
    u_EXIT_STATUS=$u_ERR_EXIT
    u_do_exit
}

u_version() {
   echo "$u_PROG $u_VERSION" >&2
}

[<
    for (@options) {
        my $var = 'OPT_' . uc($_->{varname});
        $out .= "$var=$_->{init}\n";
    }
    $single_keys='';
    @long_opts=();
    for (@options) {
        my $sk = $_->{long_switch};
        $sk =~ s/(\w)\w*(.*)/$1$2/;
        if ( $2 ) {
            $_->{has_arg}=1;
        }
        $single_keys .= $sk;
        push @long_opts, $_->{long_switch};
    }
    $long_opts = join ',', @long_opts;
    return '';
>]

u_OPTS=`getopt -o [< $single_keys >] -l '[< $long_opts >]' -- "$@"`
if [ $? != 0 ]; then
    u_short_usage
    u_EXIT_STATUS=$u_ERR_EXIT
    u_do_exit
fi

eval set -- "$u_OPTS"

while [ $# -gt 0 ]
do
    case "$1" in
               -h) u_do_short_usage
                   ;;
           --help) u_usage
                   u_do_exit
                   ;;
   -v | --version) u_version
                   u_do_exit
                   ;;

[<
    for (@options) {
        next if $_->{skip_case};
        my $var = 'u_OPT_' . uc($_->{varname});
        my $ext = '';
        if ( $_->{has_arg} ) {
            $ext = "; ${var}_ARG=$2; shift";
        }
        $OUT .= sprintf(" %17s $var=1$ext\n", "-$_->{one_key} | --$_->{varname})");
        $OUT .= "                   ;;\n";
    }
>]

               --) shift
                   break
                   ;;
                *) u_errout "Invalid option: $1"
                   ;;
    esac
    shift
done

if [ -n "$u_EXIT" ]; then
    [< $exit >] $u_EXIT_STATUS
fi

[< $CODE >]

