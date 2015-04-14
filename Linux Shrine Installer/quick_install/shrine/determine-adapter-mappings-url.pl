use strict;

my $shrine_version = $ENV{'SHRINE_VERSION'};

my $svn_url_base = "$ENV{'SHRINE_SVN_URL_BASE'}";

my $ontology_svn_url_base = "$svn_url_base/ontology";

my $adapter_mappings_file_url_suffix;

if($shrine_version =~ m/^1\.15/)
{
  $adapter_mappings_file_url_suffix = "i2b2/i2b2_1-6_AdapterMappings.xml";
} 
else
{
  $adapter_mappings_file_url_suffix = "SHRINE_Demo_Downloads/AdapterMappings_i2b2_DemoData.xml";
}

my $adapter_mappings_file_url = "$ontology_svn_url_base/$adapter_mappings_file_url_suffix";

print $adapter_mappings_file_url;
