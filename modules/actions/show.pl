#!/usr/bin/perl

use lib $ENV{'DOCUMENT_ROOT'} . '/modules/db/';
use Database;
use Data::FormValidator;
use HTML::Template;
use HTML::Template::Associate;
use Data::Dumper;
use CGI;
my $cgi = new CGI;
my $q = $cgi->param('person');
#print $q;
use constant TMPL_FILE => $ENV{'DOCUMENT_ROOT'}. "/view/templates/show.tmpl";
$object = new Database;
@persons = $object->findById($q);
$name = $persons[0];
$vorname = $persons[1];
$position = $persons[2];
$gehalt = $persons[3];

my $template = HTML::Template->new (
    filename => TMPL_FILE
);

$template->param(NAME => $name);
$template->param(VORNAME => $vorname);
$template->param(GEHALT => $gehalt);

if($position == 1) {
$template->param(POSITION   => 'Projektmanager');
} elsif($position == 2) {
$template->param(POSITION   => 'Salesmanager');
} elsif($position == 3) {
$template->param(POSITION   => 'Frontend-Developer');
} elsif($position == 4) {
$template->param(POSITION   => 'Backend-Developer');
} else {
$template->param(POSITION   => 'Grafiker');
}

print "Content-type:text/html\n\n", $template->output();