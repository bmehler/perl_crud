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
my $id = $cgi->param('id');

$data = new Database;
$data->update($id, $nachname, $vorname, $position, $gehalt);

print $cgi->redirect('http://perlcrud.localhost.com?updated=1');