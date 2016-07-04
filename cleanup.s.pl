#!/usr/bin/env perl
# <- my $code = <<'END_OF_CODE';

use 5.16.0;
use warnings FATAL => 'all';

use Data::Dumper;
use IO::File;

# weekly, move all but exceptions into 30 day folder by week: MMDD/
# exceptions come from config but some can be static

use File::Copy;

my @skip_files = qw(
tmp sandbox2 lib data bin2 info archive sandbox bin dev trashcan temp tests
rsync docs utility reports Dropbox_info
);
my %skip;
@skip{@skip_files} = (1) x @skip_files;

sub init {
    my $skipfile = "$ENV{HOME}/.skip_cleanup";
    my $ifh = IO::File->new( $skipfile, '<' )
      or die
      "First create $skipfile, containing files and directories to skip.\n";
    die if ( !defined $ifh );

    while (<$ifh>) {
        chomp;
        $skip{$_}++;
    }
    $ifh->close;
}

# example
# my @dot_files = grep { /^\./ && -f "$some_dir/$_" } get_directory($target);
sub get_directory {
    my ($dir) = @_;
    opendir( my $dh, $dir ) || die "can't opendir $dir: $!";
    my @files = readdir($dh);
    closedir $dh;
    return @files;
}

sub timestamp {
    my ( $sec, $min, $hour, $mday, $mon, $year ) = localtime(time);

    $mon++;
    $year += 1900;

    return sprintf( "%04s_%02s_%02s", $year, $mon, $mday );
}

sub clean_home {
    my $target = $ENV{HOME};
    my @files = grep { !/^\./ && !-l && !$skip{$_} } get_directory($target);
    my $archive_dir = "$ENV{HOME}/archive/";
    mkdir $archive_dir;
    my $newdir = $archive_dir . timestamp();
    mkdir $newdir;
    for (@files) {
        my $source = "$ENV{HOME}/$_";
        my $target = "$newdir/$_";
        print "archiving $_\n";
        move( $source, $target ) or die "Move failed: $!";
    }
}

sub main {
    my @argv = @_;
    init();
    clean_home();
    return;
}

my $rc = ( main(@ARGV) || 0 );

exit $rc;

# <- END_OF_CODE

# <- $VAR1 = {
# <-     VERSION => '0.0.1',
# <-     purpose => 'clean up files from home directory',
# <-     example => '',
# <-     CODE    => $code,
# <-     target  => "$ENV{HOME}/bin/cleanup",
# <- };

