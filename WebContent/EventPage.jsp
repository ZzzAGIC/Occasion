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
		
		<div class="dropdown">
		<button class="button" id="Add_buttom" type="button">+</button>	
			<div class="dropdown-content">
			<button class="subbutton" id="AddPost_buttom" type="button" onclick="window.location='AddPost.jsp'">Add Post</button>	
			<br>
			<button class="subbutton" id="AddEvent_buttom" type="button" onclick="window.location='AddEventPage.jsp'">Add Event</button>
			</div>
		</div>
		
	</div>
		
	<div class="event_search">
		<form id="Eventsearch" method="Post" action="" >
			<input id="search" type="text" name="search" placeholder="Search an event!" style="width:30%;"> 
			Type:<select class="bar"  name="EventType" style="width:10%;">
					<option value="all">ALL</option>
					<option value="academic">Academic</option>
					<option value="leisure">Leisure</option>
					<option value="music">Music</option>
					<option value="party">Party</option>
					<option value="sports">Sports</option>
					<option value="stu_org">Student Organization</option>
					<option value="other">Other</option>
				</select>
			<br>
			<div id="formerror">
			<%= request.getAttribute("error") != null ? request.getAttribute("error") : "" %>
			</div>
			<input id="selection" type="radio" name="type" value="Username">
			<label for="EventName">Event Name</label>
			<input id="selection" type="radio" name="type" value="Phone"> 
			<label for="Location">Location</label>
			 
			
			
			<button id="button" type="submit"> Search!</button>
		</form>
	</div>
		
	<%
		String myusername = null;
		if(session.getAttribute("myname") != null) {
			myusername = session.getAttribute("myname").toString(); 
		}
		User curr_user = new User(myusername);
		
		
		ArrayList<Event> all_Events = curr_user.getRecommendedEvents();
	
	%>
	
	<div class="eventList">
		<h1 align=center><i>Events for <%=myusername%></i></h1>
		<div class="list_v">
		<%if(all_Events != null){
			for(int i = 0; i < all_Events.size(); i++ ){%> 
				
				<img src="<%=all_Events.get(i).getPictures() %>" 
				alt="<%=all_Events.get(i).getEventName()%>'s profile image" height="180" width="220">
				</a>
				<h4><%=all_Events.get(i).getEventName()%></h4>
				<h4><%=all_Events.get(i).getLocation().getlongitute()%></h4>
				<h4><%=all_Events.get(i).getLocation().getlatitude()%></h4>
			
	    <%}}%> 
	    </div>
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
				    center: {lat: 34.0522, lng: -118.2437},
				    zoom: 11
			     };
			   	var map = new google.maps.Map(document.getElementById('map'),option);
			   	
			   	
			   	var locations = [];
			   	
			   	<%if(all_Events != null){
					for(int i = 0; i < all_Events.size(); i++ ){%> 
						
						
						var name = '<%=all_Events.get(i).getEventName()%>'
						var lat = <%=all_Events.get(i).getLocation().getlatitude()%>;
						var lng = <%=all_Events.get(i).getLocation().getlongitute()%>;
						locations.push(name,lat,lng);
					
			    <%}}%> 
			    /* for (i = 0; i < locations.length; i+=3) {  
			    	console.log(locations[i])
			        console.log(locations[i+1]+" "+locations[i+2])
			      } */
			   	
			   	
			   	
			   	/* var marker = new google.maps.Marker({
			   	    position: myLatLng,
			   	    map: map,
			   	    title: 'Hello World!'
			   	  }); */
			   	var marker, i;

			      for (i = 0; i < locations.length; i+=3) {  
			        marker = new google.maps.Marker({
			          position: new google.maps.LatLng(locations[i+1], locations[i+2]),
			          map: map
			        });
			      }
		   }
	</script>
	
	<script async defer
		      src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBsK1nRM2sfZDiQE7P4MIkxwUrft61TUTw&callback=initMap">
	</script>
</body>
			
</html>