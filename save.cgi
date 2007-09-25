#!/usr/local/bin/perl
# Save admin notes

require './virtualmin-notes-lib.pl';
&ReadParse();

$info = { 'name' => $in{'name'} };
$in{'note'} =~ s/\r//g;
&save_admin_note($info, $in{'note'});

&redirect($ENV{'HTTP_REFERER'});

