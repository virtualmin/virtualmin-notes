#!/usr/local/bin/perl
# Save admin notes
use strict;
use warnings;
our (%in);

require './virtualmin-notes-lib.pl';
&ReadParse();

my $info = { 'name' => $in{'name'} };
$in{'note'} =~ s/\r//g;
&save_admin_note($info, $in{'note'});

&redirect($ENV{'HTTP_REFERER'});
