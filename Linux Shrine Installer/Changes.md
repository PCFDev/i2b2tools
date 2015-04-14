1. vm-install.sh
	* Added support for sqlserver parameter as there was no way to detect the use of MSSQL like postgres or oracle. This could probably be added to common.rc as a setup parameter instead.

2. i2b2/sqlserver/clean*.*
	* I have yet to update the clean position of the script so no changes to any of the clean* files under the i2b2/sqlserver folder

3. i2b2/sqlserver/configure_hive.sh
	* added additional required variables to support the MSSQL syntax in the interpolated files
	* changed to use the java tsql class

4. i2b2/sqlserver/configure_hive.sh
	* changed to use the java tsql class

5. i2b2/sqlserver/i2b2.rc
	* there are many changes in this file, mainly adding additional variables to support MSSQL configuration. variables were reused within the file where possible to minimize the number of changes needed to get the script to run against the default MSSQL configuration for i2b2. a few sections had to be added to support updating all of the i2b2 datasource files to point to MSSQL, lines 134-138 for example.

6. i2b2/sqlserver/ontology.sh
	* the main changes here are updating the variables that are used during interpolation and using java for execution

7. i2b2/sqlserver/prepare.sh
	* added a line to compile the tsql java class and a call to reconfigure-i2b2.sh

8. i2b2/sqlserver/reconfigure-i2b2.sh
	* replaces all of the *-ds.xml files in the jboss deployment folder with copies that point to MSSQL using the same process as the ont-ds.xml replacement in the configre_hive.sh file
	* also replaces a few values in the i2b2 properties files to update the schema values and database type

9. i2b2/sqlserver/skel/
	* the required changes to the sql files were minimal, mainly added the I2B2_DB_SCHEMA token and changed a few minor syntax issues
	* added “tokenized” copies of the remaining *-ds.xml files to support updating i2b2 to point to MSSQL

10. shring/sqlserver/adapter.sql, hub.sql, create_broadcaster_audit_table.sql
	* had to provide local copies of these files that have been modified to run on MSSQL

11. shrine/sqlserver/create_database.sql, create_user.sql
	* the mysql.sql file had to be split into these two files due to a limitation in adbc. someone with a bit more experience with jdbc may be able to figure out how to merge them into a mssql.sql file but this was the easiest way forward. basically the create database command must complete before the create user command can be run, jdbc does not support the GO batch delimiter to execute commands in batches so this required two separate calls to jdbc.

12. shrine/sqlserver/install.sh
	* changed to call mssql.sh instead of mysql.sh
	* also changed the path to common.rc by adding another ../ since it is now in a subfolder

13. shrine/sqlserver/install_prereqs.sh
	* added a call to install svn… noticed this was not installed because i was coping the quick_install folder from my dev box to the vm instead of using svn to download it. figured i would add it here for good measure.
	* added a line to compile the java tsql class

14. shrine/sqlserver/mssql.sh
	* changed to use different variables
	* changed to use jdbc
	* no longer downloads the sql files as mentioned in #10

15. shrine/sqlserver/shrine.rc
	* changed SHRINE_MYSQL_* to SHRINE_DB_*
	* added SHRINE_DB_ADMIN_* to support logging into MSSQL as a server admin to create the new database
	* added SHRINE_DB_SCHEMA to support MSSQL schema

16. shrine/sqlserver/tomcat.sh
	* changed the interpolation of shrine.xml to use the new variables

17. shrine/sqlserver/skel/shrine.conf
	* changed the databaseType to mssql

18. shrine/sqlserver/skel/shrine.xml
	* changed the jdbc connection string



SQL Side:
                update SQL PM Cell Data to localhost


Web Side:
                sqljdbc.jar - copy from JBoss to Tomcat/lib
                install tomcat to c:\opt\shrine\tomcat (no spacing)
                server.xml:
                                Uncomment SSL/TLS Connector
                                                port="6443"
                                                protocol="HTTP/1.1"
                                                Add keystoreFile and keystorePass to 6443 Connector (able to use relative path/does not assume C:)
                                Edit 6060 redirectPort="6443"
                shrine.conf:
                                pmEndpoint url should be localhost:9090
                                ontEndpoint url should be localhost:9090
                                crcEndpoint url should be localhost:9090
                                shrineDatabaseType should be "sqlserver"
                              (M)  keystore file should be edited to match windows directory and escape chars (\\) added
