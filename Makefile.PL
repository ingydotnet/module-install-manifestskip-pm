use inc::Module::Install;

name 'Module-Install-ManifestSkip';
all_from 'lib/Module/Install/ManifestSkip.pm';

manifest_skip;

WriteAll;
