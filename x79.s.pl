#!/usr/bin/perl
# <- my $code = <<'END_OF_CODE';

use DMB::Tools ':all';

sub main {
    my @argv = @_;
    my $input = multi_input();
    my $output;
    while ( $input =~ /(.{1,79})/g ) {
        $output .= "$1\n";
    }
    print "$output\n";
    my $cfh = IO::File->new('/dev/clipboard', '>');
    if (defined $cfh) {
        print $cfh $output;
        $cfh->close;
    }
    return;
}

my $rc = ( main(@ARGV) || 0 );

exit $rc;

# <- END_OF_CODE

# <- $VAR1 = {
# <-                VERSION => '0.0.1',
# <-                purpose => 'convert to 79 columns',
# <-                 params => '',
# <-                example => '',
# <-                   CODE => $code,
# <-                 target => "$ENV{HOME}/bin/x79",
# <-     options => [
# <-     ],
# <- };

