# Virtualmin Admin Notes
use strict;
use warnings;
our $module_config_directory;

BEGIN { push(@INC, ".."); };
eval "use WebminCore;";
&init_config();

my $notes_text_file = "$module_config_directory/notes.txt";
my $notes_data_file = "$module_config_directory/notes.info";

# get_admin_note()
# Returns a hash of settings about note, and the actual text
sub get_admin_note
{
my %info;
&read_file($notes_data_file, \%info);
my @st = stat($notes_text_file);
if (@st) {
	$info{'time'} = $st[9];
	}
my $txt = &read_file_contents($notes_text_file);
return ( \%info, $txt );
}

# save_admin_note(&info, text)
# Saves the admin note settings and text
sub save_admin_note
{
my ($info, $txt) = @_;
&write_file($notes_data_file, $info);
no strict "subs";
&open_tempfile(NOTES, ">$notes_text_file");
&print_tempfile(NOTES, $txt);
&close_tempfile(NOTES);
use strict "subs";
}

1;
