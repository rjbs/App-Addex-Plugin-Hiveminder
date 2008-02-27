use strict;
use warnings;

use inc::Module::Install;

name          ('App-Addex-Plugin-Hiveminder');
author        ('Ricardo Signes <rjbs@cpan.org>');
license       ('perl');
version_from  ('lib/App/Addex/Plugin/Hiveminder.pm');

requires('App::Addex'    => 0.014); # plugins
requires('Sub::Install'  => 0.000); # minimum unknown

author_tests('xt');

WriteAll();
