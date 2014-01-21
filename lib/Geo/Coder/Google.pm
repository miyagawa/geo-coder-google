package Geo::Coder::Google;

use strict;
use warnings;
our $VERSION = '0.14';

sub new {
    my ($self, %param) = @_;
    my $apiver = delete $param{apiver} || 2;
    my $class = 'Geo::Coder::Google::V' . $apiver;

    eval "require $class"; die $@ if $@;
    $class->new(%param);
}

1;
__END__

=head1 NAME

Geo::Coder::Google - Google Maps Geocoding API

=head1 DESCRIPTION

Geo::Coder::Google provides a geocoding functionality using Google Maps API.

See L<Geo::Coder::Google::V2> for V2 API usage.

See L<Geo::Coder::Google::V3> for V3 API usage.

=cut
