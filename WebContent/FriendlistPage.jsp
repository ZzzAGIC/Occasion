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
<title>Friendlist Page!</title>
	<script>
		function display_friends() {
			document.getElementById("new_group").style.display="initial"
				
		}	
	</script>
	
	<script>
	function searchUser() {
		var xhttp = new XMLHttpRequest();
		var search = document.getElementById("search").value;
		var type = document.getElementById("selection").value;
		if(type == null) type = "Username";
		
		if(search == "") {
			document.getElementById("search-list").innerHTML = "";
			return;
		}
		
		xhttp.onreadystatechange = function() {
			if (this.readyState == 4 && this.status == 200) {
				document.getElementById("search-list").innerHTML = "";
				
				var response = this.responseText;
				
				
				if(response == "EMPTY") {
					return;
				}
				
				var json = JSON.parse(response);
					
				for(var i = 0; i < json.length; i++) {
					var friend_panel = document.createElement("div");
					friend_panel.className = "friend-panel";
					
					var container = document.createElement("div");
					container.className = "friend-image-container"
					
					var a = document.createElement("a");
					a.href = "ProfilePage.jsp?Friend_User=" + json[i].username;
					
					var image = document.createElement("img");
					image.className = "friend-image";
					image.src = json[i].image;
					
					var name = document.createElement("h4");
					name.className = "friend-text";
					name.innerHTML = json[i].username;
					
					a.append(image);
					container.append(a);
					friend_panel.append(container);
					container.append(name)
					document.getElementById("search-list").append(friend_panel);			
				}
		    }
		};
		  
		xhttp.open("POST", "SearchUser_validate?search=" + search + "&type=" + type, true);	
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
	
		<form id="UserSearch" method="Post" action="SearchUser_validate">
			<input id="search" type="text" name="search" placeholder="Search a Occasion User!" oninput="searchUser()" style="width:30%;"> <br>
			<div id="formerror">
			<%= request.getAttribute("error") != null ? request.getAttribute("error") : "" %>
			</div>
			<input id="selection" type="radio" name="type" value="Username">
			<label for="name">Username</label>
			<input id="selection" type="radio" name="type" value="Phone"> 
			<label for="author">Phone</label>
			<input id="selection" type="radio" name="type" value="Email"> 
			<label for="ISBN">Email</label> 			
		</form>

	<% 
		String myusername = null;
		if(session.getAttribute("myname") != null) {
			myusername = session.getAttribute("myname").toString(); 
		}
		User curr_user = new User(myusername);
		
		
		ArrayList<User> followingUsers = curr_user.getFollowingList();
		
				
	%>
	
	<div class="horizontal-events" id="friend_list">
	
			<div id="search-list" class="event-list">
				
			</div>		
	</div>
	
	<h1 align=center><%=myusername%>'s Following Users</h1>			
	<div class="horizontal-events">
		<div class="event-list">
		<%if(followingUsers != null){
			for(int i = 0; i < followingUsers.size(); i++ ){%> 
				<div class = "friend-panel">
					<div class="friend-image-container">
						<a href="ProfilePage.jsp?Friend_User=<%=followingUsers.get(i).getUsername()%>">
						<img class="friend-image" src="<%=followingUsers.get(i).getImage() %>" 
						alt="<%=followingUsers.get(i).getUsername()%>'s profile image" >
						</a>
					</div>
					<h4 class="friend-text"><%=followingUsers.get(i).getUsername()%></h4>
				</div>
	    <%}}%> 
	    </div>
	</div>
<%-- 	<div>
	    <h1 align=center><%=myusername%>'s Groups</h1>
		<div class="list">
		
	    </div>
	    
	    <button id="button" type="button" onclick="display_friends()">New Group</button><br>
	    <div id="new_group" style="display:none;">
	    
	    <form class="form" action="new_group" method="post"> 
	    <div id="formerror" style="color: red;"> 
		<%= request.getAttribute("error") != null ? request.getAttribute("error") : "" %>
		</div>
	    Group Name:<br/> <input class="bar"  type="text" name="GroupName"/><br/>
		Image:<br/> <input class="bar"  type="text" name="Picture"/><br/>
		Group Description:<br/> <input class="bar" type="text" name="Description"/><br/>
		Select Group members:<br/>
		<%if(followingUsers != null){
			for(int i = 0; i < followingUsers.size(); i++ ){%> 
				<input type="checkbox" name="members" 
				value="<%=followingUsers.get(i).getUserID()%>"><%=followingUsers.get(i).getUsername()%>
				<br>
			
	    <%}}%> 
	    <input class="button" type="submit" value="New Group"/>  
		</form> 
	    
	    </div>
	</div> --%>
	
		
	
	
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
                $('#notification').replaceWith($('<p class="notification-message">').text("new message from " + data.from));
            });
      });
 </script>
</html>