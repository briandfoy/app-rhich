use ExtUtils::MakeMaker;

require 5.008;

eval "use Test::Manifest 1.21";

WriteMakefile(
	'NAME'	        => 'rhich',
	'ABSTRACT_FROM' => 'script/rhich',
	'VERSION_FROM'  => 'script/rhich',
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
