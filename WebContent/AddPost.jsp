<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<%@ page import="occasion.account.User" %>
<%@ page import="occasion.event.Event" %>
<%@ page import="java.util.ArrayList" %>
<link rel="stylesheet" href="css/homepage.css">
<title>Add Post</title>
</head>
<body>
<div class="navbar">
		<h1 class="logo">Occasion</h1>
		<button class="button" id="Homepage_button" type="button" onclick="window.location='HomePage.jsp'">Home Page</button>

		<div class="dropdown">
		<button class="button" type="button" >Profile</button>
			<div class="dropdown-content">
    			<button class="subbutton" id="Login_button" type="button" onclick="window.location='Login.jsp'">Login</button>
    			<button class="subbutton" id="Profilepage_button" type="button" onclick="window.location='ProfilePage.jsp'">My Profile</button>
  				<br>
				<button class="subbutton" id="Register_button" type="button" onclick="window.location='Register.jsp'">Register</button>
  				<form action="Signout">
  					<input class="subbutton" id="Signout_button" type="submit" value="Sign out"/>
  				</form>
  			</div>
  		</div>
  		
  		<div class="dropdown">
		<button class="button" id="Friendpage_button" type="button" >Friend list</button>
			<div class="dropdown-content">
    			<button class="subbutton" id="Friendlist_button" type="button" onclick="window.location='FriendlistPage.jsp'">Friend List</button>
    			<br>
				<button class="subbutton" id="Chat_button" type="button" onclick="">Chats</button>
  				
  			</div>
		</div>
		
		<div class="dropdown">
		<button class="button" id="Eventpage_buttom" type="button">Event</button>	
			<div class="dropdown-content">
			<button class="subbutton" id="ExploreEvent_buttom" type="button" onclick="window.location='EventPage.jsp'">Explore Events</button>	
			<br>
			<button class="subbutton" id="AddEvent_buttom" type="button" onclick="window.location='AddEventPage.jsp'">Add Event</button>
			<br>
			<button class="subbutton" id="MyEvent_buttom" type="button" onclick="window.location='MyEventPage.jsp'">My Event</button>
			</div>
		</div>
		
		<div class="dropdown">
		<button class="button" id="Add_buttom" type="button">+</button>	
			<div class="dropdown-content">
			<button class="subbutton" id="AddPost_buttom" type="button" onclick="window.location='AddPost.jsp'">Add Post</button>	
			<br>
			<button class="subbutton" id="AddEvent_buttom" type="button" onclick="window.location='AddEventPage.jsp'">Add Event</button>
			</div>
		</div>
		<p id="notification"></p>
	</div>
	
	<div class="AddPost">
		<div class="form-banner">
					<p class="banner-title">Add Post</p>
		</div>
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
						ArrayList<Event> AttendedEvents = curr_user.getAttendedEvent();
						ArrayList<Event> FutureEvents = curr_user.getFutureEvent();
						
						ArrayList<Event> AllEvents = new ArrayList<Event> ();
						for(int i = 0; i < CreatedEvents.size(); i++) {
							AllEvents.add(CreatedEvents.get(i));
						}
						for(int i = 0; i < AttendedEvents.size(); i++) {
							AllEvents.add(AttendedEvents.get(i));
						}
						for(int i = 0; i < FutureEvents.size(); i++) {
							AllEvents.add(FutureEvents.get(i));
						}
							
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
	</div>
	
	<script>
		var login  = <%=session.getAttribute("login")%>
		if(login != null) {
			if(login == true) {
				//already login, display profile & signout
				document.getElementById("Login_button").style.display="none"
				document.getElementById("Register_button").style.display="none"
				document.getElementById("Profilepage_button").style.display="initial"
				document.getElementById("Signout_button").style.display="initial"
			}
			else {
				//not login, display login & register
				document.getElementById("Login_button").style.display="initial"
				document.getElementById("Register_button").style.display="initial"
				document.getElementById("Profilepage_button").style.display="none"
				document.getElementById("Signout_button").style.display="none"
			}
			
		}
		//first open, same as not login
		else {
			document.getElementById("Login_button").style.display="initial"
			document.getElementById("Register_button").style.display="initial"
			document.getElementById("Profilepage_button").style.display="none"
			document.getElementById("Signout_button").style.display="none"			
		}
		
		function signout() {
			var sessionInfo = NewSession();
			sessionInfo.Item("login") = null;
		}			
	</script>
	
	
	
</body>
</html>