use ExtUtils::MakeMaker;
WriteMakefile(
    'NAME'      => 'Geo::Coder::Google',
    'VERSION_FROM' => 'lib/Geo/Coder/Google.pm', # finds $VERSION
    'PREREQ_PM' => {
	Test::More => 0.32,
        LWP => 5.5,
        JSON => 2.27,
        Encode => 0,
    },
);
