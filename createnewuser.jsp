<%@page import="java.sql.*" %>
<%@page import="java.util.*" %>
<%@page import="java.lang.*" %>
<html>
<head>

    <title>Creating New User</title>
    <style>
        a
        {
            text-decoration: none;
        }
    </style>
</head>
<body>
	<h2>:</h2>
	

    <% 
	
		String JDBC_DRIVER = "com.mysql.cj.jdbc.Driver";  
		 String DB_URL = "jdbc:mysql://localhost/examportal"; 
		String USER = "admin";
		String PASS = "securepassword";
		
		
		Connection conn = null;
		Statement stmt = null;
		try
		{
		
            Class.forName("com.mysql.jdbc.Driver");
            conn = DriverManager.getConnection(DB_URL, USER, PASS); //connecting to usertables
		   out.println("");
           stmt = conn.createStatement();
           String name,username;
           name=request.getParameter("name");
           username=request.getParameter("username");

		   String sql="SELECT * FROM usertables WHERE username="+ username;
		   ResultSet rs = stmt.executeQuery(sql); // Getting the usernames to check for duplicates
           int flag=0;
           
           if(rs.next()==false)
           {
                flag=1;
           }
           String sql="SELECT * FROM usertables WHERE name="+ name;
		   ResultSet rs = stmt.executeQuery(sql); // Getting the names to check for duplicates
           
           
           if(rs.next()==false)
           {
                flag=1;
           }
          
           if(flag==1)
           {
                        %>
                            <h2>Your Username exists, Please try again</h2>
                        <%
                        site = new String("signup.html");
                     response.setStatus(response.SC_MOVED_TEMPORARILY);
                     response.setHeader("Location", site);

           }
           else
           {

               String pass=request.getParameter("password");
               
               //Creating salt
              
               String SALTCHARS = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890";
                StringBuilder salt = new StringBuilder();
                Random rnd = new Random();
                while (salt.length() < 18) // length of the random string.
                { 
                   int index = (int) (rnd.nextFloat() * SALTCHARS.length());
                   salt.append(SALTCHARS.charAt(index));
                 }
                String saltStr = salt.toString();

                //hashing password:

               try
               {
                   MessageDigest md= MessageDigest.getInstance("SHA-256");
                   md.update(pass.getBytes());
                   md.update(saltStr.getBytes()); //appending salt
                   byte[] out = md.digest();
                   
                   char[] hexChars = new char[out.length * 2];
                    int v;
                    for (int j = 0; j < out.length; j++)
                     {
                            v = out[j] & 0xFF;
                             hexChars[j * 2] = hexArray[v >>> 4];
                             hexChars[j * 2 + 1] = hexArray[v & 0x0F];
                    }
                   String password=(new String(hexChars)); 
               }
               catch (NoSuchAlgorithmException e) 
               {
                e.printStackTrace();
              }
               
               sql="INSERT INTO usertables " + "VALUES ('"+username+"','"+name+"','"+password+"','"+saltStr+"')";
               stmt.executeUpdate(sql);

               %>

                <h2>New User Created succesfully, Please login with new details:</h2>
                    <a href=login.html>Login Page</a>
               <%

           }
		   
		   
		   
		   rs.close();
		 
		}catch(SQLException se)
		{
			
			se.printStackTrace();
		 }
		 catch(Exception e)
		 {
			
			e.printStackTrace();
		 }
		 finally
		 {
			
			try
			{
			   if(stmt!=null)
				  conn.close();
			}
			catch(SQLException se)
			{
			}
			
			try{

			   if(conn!=null)
				  conn.close();
			}catch(SQLException se){
			   se.printStackTrace();
			}
		 }
	  
	 

        
    %>
</body>
</html> 