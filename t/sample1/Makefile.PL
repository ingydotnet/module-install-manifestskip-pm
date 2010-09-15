use inc::Module::Install;

name 'Module-Install-ManifestSkip';
all_from 'lib/Module/Install/ManifestSkip.pm';
readme_from;
manifest_skip;
ack_xxx;

WriteAll;
