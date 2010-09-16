use TestML -run, -dev_test;

__DATA__
%TestML 1.0

Plan = 1;

RmPath('t/sample1/inc');
RmPath('t/MANIFEST.SKIP');

test = (dir, cmd, want) {
    Chdir(dir);
    RunCommand('perl Makefile.PL');
    RunCommand('make manifest');
    Read('t/MANIFEST') == *manifest;
};

test(*dir, *manifest);

=== Sample1
--- dir: t/sample1
--- manifest
Makefile.PL
lib/sample.pm
