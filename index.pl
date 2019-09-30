#!/usr/bin/perl

use modules::db::Database;
use Data::FormValidator;
use HTML::Template;
use HTML::Template::Associate;
use CGI;
my $cgi = new CGI;
use Data::Dumper;
use constant TMPL_FILE => "/Applications/MAMP/cgi-bin/perl_crud/view/templates/index.tmpl";
$object = new Database;
@persons = $object->findAll();
my $template = HTML::Template->new (
    filename => TMPL_FILE,
    die_on_bad_params => 0
);

if($cgi->param('created')) {
    $template->param(CREATED => 1);
} elsif($cgi->param('updated')) {
    $template->param(UPDATED => 1);
} elsif($cgi->param('deleted'))  {
    $template->param(DELETED => 1);
} else {
    $template->param(CREATED => 0);
}

$template->param(PERSON_DATA => @persons);    
print "Content-type:text/html\n\n", $template->output();