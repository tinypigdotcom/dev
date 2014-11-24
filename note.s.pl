#!/usr/bin/perl
# <- my $top_comments_block = <<'END_OF_COMMENTS';
# TODO

# MAYBE TODO
# * implement tags
# * implement delete entry
# * implement edit individual entry
# * allow input from file

# DONE
# * implement "library" like notebook in evernote (sort of)
# * -1 and -2 switch for which note file to use
# * Implement word option
# * allow for title search
# <- END_OF_COMMENTS
# <- my $code = <<'END_OF_CODE';

use strict;
use warnings FATAL => 'all';

use Data::Dumper;
use File::Basename;
use Getopt::Long;
use IO::File;

my $nf = $ENV{NOTEFILES} || "$ENV{HOME}/info/notes.txt";
my @notefiles = split ':', $nf;

my $threshold = 10;

my $separator = "%%%\n";

@notefiles = $notefiles[0] if $one;
@notefiles = $notefiles[1] if $two;

sub edit_notes {
    my $editor = $ENV{EDITOR} || 'vim';
    my $paths = join(' ', @notefiles);
    system("$editor $paths");
}

my @output_lines;
sub output {
    my $output_line = join('',@_);
    push @output_lines, $output_line;
}

sub search_note {
    my (@patterns) = @_;

    if ( $word ) {
        for (@patterns) {
            $_ = "\\b$_\\b";
        }
    }

    if ( $title ) {
        for (@patterns) {
            $_ = "^[^\\x0a\\x0d]*$_";
        }
    }

    my @notes;
    for my $file (@notefiles) {
        my $ifh = IO::File->new( $file, '<' );
        die if ( !defined $ifh );

        my $contents = do { local $/; <$ifh> };

        $ifh->close;
        push @notes, split(/^$separator/m, $contents);
    }

    my %matches;
    my %excluded;
    my $total_excluded=0;
    OUTER: for (@notes) {
        for my $pattern (@patterns) {
            next OUTER unless /$pattern/i;
        }
        if ( /^[^\x0a\x0d]*library:(\S*)/ ) {
            my $note_lib = $1;
            if ( $library ne $note_lib ) {
                $excluded{$note_lib}++;
                $total_excluded++;
                next OUTER;
            }
        }
        else {
            if ( $library ) {
                $excluded{no_library}++;
                $total_excluded++;
                next OUTER;
            }
        }
        s/^/  /mg;
        $matches{$_}++;
    }
    my $output_separator = "\n" . '+' . '=' x 78 . "\n|";
    my $title_separator  = "\n" . '+' . '-' x 68 . "\n";
    my $gpg_file = "$ENV{HOME}/.note.gpg";
    if (%matches) {
        my $total_matches = scalar keys %matches;
        if ( $total_matches > $threshold ) {
            print "Found $total_matches matches. Continue (Y/n) ? ";
            my $junk = <STDIN>;
            chomp $junk;
            if ( $junk =~ /n/i ) {
                exit;
            }
        }
        my $content;
        for my $match (keys %matches) {
            my @lines = split "\n", $match;
            my $title = shift @lines;
            $title =~ s/^\s*//;
            my $body = join "\n", @lines;
            $body =~ s/\s*$//s;
            output $output_separator,
                   " $title",
                   $title_separator;
            $content='';
            if ($body =~ s/[[]<(.*)>[]]/$1/sg) {
                $content = $1;
                print "content {$content}\n";
            }
            if ($body =~ /BEGIN PGP MESSAGE.*END PGP MESSAGE/s) {
                my $ofh = IO::File->new($gpg_file, '>');
                die if (!defined $ofh);
                $body =~ s/^ *//mg;
                print $ofh $body;
                $ofh->close;
                if ( -r $gpg_file ) {
                    system("gpg --decrypt $gpg_file && rm $gpg_file");
                }
            }
            else {
                output $body, "\n";
                my $cfh = IO::File->new('/dev/clipboard', '>');
                if (defined $cfh) {
                    my $to_copy = $content || $body;
                    print $cfh $to_copy;
                    $cfh->close;
                }
            }
        }
        output "\n";
    }
    else {
        output "No match.\n";
    }
    if ( $Verbose && $total_excluded ) {
        my $entries = $total_excluded == 1 ? 'entry' : 'entries';
        my $were    = $total_excluded == 1 ? 'was'   : 'were';
        output "($total_excluded $entries $were excluded in other libraries- ";
        for ( keys %excluded ) {
            output "$_:$excluded{$_} ";
        }
        output ")\n";
    }
    open O, '| less -FX' or die;
    print O @output_lines;
    close O;

    return;
}

sub add_note {
    my $note;
    while (my $input_line = <STDIN>) {
        $note .= $input_line;
    }

    my $ofh = IO::File->new( $notefiles[0], '>>' );
    die if ( !defined $ofh );

    print $ofh "${separator}${note}\n";
    $ofh->close;
    warn "*** 1 note added to $notefiles[0]\n";

    return;
}

sub main {
    my (@patterns) = @_;

    if    ($add)      { return add_note()               }
    elsif ($edit)     { return edit_notes()             }
    elsif (@patterns) { return search_note( @patterns ) }
    else              { return do_short_usage()         }

    die "Boom."; # This code should never be reached
    return;
}

my $rc = ( main(@ARGV) || 0 );

exit $rc;


# <- END_OF_CODE

# <- $VAR1 = {
# <-                VERSION => '0.9.7',
# <-                purpose => 'quickly store and retrieve small pieces of information',
# <-                 params => '[OPTION]... PATTERN..',
# <-                example => '-2w lawnmower',
# <-                   CODE => $code,
# <-     top_comments_block => $top_comments_block,
# <-                 target => "$ENV{HOME}/bin/note",
# <-     options => [
# <-         {
# <-             long_switch => 'library=s',
# <-              short_desc => 'library=LIBRARY',
# <-               long_desc => 'Search a specific library',
# <-                    init => "''",
# <-         },
# <-         {
# <-             long_switch => '1',
# <-              short_desc => '1',
# <-               long_desc => "use notefile #1",
# <-                    init => '0',
# <-                     var => 'one',
# <-         },
# <-         {
# <-             long_switch => '2',
# <-              short_desc => '2',
# <-               long_desc => "use notefile #2",
# <-                    init => '0',
# <-                     var => 'two',
# <-         },
# <-         {
# <-             long_switch => 'add',
# <-              short_desc => 'add',
# <-               long_desc => "add a note",
# <-                    init => '0',
# <-         },
# <-         {
# <-             long_switch => 'edit',
# <-              short_desc => 'edit',
# <-               long_desc => "edit the notes file",
# <-                    init => '0',
# <-         },
# <-         {
# <-             long_switch => 'title',
# <-              short_desc => 'title',
# <-               long_desc => "search title only",
# <-                    init => '0',
# <-         },
# <-         {
# <-             long_switch => 'Verbose',
# <-              short_desc => 'Verbose',
# <-               long_desc => "show additional information about entries matched / not matched",
# <-                    init => '0',
# <-         },
# <-         {
# <-             long_switch => 'word',
# <-              short_desc => 'word',
# <-               long_desc => "only find if PATTERN is a word",
# <-                    init => '0',
# <-         },
# <-     ],
# <- };

