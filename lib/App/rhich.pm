#!/usr/bin/perl
package App::rhich;
use strict;
use warnings;
use vars qw($VERSION);

$VERSION = '1.003';

=encoding utf8

=head1 NAME

App::rhich - which(1) with a Perl regex

=head1 SYNOPSIS

Run this program like you would which(1), but give is a Perl regex. Even
a sequence is a regex.

	% rhich perl
	% rhich p.*rl

=head1 DESCRIPTION

rhich(1) goes through the directories listed in PATH and lists files
that match the regular expression given as the argument.

=head1 COPYRIGHT AND LICENCE

Copyright © 2013-2018, brian d foy <bdfoy@cpan.org>. All rights reserved.

You may use this under the same terms as Perl itself.

=head1 AUTHOR

brian d foy, C<< <bdfoy@cpan.org> >>

=cut

use File::Spec;

my $regex = eval qr/$ARGV[0]/;
unless( defined $regex ) {
	die "Could not compile regex! $@\n";
	}

# XXX: do some regex cleaning here
# take out (?{}) and (?{{}})


my @paths = get_path_components();

foreach my $path ( @paths ) {
	if( ! -e $path ) {
		warn "$0: path $path does not exist\n";
		next;
		}
	elsif( ! -d $path ) {
		warn "$0: path $path is not a directory\n";
		next;
		}
	elsif( opendir my $dh, $path ) {
		my @commands =
			map     {
				if( -l ) {
					my $target = readlink;
					"$_ -> $target";
					}
				else { $_ }
				}
			grep    { -x }
			map     { File::Spec->catfile( $path, $_ ) }
			grep    { /$regex/ }
			readdir $dh;

		next unless @commands;

		print join "\n", @commands, '';
		}
	else {
		warn "$0: could not read directory for $path: $!\n";
		}
	}

sub get_path_components {
	use Config;
	my $separator = $Config{path_sep} // ':';
	my @parts = split /$separator/, $ENV{PATH};
	}
