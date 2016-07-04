#!/usr/bin/env perl
# <- my $code = <<'END_OF_CODE';

use 5.14.0;
use autodie;
use warnings;

my %new_time_hash = (
    hours   => 0,
    minutes => 0,
    seconds => 0,
);
my %total = %new_time_hash;
my %subtotal = %new_time_hash;

sub get_total {
    return get_subtotal(\%total);
}

sub get_subtotal {
    my ($ref) = @_;
    $ref->{minutes} += int($ref->{seconds} / 60);
    $ref->{seconds} = $ref->{seconds} % 60;
    $ref->{hours} += int($ref->{minutes} / 60);
    $ref->{minutes} = $ref->{minutes} % 60;
    my $print_minutes = '  ';
    my $print_hours   = '    ';
    my $print_seconds = sprintf(":%02d",$ref->{seconds});
    if ( $ref->{minutes} > 0 ) {
        $print_minutes = sprintf("%2d",$ref->{minutes});
    }
    if ( $ref->{hours} > 0 ) {
        $print_minutes = sprintf("%02d",$ref->{minutes});
        $print_hours =  sprintf("%3d:",$ref->{hours});
    }
    my $print_subtotal = "$print_hours$print_minutes$print_seconds";
    return $print_subtotal;
}

sub clear_subtotal {
    my ($ref) = @_;
    %{$ref} = %new_time_hash;
}

sub add_times {
    my ($ref,$h,$m,$s) = @_;
    $ref->{hours} += $h;
    $ref->{minutes} += $m;
    $ref->{seconds} += $s;
}

while (<>) {
    chomp;
    if ( $_ eq '' ) {
        print "------------------\n";
        print get_subtotal(\%subtotal) . " SUBTOTAL\n\n";
        clear_subtotal(\%subtotal);
    }
    else {
        my $orig = $_;
        my @ja   = split ' ';
        $_ = $ja[0];
        my @hm = split ':';
        $_ = join ':', @hm;

        add_times(\%subtotal,@hm);
        add_times(\%total,@hm);

        print " $orig\n";
    }
}

print "==================\n";
print get_total() . " TOTAL\n\n";

# <- END_OF_CODE

# <- $VAR1 = {
# <-     VERSION => '0.05',
# <-     purpose => 'create subtotals from wlog time card output',
# <-     example => '< a.log',
# <-     CODE    => $code,
# <-     target  => "$ENV{HOME}/bin/jlog",
# <- };

