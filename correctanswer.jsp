
<%@page import="java.sql.*" %>
<%@page import="java.util.*" %>
<html>
<head>

<title>Stores correct answer</title>
</head>
<body>
	<h2>The Answer you enter:</h2>
	

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
            conn = DriverManager.getConnection(DB_URL, USER, PASS); //has only correct options
		   out.println("");
		   stmt = conn.createStatement();

		   String sql="SELECT * FROM mainquestions ORDER BY qn DESC LIMIT 1";
		   ResultSet rs = stmt.executeQuery(sql); // Getting the last question number
		   rs.next();
		   int qn = rs.getInt("qn");
		   String question = rs.getString("question");
		   String option1 = rs.getString("option1");
		   String option2 = rs.getString("option2");
		   String option3 = rs.getString("option3");
		   String option4 = rs.getString("option4");
		   String correct = "";
			String correctanswer=request.getParameter("correctanswer");
		   
		   out.println(correctanswer);
			 if(correctanswer.equals("option1"))
			   		correct = option1;
					
			  else if (correctanswer.equals("option2"))
			   		correct = option2;
					
				else if (correctanswer.equals("option3"))
					correct = option3;
					
				else if (correctanswer.equals("option4"))
					correct = option4;
			   		
			
		   
		   sql = "INSERT INTO correctanswers " + "VALUES ('"+qn+"','"+question+"','"+correct+"')";
		   stmt.executeUpdate(sql);
		   
		   
		 
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