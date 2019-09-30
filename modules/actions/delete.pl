#!/usr/bin/perl

use lib $ENV{'DOCUMENT_ROOT'} . '/modules/db/';
use warnings;
use Database;
use CGI;
my $cgi = new CGI;
my $id = $cgi->param('id');

$data = new Database;
$data->delete($id);

print $cgi->redirect('http://perlcrud.localhost.com?deleted=1');