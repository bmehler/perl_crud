#!/usr/bin/perl


use lib $ENV{'DOCUMENT_ROOT'} . '/modules/db/';
use warnings;
use Database;
use HTML::Template;
use CGI;
my $cgi = new CGI;
my $q = $cgi->param('person');
use constant TMPL_FILE => $ENV{'DOCUMENT_ROOT'}."/view/templates/editForm.tmpl";

$object = new Database;
@persons = $object->findById($q);
$name = $persons[0];
$vorname = $persons[1];
$position = $persons[2];
$gehalt = $persons[3];
$id = $persons[4];

my $template = HTML::Template->new (
    filename => TMPL_FILE,
    die_on_bad_params => 0
);

$template->param(NAME => $name);
$template->param(VORNAME => $vorname);
$template->param(GEHALT => $gehalt);
$template->param(POSITION => $position);
$template->param(ID => $id);

if($position == 1) {
$template->param(PROJEKTMANAGER => 'Projektmanager');
} elsif($position == 2) {
$template->param(SALESMANAGER   => 'Salesmanager');
} elsif($position == 3) {
$template->param(FRONTEND       => 'Frontend-Developer');
} elsif($position == 4) {
$template->param(BACKEND        => 'Backend-Developer');
} else {
$template->param(GRAFIK         => 'Grafiker');
}
      
print "Content-type:text/html\n\n", $template->output();