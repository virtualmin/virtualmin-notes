# Defines functions for this feature
use strict;
use warnings;
our (%text);
our $module_name;

require 'virtualmin-notes-lib.pl';

# feature_name()
# Returns a short name for this feature
sub feature_name
{
return $text{'feat_name'};
}

# Called by Cloudmin
sub plugin_desc
{
return &feature_name();
}

# theme_sections()
# If defined, should return a list of extra sections to be displayed (typically
# on the right-hand frame) of a theme. Each must be a hash ref containing the
# keys 'title' (section heading), 'html' (contents of the section) and
# 'status' (open or not by default). It can also contain 'for_master',
# 'for_reseller' and 'for_owner' flags, indicating if the section should be
# visible to master admins, resellers and domain owners.
sub theme_sections
{
my ($info, $txt) = &get_admin_note();
my $html;
$html .= &ui_form_start("$module_name/save.cgi", "post");
$html .= &ui_table_start(undef, undef, 2, [ "nowrap" ]);
$html .= &ui_table_row($text{'right_name'},
		       &ui_textbox("name", $info->{'name'}, 50, 0, undef,
				   "style='width:100%'"));
if ($info->{'time'}) {
	$html .= &ui_table_row($text{'right_time'},
			       &make_date($info->{'time'}));
	}
$html .= &ui_table_row($text{'right_note'},
		       &ui_textarea("note", $txt, 10, 80, undef, 0,
				    "style='width:100%'"));
$html .= &ui_table_end();
$html .= &ui_form_end([ [ undef, $text{'save'} ] ]);
my $status = $txt =~ /\S/ ? 1 : 0;
return ( { 'name' => $module_name,
	   'title' => $text{'right_title'},
	   'html' => $html,
	   'status' => $status,
	   'for_master' => 1 } );
}

1;
