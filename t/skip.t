use TestML -run;

__DATA__
%TestML 1.0

Plan = 1;

*dir.Chdir.RunCommand('perl Makefile.PL').Read('t/MANIFEST') == *manifest

=== Sample1
--- dir: sample1
--- manifest
Makefile.PL
lib/sample.pm`
