#!/usr/bin/perl

use lib $ENV{'DOCUMENT_ROOT'} . '/modules/db/';
use warnings;
use Database;
use CGI;
my $cgi = new CGI;
my $nachname = $cgi->param('nachname');
my $vorname = $cgi->param('vorname');
my $position = $cgi->param('position');
my $gehalt = $cgi->param('gehalt');

$data = new Database;
$data->add($nachname, $vorname, $position, $gehalt);

print $cgi->redirect('http://perlcrud.localhost.com?created=1');