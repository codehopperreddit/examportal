
<%@page import="java.sql.*" %>
<%@page import="java.util.*" %>
<html>
<head>

<title>Choose answer</title>
<script>
	
	function submitforms()
        {
            
            
                document.forms.getcorrectanswer.submit();
            
            
        }


</script>
</head>
<body>
	<h2>Choose the correct option</h2>
	

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
		   
		   conn = DriverManager.getConnection(DB_URL, USER, PASS);//has all options
		   stmt = conn.createStatement();
		   
		   String sql;
		   sql="";
		   sql="SELECT * FROM mainquestions ORDER BY qn DESC LIMIT 1";
		   
		   ResultSet rs = stmt.executeQuery(sql); // Getting the last question number
		   rs.next();
			 
		   int newqn=rs.getInt("qn");
		   
		   newqn++;//creating new questionnumber
		   String newqninwords = Integer.toString(newqn); 
		   String questiontxt=request.getParameter("question");
		   String option1txt=request.getParameter("option1");
		   String option2txt=request.getParameter("option2");
		   String option3txt=request.getParameter("option3");
		   String option4txt=request.getParameter("option4");
		   sql = "INSERT INTO mainquestions " + "VALUES ('"+newqninwords+"','"+questiontxt+"','"+option1txt+"','"+option2txt+"','"+option3txt+"','"+option4txt+"')";
			
		   stmt.executeUpdate(sql);
		}
		catch(SQLException se)
		{
			
			se.printStackTrace();
		 }
		 catch(Exception e)
		 {
			
			e.printStackTrace();
		 }
		 finally
		 {
			
			try{
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
	<form name="getcorrectanswer" action="correctanswer.jsp" method="POST">
		<input type="radio" name="correctanswer" value=option1 ><%= request.getParameter("option1") %></input><br>
		<input type="radio" name="correctanswer" value=option2 ><%= request.getParameter("option2") %></input><br>
		<input type="radio" name="correctanswer" value=option3 ><%= request.getParameter("option3") %></input><br>
		<input type="radio" name="correctanswer" value=option4 ><%= request.getParameter("option4") %></input><br>
		<input type="button" value="Submit" onclick="submitforms()"></input>
	</form>
</body>
</html> 