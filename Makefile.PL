require 5.008;
use strict;
use warnings;


my $github    = 'https://github.com/briandfoy/';
my $main_file = 'lib/App/rhich.pm';

my %WriteMakefile = (
	'NAME'	        => 'rhich',
	'ABSTRACT_FROM' => $main_file,
	'VERSION_FROM'  => $main_file,
	'LICENSE'       => 'perl',
	'AUTHOR'        => 'brian d foy <bdfoy@cpan.org>',
	
	'PREREQ_PM'     => {
		'Test::More' => '0',
		},

	'EXE_FILES' => [ 'script/rhich' ],

	'META_MERGE' => {
        'meta-spec' => { version => 2 },
		resources => {
			repository => {
				type => 'git',
				url  => 'git@github.com:briandfoy/rhich.git',
				web  => 'https://github.com/briandfoy/rhich',
				},
			},
		},

	clean  => { FILES    => q|rhich-*| },
	);

sub arguments { \%WriteMakefile }

do_it() unless caller;
sub do_it {
	require File::Spec;
	my $MM ='ExtUtils::MakeMaker';
	my $MM_version =
		eval{ "$MM " . $WriteMakefile{'CONFIGURE_REQUIRES'}{'ExtUtils::MakeMaker'} }
			//
		"$MM 6.64";
	eval "use $MM_version" || die "Could not load $MM_version: $@";
	eval "use Test::Manifest 1.21" 
		if -e File::Spec->catfile( qw(t test_manifest) );
	WriteMakefile( %WriteMakefile );
	}


no warnings;
__PACKAGE__;
