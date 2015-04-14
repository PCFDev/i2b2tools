use strict;

my $shrine_version = $ENV{'SHRINE_VERSION'};

my $svn_url_base = "$ENV{'SHRINE_SVN_URL_BASE'}";

my $ontology_svn_url_base = "$svn_url_base/ontology";

my $shrine_sql_file_url_suffix;

if($shrine_version =~ m/^1\.15/)
{
  $shrine_sql_file_url_suffix = "core/Shrine.sql";
} 
else
{
  $shrine_sql_file_url_suffix = "SHRINE_Demo_Downloads/ShrineDemo.sql";
}

my $shrine_sql_file_url = "$ontology_svn_url_base/$shrine_sql_file_url_suffix";

print $shrine_sql_file_url;
