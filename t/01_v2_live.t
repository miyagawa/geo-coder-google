use strict;
use utf8;
use Test::More;
use Encode ();
use Geo::Coder::Google;

plan tests => 5;

{
    my $geocoder = Geo::Coder::Google->new();
    my $location = $geocoder->geocode("548 4th Street, San Francisco, CA");
    is $location->{Point}->{coordinates}->[0], '-122.397426';
}

SKIP: {
    skip "google.co.jp suspended geocoding JP characters", 1;
    my $geocoder = Geo::Coder::Google->new(apikey => $ENV{GOOGLE_MAPS_APIKEY}, host => 'maps.google.co.jp');
    my $location = $geocoder->geocode("東京都港区赤坂2-14-5");
    like $location->{Point}->{coordinates}->[0], qr/139.737808/;
}

# as per http://code.google.com/apis/maps/documentation/geocoding/#CountryCodes
{
    my $geocoder_es = Geo::Coder::Google->new(apikey => $ENV{GOOGLE_MAPS_APIKEY}, gl => 'es');
    my $location_es = $geocoder_es->geocode('Toledo');
    like $location_es->{Point}->{coordinates}->[0], qr/-4.0244759/;
    my $geocoder_us = Geo::Coder::Google->new(apikey => $ENV{GOOGLE_MAPS_APIKEY});
    my $location_us = $geocoder_us->geocode('Toledo');
    like $location_us->{Point}->{coordinates}->[0], qr/-83.555212/;
}

{
    my $geocoder_utf8 = Geo::Coder::Google->new(apikey => $ENV{GOOGLE_MAPS_APIKEY}, oe => 'utf8');
    my $location_utf8 = $geocoder_utf8->geocode('Bělohorská 80, 6, Czech Republic');
    is $location_utf8->{address}, 'Bělohorská 1685/80, 162 00 Prague 6-Břevnov, Czech Republic';
}
