use strict;
use warnings;

use Test::More 0.88; END { done_testing }
use Test::Exception 0.29;

# Work around buffering that can show diags out of order
Test::More->builder->failure_output(*STDOUT) if $ENV{HARNESS_VERBOSE};

my ($obj);
require_ok( 'Version::Next' );
can_ok( 'Version::Next', 'next_version' );
eval "use Version::Next 'next_version'";
can_ok( 'main', 'next_version' );
is( next_version(1), 2, "simple test");

for my $case ( <DATA> ) {
  chomp $case;
  next if $case =~ m{\A(?:#|\s*\z)};
  my ($input, $output) = split ' ', $case;
  is( next_version($input), $output, "$input -> $output" );
}

__DATA__
# Decimals
0       1
1       2
9       10

0.0     0.1
0.1     0.2
0.2     0.3
0.9     1.0
1.0     1.1

0.00    0.01
0.01    0.02
0.09    0.10
0.10    0.11
0.90    0.91
0.99    1.00
1.00    1.01

# Dotted Decimals

