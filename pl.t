#!/usr/bin/perl
# Built from perl.t template
# purpose: [< $purpose >]

[< $LICENSE >]
[< $top_comments_block >]
use 5.16.0;
use warnings FATAL => 'all';

use File::Basename;
use Getopt::Long;

our $VERSION = '[< $VERSION >]';

my $PROG = basename($0);
my $ERR_EXIT = 2;

sub usage_top {
    warn "Usage: $PROG [OPTION]...\n";
}

sub short_usage {
    usage_top();
    warn "Try '$PROG --help' for more information.\n";
}

sub errout {
    my $message = join( ' ', @_ );
    warn "$PROG: $message\n";
    short_usage();
    exit $ERR_EXIT;
}

[<
    $switch_max_len=0;
    unshift @options,
    {
        long_switch => 'help',
        short_desc  => 'help',
        long_desc   => 'display this help text and exit',
        init        => '0',
    },
    {
        long_switch => 'version',
        short_desc  => 'version',
        long_desc   => 'display version information and exit',
        init        => '0',
    };
    for (@options) {
        my $len = length $_->{short_desc};
        $switch_max_len = $len if $len > $switch_max_len;
    }
    return;
>]

sub usage {
    usage_top();
    warn <<EOF;
[< $purpose >]
Example: $PROG [< $example >]

[<
    for (@options) {
        my $ff = substr $_->{long_switch}, 0, 1;
        $_->{one_key} = $ff;
        $_->{varname} = $_->{long_switch};
        $_->{varname} =~ s/\W.*//; # turn backdate=i into backdate
        $OUT .= sprintf(" %3s, --%-${switch_max_len}s $_->{long_desc}\n", "-$ff", $_->{short_desc});
    }
    return;
>]
EOF
    return;
}

sub do_short_usage {
    short_usage();
    exit $ERR_EXIT;
}

sub version {
    warn "$PROG $VERSION\n";
    return;
}

[<
    my $fmt = $switch_max_len + 2;
    $OUT .= sprintf("my %-${fmt}s = 0;\n", "\$h");
    for (@options) {
        $OUT .= sprintf("my %-${fmt}s = $_->{init};\n", "\$$_->{varname}");
    }
    return;
>]

Getopt::Long::Configure ("bundling");

my %options = (
[<
    for (@options) {
        $OUT .= sprintf("    \"%-${switch_max_len}s => \\\$$_->{varname},\n", "$_->{long_switch}\"");
    }
    return;
>]
);

# Explicitly add single letter version of each option to allow bundling
my ($key, $value);
my %temp = %options;
while (($key,$value) = each %temp) {
    my $letter = $key;
    $letter =~ s/(\w)\w*/$1/;
    $options{$letter} = $value;
}
# Fix-ups from previous routine
$options{h} = \$h;

GetOptions(%options) or errout("Error in command line arguments");

if    ($help)     { usage(); exit    }
elsif ($h)        { do_short_usage() }
elsif ($version)  { version(); exit  }

[< $CODE >]

