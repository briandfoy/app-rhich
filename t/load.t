use Test::More;

my $compile = `$^X -c blib/script/rhich`;
like( $compile, qr/OK/, 'rhich compiled OK' );

done_testing();
