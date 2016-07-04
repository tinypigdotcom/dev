#!/usr/bin/env perl
# <- my $code = <<'END_OF_CODE';

# TODO
# * create tests which could fix dumb errors

use strict;

package ComsScript {
    use Carp;
    use Data::Dumper;
    use Hash::Util qw(lock_keys);
    our $VAR1;
    my $persist_file = "$ENV{HOME}/.coms_script";
    my $do_persist   = 0;
    my $DEBUG        = 0;

    my @keys = qw( );

    sub run {
        my $self = shift;
        $self->main_coms_run(@_);
        return 0;    # return for entire script
    }

    sub main_coms_run {
        my ($self, $pattern) = @_;

        chdir $ENV{HOME} || die "can't chdir $ENV{HOME}: $!";
        my @bins = grep { /^bin\d?/ && -d "./$_" } get_directory();
        my @files;
        my %comsignore;
        for my $bin (@bins) {
            push @files,
              map { "$bin/$_" }
              grep { !/^\./ && !-d "$bin/$_" } get_directory($bin);
            my $ignorefile = "$bin/.comsignore";
            if ( -r $ignorefile ) {

                my $ifh = IO::File->new( $ignorefile, '<' );
                die if ( !defined $ifh );

                while (<$ifh>) {
                    chomp;
                    s/^\s*//;
                    s/\s*$//;
                    $comsignore{"$bin/$_"}++;
                }
                $ifh->close;

            }
        }

        my $print_file;
        my $print_text;
        for my $file (@files) {
            my $ifh = IO::File->new( $file, '<' );
            die "can't open $file: $!" if ( !defined $ifh );

            my $found = 0;
            next if $comsignore{$file};
            while (<$ifh>) {
                chomp;
                if (/#\s*purpose:\s*(.*)/) {
                    $found++;
                    my $text = $1;
                    if ($text) {
                        $print_file = $file;
                        $print_text = $text;
                    }
                    last;
                }
            }
            $ifh->close;
            if ( !$found ) {
                $print_file = $file;
                $print_text = '???';
            }
            my $output_line = sprintf( "%-25s $print_text", $print_file );
            if ( !$pattern || ( $pattern && $output_line =~ /$pattern/i ) ) {
                print "$output_line\n";
            }
        }
    }

 # ================== END MAIN =================================================

    sub new {
        my ($class) = @_;

        my $self = {};
        bless $self, $class;
        lock_keys( %$self, @keys );

        return $self;
    }

   # example
   # my @dot_files = grep { /^\./ && -f "$some_dir/$_" } get_directory($target);
    sub get_directory {
        croak "This is a function, not a method" if ( ref $_[0] );

        my ($dir) = @_;
        $dir ||= '.';

        opendir( my $dh, $dir ) || die "can't opendir $dir: $!";
        my @files = readdir($dh);
        closedir $dh;

        return @files;
    }
}

package main;

my $app = ComsScript->new();
exit $app->run(@ARGV);

# <- END_OF_CODE
# <- $VAR1 = {
# <-     VERSION => '0.1.5',
# <-     purpose => 'list all personal commands on this system',
# <-     example => '',
# <-     CODE    => $code,
# <-     target  => "$ENV{HOME}/bin/coms",
# <- };

