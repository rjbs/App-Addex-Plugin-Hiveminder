use inc::Module::Install;

all_from('lib/App/Addex/Plugin/Hiveminder.pm');

requires('App::Addex'    => 0.014); # plugins
requires('Sub::Install'  => 0.000); # minimum unknown

extra_tests;

repository('http://github.com/rjbs/app-addex-plugin-hiveminder');
auto_manifest;

WriteAll();
