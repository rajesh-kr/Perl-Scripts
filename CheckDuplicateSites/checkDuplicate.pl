#The MIT License (MIT)
#
#Copyright (c) 2014 Rajesh Kumar

use strict;
use warnings;
use Data::Dumper;

my $sitesFromCDB = {};
my $sitesToCheck = {};
my $sitesPresentInCDB = {};
my $sitesNotPresentInCDB = {};

my $cdbFileName = 'keywords_out.txt';
my $sitesFileName = 'input.txt';

open (my $cdbFile, '<', $cdbFileName) or die "Could not open file '$cdbFileName': $!";

while (my $row = <$cdbFile>) {
    chomp $row;
    $row =~ s{^\s*}{};
    $row =~ s{\s*$}{};
    $row =~ s{\t\w*$}{};
    if(defined $sitesFromCDB->{$row}) {
        ++$sitesFromCDB->{$row};
    }
    else {
        $sitesFromCDB->{$row} = 1;
    }
}

open (my $siteFile, '<', $sitesFileName) or die "Could not open file '$sitesFileName': $!";

while (my $row = <$siteFile>) {
    chomp $row; 
    $row =~ s{^\s*}{};
    $row =~ s{\s*$}{};

    if(defined $sitesFromCDB->{$row}) {
        if (defined $sitesPresentInCDB->{$row}) {
            ++$sitesPresentInCDB->{$row};
        }
        else {
            $sitesPresentInCDB->{$row} = 1;
        }
    }
    else {
        $sitesNotPresentInCDB->{$row} = 1;
    }
}   

print "Sites already present : ", Dumper($sitesPresentInCDB), "\n\n";
print "Sites not present : ", Dumper($sitesNotPresentInCDB), "\n\n";

print "Count of sites present : ", scalar (keys %$sitesPresentInCDB), "\n\n";
print "Count of sites not present : ", scalar (keys %$sitesNotPresentInCDB), "\n\n";
