use strict;
use Test::More;
use Geo::Coder::Google;

unless ($ENV{GOOGLE_MAPS_APIKEY}) {
    plan skip_all => 'No GOOGLE_MAPS_APIKEY env variable';
    exit;
}

plan tests => 4;

{
    my $geocoder = Geo::Coder::Google->new(apikey => $ENV{GOOGLE_MAPS_APIKEY});
    my $location = $geocoder->geocode("548 4th Street, San Francisco, CA");
    is $location->{Point}->{coordinates}->[0], '-122.397711';
}

SKIP: {
    skip "google.co.jp suspended geocoding JP characters", 1;
    my $geocoder = Geo::Coder::Google->new(apikey => $ENV{GOOGLE_MAPS_APIKEY}, host => 'maps.google.co.jp');
    my $location = $geocoder->geocode("東京都港区赤坂2-14-5");
    is $location->{Point}->{coordinates}->[0], '139.737808';
}

# as per http://code.google.com/apis/maps/documentation/geocoding/#CountryCodes
{
    my $geocoder_es = Geo::Coder::Google->new(apikey => $ENV{GOOGLE_MAPS_APIKEY}, gl => 'es');
    my $location_es = $geocoder_es->geocode('Toledo');
    is $location_es->{Point}->{coordinates}->[0], '-4.0244759';
    my $geocoder_us = Geo::Coder::Google->new(apikey => $ENV{GOOGLE_MAPS_APIKEY});
    my $location_us = $geocoder_us->geocode('Toledo');
    is $location_us->{Point}->{coordinates}->[0], '-83.577782';
}

