#!/usr/bin/perl
# <- my $code = <<'END_OF_CODE';

use 5.16.0;

use Carp;
use Data::Dumper;
use IO::File;
use Text::Template;

my $error = '';

sub my_broken {
   my %args = @_;
   my $err_ref = $args{arg};
   my $error = $args{error};
   chomp $error;
   $$err_ref = "ERROR: $error in:\n$args{text}";
   return undef;
}

my $ext;

if ( !@ARGV ) {
    do_short_usage();
}

my $infile = shift @ARGV;
my $outfile = $infile;

if ( $outfile =~ /\.s\.([^.]*)$/ ) {
    $ext = $1;
}

if ( ! -f "$ext.t" ) {
    errout("template $ext.t not found");
}

if ( $outfile =~ s/\.s\.${ext}$/\.${ext}/ ) {
}
else {
    $outfile .= ".${ext}";
}

my $VAR1;
sub dump_read {
    my $ifh = IO::File->new($infile, '<');
    croak if (!defined $ifh);

    my $contents;
    my $line = 1;
    while (<$ifh>) {
        chomp;
        if ( $line++ == 1 ) {
            next if /^#!/;
        }
        s/^#\s*<-\s*//;
        if ( !/\s*#->$/ ) {
            $contents .= "$_\n";
        }
    }
    $ifh->close;

    my $data = eval $contents; ## no critic
    if ( !defined $data ) {
        croak "failed eval of dump";
    }
    return;
}

my $open_delimiter  = '[<';
my $close_delimiter = '>]';

my $license_template = Text::Template->new(
    SOURCE     => 'LICENSE.t',
    DELIMITERS => [ $open_delimiter, $close_delimiter ],
) or die "Couldn't construct template: $Text::Template::ERROR";

my $year = sprintf("%04s",(localtime(time))[5] + 1900);
my %license_vars = ( year => $year );

my $license_result = $license_template->fill_in(
    PREPEND    => q{
        use strict;
        use vars qw( $year );
    },
    BROKEN     => \&my_broken,
    BROKEN_ARG => \$error,
    HASH       => \%license_vars,
);

if ($error) {
    die "$error\n";
}

if (! defined $license_result) {
    die "Couldn't fill in license template: $Text::Template::ERROR";
}

my $template = Text::Template->new(
    SOURCE     => "${ext}.t",
    DELIMITERS => [ $open_delimiter, $close_delimiter ],
) or die "Couldn't construct template: $Text::Template::ERROR";

dump_read();
my %vars = %$VAR1;
$vars{LICENSE}=$license_result;

my $result = $template->fill_in(
     BROKEN     => \&my_broken,
     BROKEN_ARG => \$error,
     PREPEND    => q{
         use strict;
         use vars qw( $exit $PROG $purpose $LICENSE $VERSION $params $example
         $CODE $long_opts $out $single_keys $switch_max_len $top_comments_block
         @long_opts @options );
     },
    HASH => \%vars,
);

if ($error) {
    die "$error\n";
}

if (! defined $result) {
    die "Couldn't fill in template: $Text::Template::ERROR";
}

if ( $vars{target} ) {
    $outfile = $vars{target};
}

my $ofh = IO::File->new($outfile, '>');
die "can't create $outfile: $!" if (!defined $ofh);

print $ofh "$result";
$ofh->close;

my $mode = 0700; chmod $mode, $outfile;

# <- END_OF_CODE

# <- $VAR1 = {
# <-     VERSION => '0.0.4',
# <-     purpose => 'build programs from template',
# <-     params  => 'file',
# <-     example => 'spiffy.s.pl',
# <-     CODE    => $code,
# <-     target  => "mcc",
# <- };

