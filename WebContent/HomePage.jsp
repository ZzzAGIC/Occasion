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
		<div class= "event-scroll back" id="back" onclick="module.transitionElement(this.id, 'inv');"></div>
		<div class="event-list" id="invitedEvents">
			
		</div>
		<div class="forward event-scroll" id="front" onclick="module.transitionElement(this.id, 'inv');"></div>
	</div>
	
	<h1 style="text-align: left;">Trending</h1>
	<div class="horizontal-events">
		<div class= "event-scroll back" id="back" onclick="module.transitionElement(this.id, 'trend');"></div>
		<div class="event-list" id="popularEvents">
			
		</div>
		<div class="forward event-scroll" id="front" onclick="module.transitionElement(this.id, 'trend');"></div>
	</div>
	
	<h1 style="text-align: center;">Friends' activities</h1>
	<div class="friend_activity">
		<div class="vertical_scroll" >
			<div class="post-activity">
				<img class="post-img" src="images/Event1.jpg" alt="Event1">
				<div class="post-description">
					<b>Text Description</b>
				</div>
			</div>
			<div class="post-activity">
				<img class="post-img" src="images/Event2.jpg" alt="Event1">
			</div>
			<div class="post-activity">
				<img class="post-img" src="images/Event3.jpg" alt="Event1">
			</div>
			<div class="post-activity">
				<img class="post-img" src="images/Event4.jpg" alt="Event1">
			</div>
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
				var a = document.createElement("a");
				a.href = "EventProfile.jsp?EventID=" + inviteEvents[i].id;
				var image = document.createElement("IMG");
				image.className = "event";
				image.src = inviteEvents[i].img;
				image.id = "inv" + i;
				a.append(image);	
				document.getElementById("invitedEvents").append(a);
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
</html>