#!/usr/bin/env perl
# <- my $code = <<'END_OF_CODE';

use 5.16.0;
use warnings FATAL => 'all';

use Data::Dumper;
use Filesys::DiskUsage qw(du);
use IO::File;
use Archive::Tar;

# Backup: create tarball of essential parts of home directory for download

use File::Copy;

my @skip_files = qw(
tmp sandbox2 lib data bin2 info archive sandbox bin dev trashcan temp tests
rsync docs utility reports Dropbox_info
);
my %skip;
@skip{@skip_files} = (1) x @skip_files;

sub init {
    my $skipfile = "$ENV{HOME}/.skip_backup";
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

sub get_subdirectory_files {
    my @dirs = @_;
    my $list = [];
    find({ wanted => sub {
        return if -d $File::Find::name;
        push @$list, $File::Find::name;
    }, no_chdir => 1 }, @dirs);

    return $list;
}

sub timestamp {
    my ( $sec, $min, $hour, $mday, $mon, $year ) = localtime(time);

    $mon++;
    $year += 1900;

    return sprintf( "%04s_%02s_%02s", $year, $mon, $mday );
}

sub get_du {
    my (@files) = @_;
    return unless @files;

    my %sizes = du({'make-hash' => 1}, @files);
    my @return_sizes;
    foreach my $entry (sort { $sizes{$a} <=> $sizes{$b} } keys %sizes) {
        my $size = $sizes{$entry};
        if ( $size < 1000 ) {
            $size = 1000;
        }
        $size =~ s/...$//;
        push @return_sizes, [$size, $entry];
    }

    return @return_sizes;
}

sub backup_home {
    print "Calculating file sizes...\n";

    my $target = $ENV{HOME};
    my @files = grep { !/^\.\.?$/ && !-l && !$skip{$_} } get_directory($target);
    my @sizes = get_du(@files);
    my $total = 0;
    for my $file (@sizes) {
        printf "%10s: %s\n", @$file;
        $total += $file->[0];
    }
    printf "%10s: Total\n", $total;
    print "Continue (Y/N)? ";
    my $answer = <STDIN>;
    chomp $answer;
    if ( $answer ne 'Y' ) {
        die "Aborted\n";
    }

    my $backup_filename = "$ENV{HOME}/backup." . timestamp();
    print "Creating archive $backup_filename...\n";

    my @full_files;
    for my $file (@files) {
        if (-d $file) {
            my $list = get_subdirectory_files($file);
            push @full_files, @$list;
        }
        else {
            push @full_files, $file;
        }
    }

    Archive::Tar->create_archive( "$backup_filename.tbz", COMPRESS_BZIP, @full_files );
}

sub main {
    my @argv = @_;
    init();
    backup_home();
    return;
}

my $rc = ( main(@ARGV) || 0 );

exit $rc;

# <- END_OF_CODE

# <- $VAR1 = {
# <-     VERSION => '0.0.1',
# <-     purpose => 'backup files from home directory',
# <-     example => '',
# <-     CODE    => $code,
# <-     target  => "$ENV{HOME}/bin/backup",
# <- };

