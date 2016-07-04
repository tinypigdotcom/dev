#!/usr/bin/env perl
# <- my $code = <<'END_OF_CODE';

use DMB::Tools ':all';

sub main {
    my @argv = @_;
    my $input = multi_input();
    print "$input\n";
    my $cfh = IO::File->new("$ENV{HOME}/a.in", '>');
    if (defined $cfh) {
        print $cfh $input;
        $cfh->close;
    }
    return;
}

my $rc = ( main(@ARGV) || 0 );

exit $rc;

# <- END_OF_CODE

# <- $VAR1 = {
# <-                VERSION => '0.0.3',
# <-                purpose => 'put whatever in clipboard',
# <-                 params => '',
# <-                example => '',
# <-                   CODE => $code,
# <-                 target => "$ENV{HOME}/bin/clp",
# <-     options => [
# <-     ],
# <- };

