use Test::Strict tests => 3;                      # last test to print

syntax_ok( 'cloudmin_feature.pl' );
strict_ok( 'cloudmin_feature.pl' );
warnings_ok( 'cloudmin_feature.pl' );
