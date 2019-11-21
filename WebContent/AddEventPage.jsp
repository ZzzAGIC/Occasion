<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="css/homepage.css">
<title>Add Event</title>
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
		
		
	<div class="AddEvent" >
		<form class="AddEventForm" action="Addevent_validate" method="post" onsubmit="return validate();"> 
			<div id="formerror" style="color: red;"> 
			<%= request.getAttribute("error") != null ? request.getAttribute("error") : "" %>
			</div>
			<br/>

			EventName:<br/> <input class="bar" type="text" name="EventName"/><br/><br/>  
			
			EventTime:<br/> <input class="bar" type="date" name="EventTime"/><br/><br/>  
			
			Location:<br/> <input class="bar" type="text" name="EventName"/><br/><br/> 
				Street:<br/> <input class="bar" type="text" name="EventName"/><br/><br/> 
				City:<br/> <input class="bar" type="text" name="EventName"/><br/><br/> 
				State:<br/> <input class="bar" type="text" name="EventName"/><br/><br/> 
				Country:<br/> <input class="bar" type="text" name="EventName"/><br/><br/> 
				Zipcode:<br/> <input class="bar" type="text" name="EventName"/><br/><br/> 
				
			Type:<br/> 
				<select class="bar" type="selection" name="EventTime">
					<option value="academic">Academic</option>
					<option value="leisure">Leisure</option>
					<option value="music">Music</option>
					<option value="party">Party</option>
					<option value="sports">Sports</option>
					<option value="stu_org">Student Organization</option>
					<option value="other">Other</option>
				</select> <br/><br/> 
			<!-- host ID -->
			capacity:<br/> <input class="bar" type="text" name="EventName"/><br/><br/>  
			
			price:<br/> <input class="bar" type="text" name="EventTime"/><br/><br/>  
			
			Description:<br/> <input class="bar" type="text" name="EventTime"/><br/><br/>  
			
			Pictures:<br/> <input class="bar" type="text" name="EventTime"/><br/><br/>
			
			<input class="button" type="submit" name="status" value="Add Event"/>  
		</form>  
		
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
</html>