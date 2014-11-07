# The MIT License (MIT)
#
# Copyright (c) 2014 Rajesh Kumar

use strict;
use warnings;

use Readonly;
use Data::Dumper;

=head1 NAME

replaceKeysName - function to replace the key name of a hash

=head1 SYNOPSIS

=cut

Readonly::Hash my %REPLACE_NAMES => (
    'k1' => 'key1',
    'k2' => 'key2',
    'dt' => 'desktop',
    'mo' => 'mobile',
);

my $adTagOptions = {
  'k1' => {
    'dt' => {
      'k2' => 'temp_value_1'
    },
    'mo' => {
      'k2' => 'temp_value_2'
    }
  }
};

=item B<< replaceKeysName >>

this function repalaces the key name in a hash
it is a recursive function.
it takes two hash reference as input and
replaces the keys name in first hash using the second hash

=cut

# first declaration is for suppressing a warning which is coming becuase of it being a recursive function
sub replaceKeysName($$);
sub replaceKeysName($$) {
    my ($adTagOptions, $replaceKeys) = @_;

    if(ref($adTagOptions) eq 'HASH') {
        foreach my $k (keys %$adTagOptions) {
            if(ref($adTagOptions->{$k}) eq 'HASH' or ref($adTagOptions->{$k}) eq 'ARRAY') {
                replaceKeysName($adTagOptions->{$k}, $replaceKeys);
            }

            if(defined $replaceKeys->{$k}) {
                $adTagOptions->{$replaceKeys->{$k}} = delete $adTagOptions->{$k};
            }
        }
    }
    elsif(ref($adTagOptions) eq 'ARRAY') {
        my $len = scalar @$adTagOptions;
        for(my $i = 0; $i < $len; $i++) {
            replaceKeysName($adTagOptions->[$i], $replaceKeys);
        }
    }
}

# calling the function here
replaceKeysName($adTagOptions, \%REPLACE_NAMES);
print "After replace : ", Dumper($adTagOptions), "\n\n";
