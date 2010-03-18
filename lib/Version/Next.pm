use strict;
use warnings;
package Version::Next;
# ABSTRACT: increment module version numbers simply and correctly

# Dependencies
use version 0.80 ();

# Exporting
use Sub::Exporter 0 ( -setup => { exports => [ 'next_version' ] } );

=method next_version

=cut

sub next_version {
  my $version = shift;
  return 0 unless defined $version;

  my $new_ver;

  my $num_dots =()= $version =~ /(\.)/g;
  my $has_v = $version =~ /^v/;


  if ( $has_v || $num_dots > 1 ) { # vstring
    $version =~ s{^v}{} if $has_v;
    my @parts = split /\./, $version;
    my @new_ver;
    while ( @parts ) {
      my $p = pop @parts;
      if ( $p < 999 || ! @parts ) {
        unshift @new_ver, $p+1;
        last;
      }
      else {
        unshift @new_ver, 0;
      }
    }
    $new_ver = $has_v ? 'v' : '';
    $new_ver .= join( ".", map { 0+$_ } @parts, @new_ver );
  }
  else { # decimal fraction
    my ($fraction) = $version =~ m{\.(\d+)$};
    my $n = defined $fraction ? length($fraction) : 0;
    $new_ver = sprintf("%.${n}f",$version + (10**-$n));
  }
  return $new_ver;

}

1;

__END__

=begin wikidoc

= SYNOPSIS

    use Version::Next;

    my $new_version = next_version( $old_version )

= DESCRIPTION

This module might be cool, but you'd never know it from the lack
of documentation.

= USAGE

Good luck!

= SEE ALSO

* [Perl::Version]

=cut

