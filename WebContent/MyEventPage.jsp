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
<title>My Event</title>
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
		
	</div>
	
	
	<div class="MyEvent_List">
		<% 
		String myusername = null;
		if(session.getAttribute("myname") != null) {
			myusername = session.getAttribute("myname").toString(); 
		}
		User curr_user = new User(myusername);
		ArrayList<Event> CreatedEvents = curr_user.getCreatedEvent();
		ArrayList<Event> FutureEvent = curr_user.getFutureEvent();
		
				
		%>
  
	    <h1 align=center><i>Events created by <%=myusername%></i></h1>
		<div class="list">
			<%if(CreatedEvents != null){
			for(int i = 0; i < CreatedEvents.size(); i++ ){%> 
				
				<a href="EventProfile.jsp?EventID=<%=CreatedEvents.get(i).getEventID()%>">
				<img src="<%=CreatedEvents.get(i).getPictures() %>" 
				alt="<%=CreatedEvents.get(i).getEventName()%>'s event image" height="180" width="220">
				</a>
				<h4><%=CreatedEvents.get(i).getEventName()%></h4>
			
	    <%}}%> 
		
	    </div>
	    
	    <h1 align=center><i><%=myusername%>'s Future Events</i></h1>
		<div class="list">
			<%if(FutureEvent != null){
			for(int i = 0; i < FutureEvent.size(); i++ ){%> 
				
				<a href="EventProfile.jsp?EventID=<%=FutureEvent.get(i).getEventID()%>">
				<img src="<%=FutureEvent.get(i).getPictures() %>" 
				alt="<%=FutureEvent.get(i).getEventName()%>'s event image" height="180" width="220">
				</a>
				<h4><%=FutureEvent.get(i).getEventName()%></h4>
			
	    <%}}%> 
	    </div>
	    
	    <h1 align=center><i><%=myusername%>'s Past Events</i></h1>
		<div class="list">
		
	    </div>
	</div>
	
</body>
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
			
			

			
			
		</script>
</body>
</html>