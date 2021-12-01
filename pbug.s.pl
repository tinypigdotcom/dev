#!/usr/bin/env perl
# <- my $code = <<'END_OF_CODE';

use IO::File;
use File::Temp qw/ tempfile /;
use File::Copy;

my ($infile) = @ARGV;

my $ifh = IO::File->new($infile, '<');
die if (!defined $ifh);

my ($fh, $outfile) = tempfile();

my $count = 1;
my $debug_on = 0;
while(<$ifh>) {
    chomp;

    if ( /END_DEBUG/ ) {
        $debug_on = 0;
    }

    if ( /debug \d\d\d/ ) {
        my $pcount = sprintf('%03d', $count++);
        s/debug \d\d\d/debug $pcount/;
    }
    elsif ( $debug_on ) {
        my $pcount = sprintf('%03d', $count++);
        print $fh qq{warn "debug $pcount";\n};
    }
    print $fh "$_\n";

    if ( /START_DEBUG/ ) {
        $debug_on = 1;
    }
}
$ifh->close;
$fh->close;

copy($outfile, $infile) or die "Copy failed: $!";

$count--; # Started on 1, so decrement for correct count
warn "Updated $count debug statements\n";


# <- END_OF_CODE

# <- $VAR1 = {
# <-                VERSION => '0.0.2',
# <-                purpose => 'insert/renumber perl "debug 001" statements',
# <-                 params => '',
# <-                example => 'prog.pl',
# <-                   CODE => $code,
# <-                 target => "$ENV{HOME}/bin/pbug",
# <-     options => [
# <-     ],
# <- };

