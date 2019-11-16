<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<%@ page import="occasion.account.User" %>
<%@ page import="occasion.event.Event" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Date" %>
<link rel="stylesheet" href="css/homepage.css">
<title>ProfilePage</title>
	<script>
		function add_following(){
			<%
			String myname = null;
			String follow_username = null;
			if(request.getParameter("Friend_User")!=null){
				follow_username = request.getParameter("Friend_User").toString();
			}
			if(session.getAttribute("myname") != null) {
					myname = session.getAttribute("myname").toString();
			
			}
			
			%>
			var myUsername = "<%=myname%>";
			console.log(myUsername);
			var follow_Username = "<%=follow_username%>";
			console.log(follow_Username);
			
			var mylink = "follow_user?Follower="+myUsername+"&Following="+follow_Username;
	
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
	<div class="profile_info">
		<% 
		String curr_username = null;
		boolean own_profile = false;
		if(request.getParameter("Friend_User")!=null){
			curr_username = request.getParameter("Friend_User").toString();
		}
		else if(request.getParameter("Friend_User")==null){
		
			if(session.getAttribute("myname") != null) {
				curr_username = session.getAttribute("myname").toString(); 
				own_profile = true;
			}
		}
		User curr_user = new User(curr_username);
		
		String profile_img = curr_user.getImage();
		String gender = curr_user.getGender();
		String Email = curr_user.getEmail();
		String phone = curr_user.getPhone();
		Date birthday = curr_user.getBirthday();
		int points = curr_user.getPoints();
		ArrayList<Event> pastEvent = curr_user.getAttendedEvent();
		ArrayList<Event> futureEvent = curr_user.getFutureEvent();
		
				
		%>
    	<h1 align=center><i><%=curr_username%>'s Profile</i></h1>
    	<img src="<%=profile_img%>" alt="profile image">
    	<h2>GENDER: <%=gender%></h2>
    	<h2>EMAIL ADDRESS: <%=Email%></h2>
    	<h2>PHONE: <%=phone%></h2>
    	<h2>DATE OF BIRTH: <%=birthday%></h2>
    	<h2>POINTS: <%=points%></h2>
    	<button class="button" id="EditProfile_button" type="button" onclick=>Edit profile</button>
		<button class="button" id="FollowUser_button" type="button" onclick="add_following();">Follow</button>
	</div>
	
	<div class="profile_activity">
		<%if(pastEvent != null){
			for(int i = 0; i < pastEvent.size(); i++ ){%> 
			<h2>Past Event: <%=pastEvent.get(i).getEventName()%></h2>
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
			
			var own = <%=own_profile%>;
			if(own) {
				//this is my profile page, display edit button
				document.getElementById("FollowUser_button").style.display="none"
				document.getElementById("EditProfile_button").style.display="initial"
				
			}
			else if(!own) {
				//this is other user's button, display add/remove button
				document.getElementById("FollowUser_button").style.display="initial"
				document.getElementById("EditProfile_button").style.display="none"
			}
			
			

			
			
		</script>
</html>