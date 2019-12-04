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
	<script>
		function display_name() {
			document.getElementById("search_content").style.display="initial"
			document.getElementById("event_type_list").style.display="none"
	
		}
		function display_type() {
			document.getElementById("event_type_list").style.display="initial"
			document.getElementById("search_content").style.display="none"
	
		}
	</script>
	<script src="https://code.jquery.com/jquery-1.9.1.min.js"></script>	
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
		
		<div class="event_search">
		<form id="Eventsearch" method="Post" action="Event_search_validate" >
			<input id="search_content" type="text" name="Event_name" placeholder="Search an event!" style="width:35%; display:none;"> 
			<br>
			<input id="selection" type="radio" name="selection" value="EventName" onclick="display_name()">
			<label for="EventName">Search Name</label>
			<input id="selection" type="radio" name="selection" value="Type" onclick="display_type()">
			<label for="EventType">Search Type</label>
				<select id ="event_type_list" class="bar"  name="EventType" style="width:10%; display:none;">
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
			
			<!-- <input id="selection" type="radio" name="type" value="Location"> 
			<label for="Location">Location</label> -->
			 
			
			
			<button id="button" type="submit"> Search!</button>
		</form>
	</div>
		
	<%
		String myusername = null;
		boolean from_Search = false;
		if(session.getAttribute("myname") != null) {
			myusername = session.getAttribute("myname").toString(); 
		}
		User curr_user = new User(myusername);
		
		if(request.getAttribute("from_search") != null) {
			from_Search = true;
			/* System.out.println(Boolean.getBoolean(request.getAttribute("from_search").toString()));*/
		 }
		ArrayList<Event> all_Events = new ArrayList<Event> ();
		
		if(from_Search) {
			if(request.getAttribute("content") != null) {
				all_Events = (ArrayList<Event>) request.getAttribute("content"); 
			}
		}
		else {
			all_Events = curr_user.getAttendedEvent();
		}
		
		
	%>
	
	<div class="content">
		<div class="row">
			<div class="col eventList">
				<h1 align=center><i>Events you are attending</i></h1>
				<div class="vertical_scroll" style="margin-left: 30px">
				<%if(all_Events != null){
					for(int i = 0; i < all_Events.size(); i++ ){%> 
						<div class="row" style="white-space: nowrap;">
							<div class="vertical_event col">
								<a href="EventProfile.jsp?EventID=<%=all_Events.get(i).getEventID()%>">
								<img src="<%=all_Events.get(i).getPictures() %>" 
								alt="<%=all_Events.get(i).getEventName()%>'s event image" height="200" width="370">
								</a>					
							</div>
							<div class="col" style="text-align: left; padding-top: 20px;">
								<b>Event name: </b><%=all_Events.get(i).getEventName()%><br><br>
								<b>Time: <%= all_Events.get(i).getEventTime() %></b><br><br>
								<b>Description:  <%= all_Events.get(i).getDescription() %> </b>	
							</div>
						</div>		
			    <%}}%> 
			    </div>
			</div>
						
			<div class="col" id="map" style="margin-top: 50px;"></div>
		</div>
			
			<div class="recommended" style="font-size: 30px">	
				<b>Recommended events</b>
			</div>
			
			<div class="recommended horizontal-events">
				<div class="event-list" style="width: 100%;" id="recommendedEvents">
					<!-- Taken from W3Schools -->
					<div class="load"></div>
				</div>
			</div>
	</div>
	
	<div class="notificationBox" id="notificationBox">
		<p id="notification" class="notification-message"></p>
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
				window.location.replace("Login.jsp");
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

	<script>
		$(window).bind("load", function() { 
			var xhttp = new XMLHttpRequest();

			xhttp.open("GET", "GetRecommendedEvents", true);	
			xhttp.send();
			
			xhttp.onreadystatechange = function() {
				if (this.readyState == 4 && this.status == 200) {
					document.getElementById("recommendedEvents").innerHTML = "";
					var json = JSON.parse(this.responseText); 
					
					var recommendedEvents = json.recommended;
					
					//Add Initial events to display of Invited Events
					for(var i = 0; i < recommendedEvents.length; i++) {
						var container = document.createElement("div");
						var a = document.createElement("a");
						a.href = "EventProfile.jsp?EventID=" + recommendedEvents[i].id;
						var image = document.createElement("IMG");
						image.className = "event";
						image.src = recommendedEvents[i].img;
						image.id = "rec" + i;
						a.append(image);	
						container.append(a);
						
						var message = "<b>" + recommendedEvents[i].event_name + "</b>!";
						message += "<br> <b> Date:</b> " + recommendedEvents[i].date;
						var textContainer = document.createElement("div");
						textContainer.innerHTML = message;
						container.append(textContainer);
						container.style = "display: inline-block;";
						document.getElementById("recommendedEvents").append(container);
					}
				}
			}
		});
	</script>
	
	<script src="https://cdnjs.cloudflare.com/ajax/libs/socket.io/2.1.1/socket.io.js"></script>
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