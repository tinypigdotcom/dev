#!/bin/bash
#perl routine credit:
#http://unix.stackexchange.com/questions/62950/getopt-getopts-or-manual-parsing-what-to-use-when-i-want-to-support-both-shor
# Built from sh.t template
# purpose: [< $purpose >]
PERL=perl
[< $exit ||= 'exit'; '' >]
[< $LICENSE >]
[< $top_comments_block >]
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
        my $ff = substr $_->{long_switch}, 0, 1;
        $_->{one_key} = $ff;
        $_->{varname} = $_->{long_switch};
        $_->{varname} =~ s/\W.*//; # turn backdate=i into backdate
    }
    return;
>]

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
[<
    for (@options) {
        next if $_->{skip_case};
        $_->{var} = "u_opt_$_->{varname}";
        $OUT .= "    unset $_->{var}\n"
    }
    return;
>]

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

u_usage() {

    u_usage_top
    cat <<EOF_usage >&2
[< $purpose >]
Example: $u_PROG [< $example >]

[<
    sub word_wrap {
        my ($maxlen,$text) = @_;

        for ($text) {
            s/^\s*//;
            s/\s*$//;
        }
        my @words = split /\s+/, $text;
        my @output;
        my $line = '';
        my $space = '';
        for ( @words ) {
            if ( length("$line $_") > $maxlen ) {
                push @output, $line;
                $line = $_;
            }
            else {
                $line .= "$space$_";
            }
            $space = ' ';
        }
        push @output, $line;
        return @output;
    }

    for (@options) {
        $_->{varname} = $_->{var} || $_->{long_switch};
        $_->{varname} =~ s/\W.*//; # turn backdate=i into backdate
        my $ls = 3;
        my $lx = $switch_max_len;
        my $firstline = sprintf(" %${ls}s, --%-${lx}s ", "-$_->{one_key}", $_->{short_desc});
        my $maxlen = 79;
        my $used = $ls + $lx + 6;
        my $tot = $maxlen - $used;
        my $spc = ' ' x $used;

        my @lines = word_wrap($tot, $_->{long_desc});

        my $pre = $firstline;
        for ( @lines ) {
            $OUT .= "${pre}$_\n";
            $pre = $spc;
        }
    }
    return;
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
        $out .= "$_->{var}=$_->{init}\n";
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
    return;
>]

parsed_ops=$(
  $PERL -MGetopt::Long -le '
    Getopt::Long::Configure ("bundling");

    my @options = (
[<
    for (@options) {
        $OUT .= qq{        "$_->{long_switch}",\n};
    }
    return;
>]
    );

    # Explicitly add single letter version of each option to allow bundling
    my @temp = @options;
    for my $letter (@temp) {
        $letter =~ s/(\w)\w*/$1/;
        next if $letter eq q{h};
        push @options, $letter;
    }
    # Fix-ups from previous routine
    push @options, q{h};

    Getopt::Long::Configure "bundling";
    $q = "'\''";
    GetOptions(@options) or exit 1;
    for ( map /(\w+)/, @options ) {
        eval "\$o=\$opt_$_";
        $o =~ s/$q/$q\\$q$q/g;
        print "u_opt_$_=$q$o$q";
    }' -- "$@"
) || u_do_exit
eval "$parsed_ops"

if [ -n "$u_opt_h" ]; then
    u_do_short_usage
fi

if [ -n "$u_opt_help" ]; then
    u_usage
    u_do_exit
fi

if [ -n "$u_opt_v$u_opt_version" ]; then
    u_version
    u_do_exit
fi

if [ -n "$u_EXIT" ]; then
    [< $exit >] $u_EXIT_STATUS
fi

[< $CODE >]

