<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<%@ page import="occasion.account.User" %>
<%@ page import="occasion.account.Post" %>
<%@ page import="occasion.event.Event" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Date" %>
<link rel="stylesheet" href="css/homepage.css">
<title>Event Profile</title>

	<script>
		function add(){
			
			
		}
	
	</script>
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
	<div class="profile_all">
	
		<div class="event_profile">
			<% 
			int EventID = Integer.parseInt(request.getParameter("EventID").toString());
		
			/* boolean own_event = false; */
			

			Event curr_Event = new Event(EventID);
			String name = curr_Event.getEventName();
			String initiator = curr_Event.getInitiator().getUsername();
			String img = curr_Event.getPictures();
			String type = curr_Event.getType();
			String description = curr_Event.getDescription();
			
			int freespots = curr_Event.getCapacity() - curr_Event.getCurrNum();
			int price = curr_Event.getPrice();
			Date time = curr_Event.getEventTime();
			
			String street = curr_Event.getLocation().getstreet();
			String city = curr_Event.getLocation().getcity();
			String lng_ = curr_Event.getLocation().getlongitute();
			String lat_ = curr_Event.getLocation().getlatitude();
			
			String location = street + " " + city;
					
			%>
			
			<h1 align=center><i>Details for <%=name%></i></h1>

	    	<img src="<%=img%>" alt="event image" align="left" height="180" width="240">

	    	<div class="profile_text">
		    	<h4>Type: <span id="Type"><%=type%></span></h4>
		    	<h4>Initiator: <span id="Initiator">
		    		<a href="ProfilePage.jsp?Friend_User=<%=initiator%>">
					<%=initiator%>
					</a></span></h4>
		    	<h4>Time: <span id="Time"><%=time%></span></h4>
		    	<h4>Description: <span id="Description"><%=description%></span></h4>
		    	<h4>Price: <%=price%></h4>
		    	<h4>Free spots: <%=freespots%></h4>
		    	<h4>Location: <%=location%></h4>
	    	</div>
	    	<button class="button" id="AddEvent_button" type="button" onclick="add();">Going event</button>
			<button class="button" id="RemoveEvent_button" type="button" onclick="remove();" style="display: none;">Not Going</button>

		<div id="map"></div>
		
		
		
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
			

		   function initMap() {
			   	var option ={
				    center: {lat: <%=lat_%>, lng: <%=lng_%>},
				    zoom: 11
			     };
			   	var map = new google.maps.Map(document.getElementById('map'),option);
			   	
			   
			   	  
			        marker = new google.maps.Marker({
			          position: new google.maps.LatLng(<%=lat_%>, <%=lng_%>),
			          map: map
			        });
			  
		   }
	</script>
	
	<script async defer
		      src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBsK1nRM2sfZDiQE7P4MIkxwUrft61TUTw&callback=initMap">
	</script>
	
	
</body>
</html>