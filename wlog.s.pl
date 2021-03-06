#!/usr/bin/env perl
# <- my $code = <<'END_OF_CODE';

use strict;

use Data::Dumper;
use DateTime;
use DateTime::Duration;
use DateTime::Format::Duration;
use IO::File;

my $dfd = DateTime::Format::Duration->new(
    pattern   => '%H:%M:%S',
    normalize => 1
);
my $mdy = '';

my $yesterday; #->
my $backdate;  #->

if ( $yesterday ) {
    $backdate = 1;
}

my $today = DateTime->now( time_zone => 'local' )->set_time_zone('floating')
  ->subtract( days => $backdate );
if ($backdate) {
    $today->set_hour(18);
    $today->set_minute(0);
    $today->set_second(0);
}

my $current_year    = $today->year;
my $current_month   = $today->month;
my $current_day     = $today->day;
my $current_hour    = $today->hour;
my $current_minutes = $today->minute;
my $current_seconds = $today->second;

print "Report for ", $today->strftime('%D'), "\n";

my $previous_dt = DateTime->new(
    year      => $current_year,
    month     => $current_month,
    day       => $current_day,
    hour      => 9,
    minute    => 00,
    second    => 00,
    time_zone => 'floating',
);

my $total_worked;

my $some_dir = '/cygdrive/c/TuSC/file';
opendir( my $dh, $some_dir ) || die "can't opendir $some_dir: $!";
my @files = grep { /^\wl/ && -f "$some_dir/$_" } readdir($dh);
closedir $dh;

my $previous_work_item = 'off';
print "${mdy}09:00:00...off\n";

my $ofh = IO::File->new( "$ENV{HOME}/a.wlog", '>' );
die if ( !defined $ofh );

my %wi;
my $item_dt;
my $dur;
for my $file (@files) {
    my @field       = split /[_\.]/, $file;
    my $item_month  = $field[2];
    my $item_day    = $field[3];
    my $item_year   = $field[1];
    my $item_hour   = $field[4];
    my $item_minute = $field[5];
    my $item_second = $field[6];

    open IN, "$some_dir/$file" or die "Can't open file $file: $!";
    my $work_item = join( '', <IN> );
    close IN;

    $work_item =~ s/[\x0a\x0d]//msg;
    if (    $current_month == $item_month
        and $current_day == $item_day
        and $current_year == $item_year
        and $work_item ne $previous_work_item
        and $work_item !~ /^sysmsg/ )
    {
        $item_dt = DateTime->new(
            year      => $item_year,
            month     => $item_month,
            day       => $item_day,
            hour      => $item_hour,
            minute    => $item_minute,
            second    => $item_second,
            time_zone => 'floating',
        );

        $dur = $item_dt - $previous_dt;
        duration_add( \$wi{$previous_work_item}, \$dur, $previous_work_item );

        $previous_dt = $item_dt;

        output("$mdy$item_hour:$item_minute:$item_second...$work_item\n");

        $previous_work_item = $work_item;
    }
}

$item_dt = DateTime->new(
    year      => $current_year,
    month     => $current_month,
    day       => $current_day,
    hour      => $current_hour,
    minute    => $current_minutes,
    second    => $current_seconds,
    time_zone => 'floating',
);

$dur = $item_dt - $previous_dt;
duration_add( \$wi{$previous_work_item}, \$dur, $previous_work_item );

my $hms = sprintf "%02d:%02d:%02d", $current_hour, $current_minutes,
  $current_seconds;
output("${mdy}$hms...end\n\n");

output("TASKS\n");
output("-----------------------------------------------------------------\n");
my %sub;
for my $key ( sort { $a cmp $b } keys %wi ) {
    next if $key =~ /off\b/;
    my $subcat;
    if ( $key =~ /(\w+)/ ) {
        $subcat = $1;
        dur_add(\$sub{$subcat}, \$wi{$key});
    }
    output( $dfd->format_duration( $wi{$key} ), " $key\n" );
}

output("\nCATEGORIES\n");
output("-----------------------------------------------------------------\n");
for my $key ( sort { $a cmp $b } keys %sub ) {
    next if $key =~ /off\b/;
    output( $dfd->format_duration( $sub{$key} ), " $key\n" );
}

output("\nTOTAL\n");
output("-----------------------------------------------------------------\n");
output( $dfd->format_duration($total_worked), "\n" );

$ofh->close;

sub duration_add {
    my ( $item_total, $plus, $work_item ) = @_;
    if ($work_item !~ /^off\b/ ) {
        dur_add( \$total_worked, $plus );
    }
    dur_add( $item_total,    $plus );
}

sub dur_add {
    my ( $item_total, $plus ) = @_;

    if ( ${$item_total} ) {
        ${$item_total} += ${$plus};
    }
    else {
        ${$item_total} = ${$plus};
    }
}

sub output {
    my $out_line = join( '', @_ );
    print $out_line;
    print $ofh $out_line;
    return;
}

# <- END_OF_CODE

# <- $VAR1 = {
# <-     VERSION => '1.15',
# <-     purpose => 'print time card',
# <-     params  => '',
# <-     example => '',
# <-     CODE    => $code,
# <-     target  => "$ENV{HOME}/bin/wlog",
# <-     options => [
# <-         {
# <-             long_switch => 'backdate=i',
# <-             short_desc  => 'backdate=#DAYS',
# <-             long_desc   => 'edit # days ago instead of today',
# <-             init        => '0',
# <-         },
# <-         {
# <-             long_switch => 'yesterday',
# <-             short_desc  => 'yesterday',
# <-             long_desc   => "edit yesterday's data instead of today's",
# <-             init        => '0',
# <-         },
# <-     ],
# <- };

