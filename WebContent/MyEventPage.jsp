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
  
	    <h1 align=center>Events created by <%=myusername%></h1>
		<div class="horizontal-events">
			<%if(CreatedEvents != null){
			for(int i = 0; i < CreatedEvents.size(); i++ ){%> 
				<div class="event-list" id="invitedEvents">
					<div style="display: inline-block; height: 200px; width: 370px;">
						<a href="EventProfile.jsp?EventID=<%=CreatedEvents.get(i).getEventID()%>">
							<img class="event" src="<%=CreatedEvents.get(i).getPictures() %>" 
							alt="<%=CreatedEvents.get(i).getEventName()%>'s event image">
						</a>
					</div>
					<div>
						<h4><%=CreatedEvents.get(i).getEventName()%></h4>
					</div>
				</div>			
	    <%}}%> 
		
	    </div>
	    
	    <h1 align=center><%=myusername%>'s Future Events</h1>
		<div class="horizontal-events">
			<%if(FutureEvent != null){
			for(int i = 0; i < FutureEvent.size(); i++ ){%> 
				<div class="event-list" id="invitedEvents">
					<div style="display: inline-block">
						<a href="EventProfile.jsp?EventID=<%=FutureEvent.get(i).getEventID()%>">
							<img class="event" src="<%=FutureEvent.get(i).getPictures() %>" 
							alt="<%=FutureEvent.get(i).getEventName()%>'s event image">
						</a>
					</div>
					<div>
						<h4><%=FutureEvent.get(i).getEventName()%></h4>
					</div>
				</div>			
	    <%}}%> 
		
	    </div>
	</div>
	
	<div class="notificationBox" id="notificationBox">
		<p id="notification" class="notification-message"></p>
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
		
		<script src="https://cdnjs.cloudflare.com/ajax/libs/socket.io/2.1.1/socket.io.js"></script>
		<script src="https://code.jquery.com/jquery-1.9.1.min.js"></script>
		
		<script>
	        $(function () {
	            //change username to current user
	            var username = "<%=session.getAttribute("myname").toString().toLowerCase() %>";
	            var socket = io("http://localhost:3000/");
	            socket.emit('room name',username);
	            socket.on('notification', function(data){
	                document.getElementById("notificationBox").style.display = "block";
	                $('#notification').replaceWith($('<p class="notification-message">').text("new message from " + data.from));
	            });
	      });
	    </script>
</body>
</html>