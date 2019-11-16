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
		
	</div>
	
	
	<form id="UserSearch" method="Post" action="SearchUser_validate" >
			<input id="search" type="text" name="search" placeholder="Search a Occasion User!"> <br>
			<div id="formerror">
			<%= request.getAttribute("error") != null ? request.getAttribute("error") : "" %>
			</div>
			<input id="selection" type="radio" name="type" value="Username">
			<label for="name">Username</label>
			<input id="selection" type="radio" name="type" value="Phone"> 
			<label for="author">Phone</label>
			<input id="selection" type="radio" name="type" value="Email"> 
			<label for="ISBN">Email</label> 
			
			
			<button id="button" type="submit"> Search!</button>
		</form>
	
	
	<div class="friend_list">
		<% 
		String myusername = null;
		if(session.getAttribute("myname") != null) {
			myusername = session.getAttribute("myname").toString(); 
		}
		User curr_user = new User(myusername);
		
		
		ArrayList<User> followingUsers = curr_user.getFollowingList();
		
				
		%>
    	<h1 align=center><i><%=myusername%>'s Following Users</i></h1>

		<%if(followingUsers != null){
			for(int i = 0; i < followingUsers.size(); i++ ){%> 
			<h2>Friend's profile image: <img src="<%=followingUsers.get(i).getImage()%>" 
			alt="<%=followingUsers.get(i).getUsername()%>'s profile image"></h2>
			<h2>Friend's name: <%=followingUsers.get(i).getUsername()%></h2>
	    <%}}%> 
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
		</script>
		
		<script>
		
		</script>
</html>