# Skeleton file

BEGIN { push(@INC, ".."); };
eval "use WebminCore;";
if ($@) {
	do '../web-lib.pl';
	do '../ui-lib.pl';
	}
&init_config();

$notes_text_file = "$module_config_directory/notes.txt";
$notes_data_file = "$module_config_directory/notes.info";

# get_admin_note()
# Returns a hash of settings about note, and the actual text
sub get_admin_note
{
local %info;
&read_file($notes_data_file, \%info);
local @st = stat($notes_text_file);
if (@st) {
	$info{'time'} = $st[9];
	}
local $txt = &read_file_contents($notes_text_file);
return ( \%info, $txt );
}

# save_admin_note(&info, text)
# Saves the admin note settings and text
sub save_admin_note
{
local ($info, $txt) = @_;
&write_file($notes_data_file, $info);
&open_tempfile(NOTES, ">$notes_text_file");
&print_tempfile(NOTES, $txt);
&close_tempfile(NOTES);
}

1;

