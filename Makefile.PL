use ExtUtils::MakeMaker;
WriteMakefile(
    'NAME'      => 'Geo::Coder::Google',
    'AUTHOR'    => 'Tatsuhiko Miyagawa <miyagawa@bulknews.net>',
    'LICENSE' => 'perl',
    'VERSION_FROM' => 'lib/Geo/Coder/Google.pm', # finds $VERSION
    'ABSTRACT_FROM' => 'lib/Geo/Coder/Google.pm',
    'MIN_PERL_VERSION' => '5.008001',
    'PREREQ_PM' => {
        LWP => 5.5,
        JSON => 2.27,
        Encode => 0,
        URI => 0,
        'HTTP::Request' => 0,
    },
    'BUILD_REQUIRES' => {
        'Test::More' => 0.32,
        'Digest::HMAC_SHA1' => 0,
        'MIME::Base64' => 0,
    },
    META_MERGE      => {
        resources => {
            license     => 'http://dev.perl.org/licenses/',
            bugtracker  => 'http://rt.cpan.org/NoAuth/Bugs.html?Dist=Geo-Coder-Google',
            repository  => 'https://github.com/miyagawa/geo-coder-google',
        },
    },
);
