<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<%@ page import="occasion.account.User" %>
<%@ page import="occasion.event.Event" %>
<%@ page import="java.util.ArrayList" %>
<link rel="stylesheet" href="css/Login.css">
<title>Add Post</title>
</head>
<body>
	
	<div align="center">
		<form class="form" action="add_post" method="post">
		<div id="formerror" style="color: red;">  
		<%= request.getAttribute("error") != null ? request.getAttribute("error") : "" %>
		</div>
		<br/>
		Text:<br/> <input class="bar" type="text" name="post_text" style="height:100px;"/><br/><br/>  
		Post image:<br/> <input class="bar" type="text" name="post_image"/><br/><br/>  
		
		Post Event:<br/> <select  name="event">
					<% 
					String myusername = null;
					if(session.getAttribute("myname") != null) {
						myusername = session.getAttribute("myname").toString(); 
					}
					User curr_user = new User(myusername);
					ArrayList<Event> CreatedEvents = curr_user.getCreatedEvent();
					
						
					%>
					<%if(CreatedEvents != null){
					for(int i = 0; i < CreatedEvents.size(); i++ ){
						String e_id = Integer.toString(CreatedEvents.get(i).getEventID());
						String e_name = CreatedEvents.get(i).getEventName();
					%> 
						
						<option value="<%=e_id%>"><%=e_name%></option>
					
			   		 <%}}%> 
								
		</select><br/><br/>
		
		<input class="button" type="submit" name="status" />  
		</form>  
	</div>
	
	
	
	
	
</body>
</html>