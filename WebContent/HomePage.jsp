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
	
	<div><h1 style="text-align: left;">Invitation</h1></div>
	<div class="horizontal-events">
		<div class="event-list" id="invitedEvents">
			
		</div>
	</div>
	
	<h1 style="text-align: left;">Trending</h1>
	<div class="horizontal-events">
		<div class="event-list" id="popularEvents">
			
		</div>
	</div>
	
	<h1 style="text-align: center;">Friends' activities</h1>
	<div class="friend_activity">
		<!--  <div>
			<div class="post-activity" >
				<div id="PostEvents">
				
				</div>
			</div>
		</div>
		-->
		<div class="post-list">
			<div class="post-activity">
				<div class="PostEvents">
					<div class="post-title"><b>Title</b></div>
					<img class="post-img" src="images/Event4.jpg" alt="Event1">
					<div class="post-description">
						<span class = "postText">Event Name: name of event </span> <br><br>
						<span class= "postText">Time: time of event </span> <br><br>
						<span class= "postText">Description: Description of event </span> <br><br>
					</div>					
				</div>
			</div>	
		</div>
		
	</div>
	
	<div class="footer">
	
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
					window.location.replace("Login.jsp");
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
		
<script src="https://code.jquery.com/jquery-1.9.1.min.js"></script>
<script>
	var module = (function(){
		var inviteEvents = {};
		var popularEvents = {};
		var userPost = {};
		
		
		//Sets up initial State
		$(document).ready(function() {
			var xhttp = new XMLHttpRequest();

			xhttp.open("GET", "GetEventHomePage", false);	
			xhttp.send();
				
			var json = JSON.parse(xhttp.responseText); 
			
			inviteEvents = json.invited;
			popularEvents = json.popular;
			userPost = json.postActivity;
			
			//Add Initial events to display of Invited Events
			for(var i = 0; i < inviteEvents.length; i++) {
				var container = document.createElement("div");
				var a = document.createElement("a");
				a.href = "EventProfile.jsp?EventID=" + inviteEvents[i].id;
				var image = document.createElement("IMG");
				image.className = "event";
				image.src = inviteEvents[i].img;
				image.id = "inv" + i;
				a.append(image);	
				container.append(a);
				
				var message = "<b>You have been invited to " + inviteEvents[i].event_name + "</b>!";
				message += "<br> <b> Date:</b> " + inviteEvents[i].date;
				var textContainer = document.createElement("div");
				textContainer.innerHTML = message;
				container.append(textContainer);
				container.style = "display: inline-block;";
				document.getElementById("invitedEvents").append(container);
			}
			
			if(inviteEvents.length == 0) {
				var b = document.createElement("b");
				b.innerHTML = "You currently have no invites";
				document.getElementById("invitedEvents").append(b);
			}
			//Add Popular events
			for(var i = 0; i < popularEvents.length; i++) {
				var a = document.createElement("a");
				a.href = "EventProfile.jsp?EventID=" + popularEvents[i].id;
				var image = document.createElement("IMG");
				image.className = "event";
				image.src = popularEvents[i].img;
				image.id = "popular" + i;
				a.append(image);	
				document.getElementById("popularEvents").append(a);
			}
			//Add Post Activity
			for(var i = 0; i < userPost.length; i++) {
				var a = document.createElement("a");
				
				var image = document.createElement("IMG");
				image.className = "post-img";
				image.src = userPost[i].pictures;
				image.id = "post" + i;
				a.append(image);
				
				var related_event = document.createElement("a");
				related_event.innerHTML = "<br>Related event: " + userPost[i].related_Event.event_name;
				related_event.href = "EventProfile.jsp?EventID=" + userPost[i].related_Event.eventID;
				related_event.className = "post-description";
				a.append(related_event);
				
				var text = document.createElement("h2");
				text.innerHTML = userPost[i].post_text;
				text.className = "post-description";
				a.append(text);
				
				
				var container = document.createElement("div");
				container.className = "post-activity";
				
				var post = document.createElement("div");
				post.className = "PostEvents";
				
				var title = document.createElement("div");
				title.className = "post-title";
				title.innerHTML = userPost[i].related_Event.event_name + " has shared the post"
				
				var image = document.createElement("img");
				image.src = userPost[i].pictures;
				image.id = "post" + i;
				
				var description = document.createElement("div");
				description.className = "post-description";
				
				var name = document.createElement("span");
				name.className = "class-text";
				name.innerHTML = "Event Name: " + userPost[i].related_Event.event_name;
				
				var time = document.createElement("span");
				time.className = "class-text";
				time.innerHTML = "Event Time: ";
				
				var description = document.createElement("span");
				description.className = "class-text";
				description.innerHTML = "Post Description: " + userPost[i].post_text;

				document.getElementById("post-list").append(a);
			}	
		});
		
		function transitionElement(action, type) {
			/*switch(action) {
			case "back":
				var translation = "-100vw";
				for(var i = 0; i < 4; i++) {
					document.getElementById(type + i + 1).style.transition = "1s all ease-in-out";
					document.getElementById(type + i + 1).style.transform = "translateX(" + translation + ")";
				}
				break;
			case "front":
				var translation = "100vw";
				for(var i = 0; i < 4; i++) {
					id = type + (i + 1);
					document.getElementById(id).style.transition = "1s all ease-in-out";
					document.getElementById(id).style.transform = "translateX(" + translation + ")";
				}
				break;
			}*/
		} 
		
		return {
			transitionElement : transitionElement,
		};
	})();
</script>

<script src="https://code.jquery.com/jquery-1.11.1.js"></script>
    
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
</html>