##
# name:      Module::Install::ManifestSkip
# abstract:  Generate a MANIFEST.SKIP file
# author:    Ingy döt Net <ingy@cpan.org>
# license:   perl
# copyright: 2010, 2011

package Module::Install::ManifestSkip;
use 5.008003;
use strict;
use warnings;

use base 'Module::Install::Base';

our $VERSION = '0.16';
our $AUTHOR_ONLY = 1;

my $skip_file = "MANIFEST.SKIP";

sub manifest_skip {
    my $self = shift;
    return unless $self->is_admin;

    print "manifest_skip\n";

    my $keepers;
    if (-e $skip_file) {
        open IN, $skip_file
            or die "Can't open $skip_file for input: $!";
        my $input = do {local $/; <IN>};
        close IN;
        if ($input =~ s/(.*?\n)\s*\n.*/$1/s and $input =~ /\S/) {
            $keepers = $input;
        }
    }
    open OUT, '>', $skip_file
        or die "Can't open $skip_file for output: $!";;

    if ($keepers) {
        print OUT "$keepers\n";
    }

    print OUT _skip_files();

    close OUT;

    $self->clean_files('MANIFEST');
}

sub _skip_files {
    return <<'...';
^Makefile$
^Makefile\.old$
^pm_to_blib$
^blib/
^pod2htm.*
^MANIFEST\.SKIP$
^MANIFEST\.bak$
^\.git/
^\.gitignore
^\.gitmodules
/\.git/
\.svn/
^\.vimrc$
\.sw[op]$
^core$
^out$
^tmon.out$
^.devel-local$
^\w$
^foo.*
^notes
^todo
^ToDo$
## avoid OS X finder files
\.DS_Store$
## skip komodo project files
\.kpf$
## ignore emacs and vim backup files
~$
...
}

1;

=head1 SYNOPSIS

    use inc::Module::Install;

    name     'Foo';
    all_from 'lib/Foo.pm';

    manifest_skip;

    WriteAll;

=head1 DESCRIPTION

This module generates a C<MANIFEST.SKIP> file for you that contains the
common files that people do not want in their C<MANIFEST> files. The SKIP
file is generated each time that you (the module author) run
C<Makefile.PL>.

You can add your own custom entries at the top of the C<MANIFEST> file.
Just put a blank line after your entries, and they will be left alone.

This module also adds 'MANIFEST' to the C<clean_files()> list so that
C<make clean> will remove your C<MANIFEST>.

=head1 THEORY

One school of thought for release management is that you never commit
your C<MANIFEST> file. You just generate it using C<make manifest>, right
before releasing a module, and then delete it afterwards.

This is good because you never forget to add new files to your C<MANIFEST>.
The only problems are that you always need to generate a C<MANIFEST.SKIP>
file, and you need to add C<MANIFEST> to your clean_files, or delete it by
hand. This module does these things for you.
