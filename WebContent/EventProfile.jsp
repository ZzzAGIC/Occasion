<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<%@ page import="occasion.account.User" %>
<%@ page import="occasion.account.Post" %>
<%@ page import="occasion.event.Event, occasion.db.Database" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Date" %>
<link rel="stylesheet" href="css/homepage.css">
<title>Event Profile</title>

	<script>
		function display_invitation() {
			document.getElementById("new_invitation").style.display="initial"
				
		}
		
		function add(){
			<%
			String myname = null;
			
			if(session.getAttribute("myname") != null) {
					myname = session.getAttribute("myname").toString();
			
			}
			
			String E_ID = request.getParameter("EventID").toString();
			
			%>
			var myUsername = "<%=myname%>";
			console.log(myUsername);
			var EventID = "<%=E_ID%>";
			console.log(EventID);
			var type = "Add";
			var mylink = "Going_Event?Username="+myUsername+"&EventID="+EventID+"&Type="+type;
	
			console.log(mylink);
			var xhttp= new XMLHttpRequest();
			xhttp.open("GET", mylink, false);
			xhttp.send();
			
			
		}
		
		function remove(){
			<%
			
			
			if(session.getAttribute("myname") != null) {
					myname = session.getAttribute("myname").toString();
			
			}
			
			E_ID = request.getParameter("EventID").toString();
			
			%>
			var myUsername = "<%=myname%>";
			console.log(myUsername);
			var EventID = "<%=E_ID%>";
			console.log(EventID);
			var type = "Delete";
			var mylink = "Going_Event?Username="+myUsername+"&EventID="+EventID+"&Type="+type;
	
			console.log(mylink);
			var xhttp= new XMLHttpRequest();
			xhttp.open("GET", mylink, false);
			xhttp.send();
			
			
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
	<div class="profile_all" >
	
		<div class="event_profile" style="margin-left: auto; margin-right: auto;">
			<% 
			int EventID = Integer.parseInt(request.getParameter("EventID").toString());
		
			boolean own_event = false;
			String myusername = null;
			ArrayList<User> followingUsers = null;
			User curr_user = null;
			if(session.getAttribute("myname") != null) {
				myusername = session.getAttribute("myname").toString().toLowerCase();
				curr_user = new User(myusername);
				followingUsers = curr_user.getFollowingList();
				
			}
						

			Event curr_Event = new Event(EventID);
			String name = curr_Event.getEventName();
			int initiatorID = curr_Event.getInitiator();
			String initiator = User.getUsernameFromId(initiatorID).toLowerCase();
			boolean followed = false;
			if(initiator.compareTo(myusername) == 0) {
				own_event = true;
			} else {
				followed = curr_Event.userAlreadyFollowed(curr_user.getUserID());
			}
				
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
			
			ArrayList<User> attendents = curr_Event.getAttendants();
					
			%>
			

			<h1 align=center>Details for <%=name%></h1>
			<div style="margin-left: 40px; overflow: hidden;">			
				<div style="width: 40%; float: left;">
					<div>
						<div style="text-align: center">
							<img src="<%=img%>" style="float: none; position: absolute; left: 10%" alt="event image" align="left" height="150px" width="300px">
				    	</div>
				    	<div class="profile_text" style="position: absolute; top: 310px; text-align: left; left: 10%;">
					    	Type: <span id="Type"><%=type%></span><br><br>
					    	Initiator: <span id="Initiator">
					    		<a href="ProfilePage.jsp?Friend_User=<%=initiator%>">
								<%=initiator%>
								</a></span><br><br>
					    	Time: <span id="Time"><%=time%></span><br><br>
					    	Description: <span id="Description"><%=description%></span><br><br>
					    	Price: $<%=price%><br><br>
					    	Free spots: <%=freespots%><br><br>
					    	Location: <%=location%><br><br>
				    	</div>
			    	</div>
		    	</div>
		    	<div style="width: 60%; float: right;">
		    		<div class="map" id="map"></div>		    	
		    	</div>
	    	</div>
	    	<%if(!own_event) {
	    		if(!followed){%>
	    			<button class="button" id="AddEvent_button" type="button" onclick="add();" style="position: relative; left: 10%; margin-top: 10px;">Going event</button>
				<% } else { %>
					<button class="button" id="RemoveEvent_button" type="button" onclick="remove();" style="position: relative; left: 10%; margin-top: 10px;">Unfollow</button>	
			  <% }
	    	%>
				<h3 style="margin-left:	10%;">Attendents: </h3>
				<div class="horizontal-events">
					<div class="event-list">
						<%if(attendents != null){
						for(int i = 0; i < attendents.size(); i++ ){%> 			
						<div class = "friend-panel">
							<div class="friend-image-container">
								<a href="ProfilePage.jsp?Friend_User=<%=attendents.get(i).getUsername()%>">
								<img class="friend-image" src="<%=attendents.get(i).getImage() %>" 
								alt="<%=attendents.get(i).getUsername()%>'s profile image" >
								</a>
							</div>
							<h4 class="friend-text"><%=attendents.get(i).getUsername()%></h4>
						</div>			
						<%}%>
					</div>
				</div>		
				<% } else if(attendents == null){%> 
				<h4>N/A</h4>
				<%}%>
				
				<% } else if(own_event) { %>
				<div>
					<h3 style="margin-left:	40px; text-align: center">Attendents</h3>
					<div class="horizontal-events">
						<div class="event-list" style="margin-left: 5%;">
							<%if(attendents != null){
							for(int i = 0; i < attendents.size(); i++ ){%> 			
							<div class = "friend-panel">
								<div class="friend-image-container">
									<a href="ProfilePage.jsp?Friend_User=<%=attendents.get(i).getUsername()%>">
									<img class="friend-image" src="<%=attendents.get(i).getImage() %>" 
									alt="<%=attendents.get(i).getUsername()%>'s profile image" >
									</a>
								</div>
								<h4 class="friend-text"><%=attendents.get(i).getUsername()%></h4>
							</div>			
							<%}}%>
						</div>
					</div>	
					
					<div style="margin-left: 80px;">
						<button class="invite-button" id="button" type="button" onclick="display_invitation()">Invite friends!</button><br>
					    <div id="new_invitation" style="display:none;">
					    
						    <form class="form" action="new_invitation" method="post"> 
								<div id="formerror" style="color: red;"> 
								<%= request.getAttribute("error") != null ? request.getAttribute("error") : "" %>
								</div>
							    Select Users to invite:<br/>
								<%if(followingUsers != null){
									for(int i = 0; i < followingUsers.size(); i++ ){%> 
										<input type="checkbox" name="members" 
										value="<%=followingUsers.get(i).getUserID()%>"><%=followingUsers.get(i).getUsername()%>
										<br>
									
							    <%}}%> 
							    <input type="hidden" name ="EventID" value="<%= EventID %>"/>
							    <input class="button" type="submit" value="Invite!"/>  
							</form> 
					    </div>
				    </div>
			    </div>
				
			<%}%>
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
				    zoom: 15
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

<script src="https://code.jquery.com/jquery-1.9.1.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/socket.io/2.1.1/socket.io.js"></script>
<script>
        $(function () {
            //change username to current user
            var username = "<%=session.getAttribute("myname").toString().toLowerCase() %>";
            var socket = io("http://localhost:3000/");
            socket.emit('room name',username);
            socket.on('notification', function(data){
                document.getElementById("notificationBox").style.display = "block";
    	        document.getElementById("notification").innerHTML = "new message from " + data.from + "<br><a href='ProfilePage.jsp?Friend_User=" + data.from + "'>Click here to respond</a>";
            });
      });
 </script>	
</body>
</html>