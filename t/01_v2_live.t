use strict;
use utf8;
use Test::Number::Delta within => 1e-4;
use Test::More;
use Encode ();
use Geo::Coder::Google;

if ($ENV{TEST_GEOCODER_GOOGLE_LIVE}) {
  plan tests => 5;
} else {
  plan skip_all => 'Not running live tests. Set $ENV{TEST_GEOCODER_GOOGLE_LIVE} = 1 to enable';
}

{
    my $geocoder = Geo::Coder::Google->new();
    my $location = $geocoder->geocode('548 4th Street, San Francisco, CA');
    delta_ok($location->{Point}->{coordinates}->[0], -122.39732);
}

SKIP: {
    skip "google.co.jp suspended geocoding JP characters", 1;
    my $geocoder = Geo::Coder::Google->new(apikey => $ENV{GOOGLE_MAPS_APIKEY}, host => 'maps.google.co.jp');
    my $location = $geocoder->geocode("東京都港区赤坂2-14-5");
    delta_ok($location->{Point}->{coordinates}->[0], 139.737808);
}

# as per http://code.google.com/apis/maps/documentation/geocoding/#CountryCodes
{
    my $geocoder_es = Geo::Coder::Google->new(apikey => $ENV{GOOGLE_MAPS_APIKEY}, gl => 'es');
    my $location_es = $geocoder_es->geocode('Toledo');
    delta_ok($location_es->{Point}->{coordinates}->[0], -4.0244759);
    my $geocoder_us = Geo::Coder::Google->new(apikey => $ENV{GOOGLE_MAPS_APIKEY});
    my $location_us = $geocoder_us->geocode('Toledo');
    delta_ok($location_us->{Point}->{coordinates}->[0], -83.555212);
}

{
    my $geocoder_utf8 = Geo::Coder::Google->new(apikey => $ENV{GOOGLE_MAPS_APIKEY}, oe => 'utf8');
    my $location_utf8 = $geocoder_utf8->geocode('Bělohorská 80, 6, Czech Republic');
    is($location_utf8->{address}, 'Bělohorská 1685/80, 169 00 Prague-Prague 6, Czech Republic');
}
