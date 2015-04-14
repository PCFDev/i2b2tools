// Import the SQL Server JDBC Driver classes
import java.sql.*;
import java.io.File;
import java.io.FileReader;


public class tsql
{


      //http://blogs.msdn.com/b/brian_swan/archive/2011/03/02/getting-started-with-the-sql-server-jdbc-driver.aspx

       public static void main(String[] arg)
       {
         String SQL = "";
         String fileName = "";
         String printSQL = "no";
         try
         {


              if(arg.length < 5)
                throw new Exception("missing values");

              fileName = arg[0];
              String serverAddress = arg[1];
              String user = arg[2];
              String password = arg[3];
              String database = arg[4];

              if(arg.length > 5)
                printSQL = arg[5];

              SQL = fileContentsToString(fileName);


              // Load the SQLServerDriver class, build the
              // connection string, and get a connection
              Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");

              String connectionUrl = "jdbc:sqlserver://" + serverAddress + ";" +
                                      "database=" + database + ";" +
                                      "user=" + user + ";" +
                                      "password=" + password + ";";

              Connection con = DriverManager.getConnection(connectionUrl);

              //System.out.println("Connected.");

              // Create and execute an SQL statement that returns some data.
              //String
              //SQL = "SELECT TOP 10 C_FULLNAME, C_NAME FROM I2B2";

              Statement stmt = con.createStatement();

              System.out.println("Executing " + fileName + " ...");

              stmt.execute(SQL);


              System.out.println("  " + fileName + " completed.");


              //ResultSet rs = stmt.executeQuery(SQL);

              // Iterate through the data in the result set and display it.
              //while (rs.next())
              //{
              //   System.out.println(rs.getString(1) + " " + rs.getString(2));
              //}

         }
         catch(SQLException e)
         {
              System.out.println("SQL: " + e.getMessage());

              if(printSQL != "no")
                System.out.println("Query: " + SQL);

              System.out.println(fileName + " exited with Errors.");
              System.exit(0);
         }
         catch(Exception e)
         {
              System.out.println(e.getMessage());
              e.printStackTrace();
              System.out.println(fileName + " exited with Errors.");
              System.exit(0);
         }
    }

    /**
   * Read the contents of a file and place them in
   * a string object.
   *
   * @param file path to file.
   * @return String contents of the file.
   */
  public static String fileContentsToString(String file)
  {
      String contents = "";

      File f = null;
      try
      {
          f = new File(file);

          if (f.exists())
          {
              FileReader fr = null;
              try
              {
                  fr = new FileReader(f);
                  char[] template = new char[(int) f.length()];
                  fr.read(template);
                  contents = new String(template);
              }
              catch (Exception e)
              {
                  e.printStackTrace();
              }
              finally
              {
                  if (fr != null)
                  {
                      fr.close();
                  }
              }
          }
          else
            throw new Exception("File not found: " + file);

      }
      catch (Exception e)
      {
          e.printStackTrace();
      }
      return contents;
  }

}
