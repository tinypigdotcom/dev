#!/usr/bin/perl
# <- my $code = <<'END_OF_CODE';

use strict;
use warnings FATAL => 'all';

use IO::File;

sub get_file_lines {
    my $file = shift;
    my $ifh = IO::File->new($file, '<');
    die if (!defined $ifh);
    my @lines = map { chomp;$_ } <$ifh>;
    $ifh->close;
    return @lines;
}

sub compare {
    my @files = @_;
    my %val1 = map { $_ => 1 } get_file_lines($files[0]);
    my %val2 = map { $_ => 1 } get_file_lines($files[1]);
    print "\nIn $files[0], not in $files[1]:\n";
    for (sort { $a cmp $b } keys %val1) {
        print "$_\n" unless $val2{$_};
    }
    print "\nIn $files[1], not in $files[0]:\n";
    for (sort { $a cmp $b } keys %val2) {
        print "$_\n" unless $val1{$_};
    }
}

sub main {
    my @argv = @_;
    my @files = @argv;
    die "Must have exactly 2 filename arguments.\n" unless @files == 2;
    compare(@files);
    return;
}

my $rc = ( main(@ARGV) || 0 );

exit $rc;

# <- END_OF_CODE

# <- $VAR1 = {
# <-                VERSION => '0.0.1',
# <-                purpose => 'diff two files like they were hashes',
# <-                 params => 'FILE1 FILE2',
# <-                example => 'old_coords.txt new_coords.txt',
# <-                   CODE => $code,
# <-                 target => "$ENV{HOME}/bin/hashdiff",
# <- };

