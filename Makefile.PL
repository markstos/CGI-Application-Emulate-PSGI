use inc::Module::Install;

all_from 'lib/CGI/Application/Emulate/PSGI.pm';
readme_from 'lib/CGI/Application/Emulate/PSGI.pm';

test_requires 'Test::More'       => 0.88;
requires 'CGI::Application';

auto_include;
WriteAll;
