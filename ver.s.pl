#!/usr/bin/perl
# <- my $code = <<'END_OF_CODE';

use strict;
use warnings;

open I, "lsb_release -a 2>/dev/null |" or die "Can't: $!";

my $description = '';
my $codename = '';

while(<I>) {
    chomp;
    if(/^Description:\s*(.*)/) {
        $description=$1;
    }
    if(/^Codename:\s*(.*)/) {
        $codename=$1;
    }
}

close I;

print qq{$description "$codename"\n};

# Distributor ID: Ubuntu
# Description:    Ubuntu 13.10
# Release:    13.10
# Codename:   saucy

# <- END_OF_CODE

# <- $VAR1 = {
# <-     VERSION => '0.0.2',
# <-     purpose => 'get current Unix version',
# <-     params  => '',
# <-     example => '',
# <-     CODE    => $code,
# <-     target  => "$ENV{HOME}/bin/ver",
# <- };

