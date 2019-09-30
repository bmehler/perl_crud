#!/usr/bin/perl

use warnings;
use HTML::Template;

use constant TMPL_FILE => $ENV{'DOCUMENT_ROOT'}. "/view/templates/createForm.tmpl";

my $template = HTML::Template->new (
    filename => TMPL_FILE,
    die_on_bad_params => 0
);
      
print "Content-type:text/html\n\n", $template->output();