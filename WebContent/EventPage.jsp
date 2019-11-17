<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="css/homepage.css">
<title>Event Page</title>
</head>
<body>
<div class="navbar">
		<h1 class="logo">Occasion</h1>
		<button class="button" id="Homepage_button" type="button" onclick="window.location='HomePage.jsp'">Home Page</button>
		<div class="dropdown">
		<button class="button" type="button" >Profile</button>
			<div class="dropdown-content">
    			<button class="subbutton" id="Login_button" type="button" onclick="window.location='Login.jsp'">Login</button>
    			<br>
				<button class="subbutton" id="Register_button" type="button" onclick="window.location='Register.jsp'">Register</button>
  				<br>
  				<button class="subbutton" id="Profilepage_button" type="button" onclick="window.location='ProfilePage.jsp'">My Profile</button>
  				<br>
				<form action="Signout" method = "POST">
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
	</div>
		
	<div class="event_search">
		<form id="Eventsearch" method="Post" action="" >
			<input id="search" type="text" name="search" placeholder="Search an event!" style="width:40%;"> <br>
			<div id="formerror">
			<%= request.getAttribute("error") != null ? request.getAttribute("error") : "" %>
			</div>
			<input id="selection" type="radio" name="type" value="Username">
			<label for="name">Event Name</label>
			<input id="selection" type="radio" name="type" value="Phone"> 
			<label for="author">Location</label>
			<input id="selection" type="radio" name="type" value="Email"> 
			<label for="ISBN">Type</label> 
			
			
			<button id="button" type="submit"> Search!</button>
		</form>
	</div>
		

	
	<div class="eventList">
		<table> 
	         <tr bgcolor="#cccccc"> 
	          <th id="eventName"><b>Event Name</b></th> 
	          <th id="time"><b>Time</b></th> 
	          <th id="location"><b>Location</b></th> 
	          <th id="description"><b>Description</b></th> 
	         </tr> 
		
		</table>
	</div>
		
		
	<div id="map"></div>


	

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
			

		   function initMap() {
			   	var option ={
				    center: {lat: -34.397, lng: 150.644},
				    zoom: 8
			     };
			   	var map = new google.maps.Map(document.getElementById('map'),option);
		   }
	</script>
	
	<script async defer
		      src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBsK1nRM2sfZDiQE7P4MIkxwUrft61TUTw&callback=initMap">
	</script>
</body>
			
</html>