<!doctype html>
<html>
    <head>
            <title>Page to give exam</title>
            <script>
	
                    function submitforms()
                        {
                            
                            
                                document.forms.getcorrectanswer.submit();
                            
                            
                        }
                
                
                </script>
    </head> 
    <body>
        par c=0;
            <form name="" action="" method="POST">
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
                
               String sql="SELECT column FROM mainquestions ORDER BY RAND ( )";
               ResultSet rs = stmt.executeQuery(sql); // Getting a questions in a random order
               while(rs.next())
               {
                String question = rs.getString("question");
                String option1 = rs.getString("option1");
                String option2 = rs.getString("option2");
                String option3 = rs.getString("option3");
                String option4 = rs.getString("option4");
            %>
                <div>
                        <input type="radio" name="correctanswer" value=option1 ><%= request.getParameter("option1") %></input><br>
                        <input type="radio" name="correctanswer" value=option2 ><%= request.getParameter("option2") %></input><br>
                        <input type="radio" name="correctanswer" value=option3 ><%= request.getParameter("option3") %></input><br>
                        <input type="radio" name="correctanswer" value=option4 ><%= request.getParameter("option4") %></input><br>
                        <input type="button" value="Submit" onclick="submitforms()"></input>
                </div>
             <%   }
               
                
               
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
        
                
            </form>
    </body>  
</html>