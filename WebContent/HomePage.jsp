<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="occasion.account.User" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="css/homepage.css">
<title>HomePage</title>
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
	
	<div class="header">
		
	</div>
	
	<h1 style="text-align: center;">Invitation</h1>
	<div class="horizontal-events">
		<div class="scroll-events">
			<img class="event" src="images/Event1.jpg" alt="Event1">
			<img class="event" src="images/Event2.jpg" alt="Event2">
			<img class="event" src="images/Event3.jpg" alt="Event3">
			<img class="event" src="images/Event4.jpg" alt="Event4">
		</div>
	</div>
	
	<h1 style="text-align: center;">Trending</h1>
	<div class="horizontal-events">
		<div class="scroll-events">
			<img class="event" src="images/Event1.jpg" alt="Event1">
			<img class="event" src="images/Event2.jpg" alt="Event2">
			<img class="event" src="images/Event3.jpg" alt="Event3">
			<img class="event" src="images/Event4.jpg" alt="Event4">
		</div>
	</div>
	
	<h1 style="text-align: center;">Friends' activities</h1>
	<div class="friend_activity">
		<div class="vertical_scroll" >
			<img src="images/Event1.jpg" alt="Event1" height="60%" width="60%">
			<img src="images/Event2.jpg" alt="Event2" height="60%" width="60%">
			<img src="images/Event3.jpg" alt="Event3" height="60%" width="60%">
			<img src="images/Event4.jpg" alt="Event4" height="60%" width="60%">
		</div>
	</div>
	
	<div class="footer">
	
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
			
			function signout() {
				var sessionInfo = NewSession();
				sessionInfo.Item("login") = null;
			}
			

			
			
		</script>
</html>