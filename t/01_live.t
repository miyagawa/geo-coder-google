use strict;
use Test::More;
use Geo::Coder::Google;

unless ($ENV{GOOGLE_MAPS_APIKEY}) {
    plan skip_all => 'No GOOGLE_MAPS_APIKEY env variable';
    exit;
}

plan tests => 2;

{
    my $geocoder = Geo::Coder::Google->new(apikey => $ENV{GOOGLE_MAPS_APIKEY});
    my $location = $geocoder->geocode("548 4th Street, San Francisco, CA");
    is $location->{Point}->{coordinates}->[0], '-122.397323';
}

SKIP: {
    skip "google.co.jp suspended geocoding JP characters", 1;
    my $geocoder = Geo::Coder::Google->new(apikey => $ENV{GOOGLE_MAPS_APIKEY}, host => 'maps.google.co.jp');
    my $location = $geocoder->geocode("東京都港区赤坂2-14-5");
    is $location->{Point}->{coordinates}->[0], '139.737808';
}

