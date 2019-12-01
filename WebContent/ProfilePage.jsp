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
<title>ProfilePage</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>	
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
			
			if (xhttp.responseText.trim().length > 0) {
				document.getElementById("formerror").innerHTML= xhttp.responseText;
				
			}
				
            else{
	            document.getElementById("UnfollowUser_button").style.display="initial";
	 			document.getElementById("FollowUser_button").style.display="none";
            }
		}
		
		/* Unfollowing function*/
	
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
	<div class="profile_all">
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
		
		ArrayList<Event> all_Events = curr_user.getCreatedEvent();
		ArrayList<Post> all_Posts = curr_user.getPost();
				
		%>
    	<h1 align=center><%=curr_username%>'s Profile</h1>

    	<form method="post" action="FileUpload" enctype="multipart/form-data">
			<div id="img-container">
				<label for="newimg">
					<img src="<%=profile_img%>" alt="profile image" align="left" height="180" width="240">
				</label>
				<% if(own_profile) %><input id="newimg" type="file" name="newfile"/>
			</div>
			<% if(own_profile) %><input type="submit" value="submit" name="submit"/>
		</form>
		
		
		<form action="EditProfile" method="POST">
	    	<div class="profile_text" id="prof-text">
		    	<h4>GENDER: <span id="genderDetail"><%=gender%></span></h4>
		    	<h4>EMAIL ADDRESS: <span id="emailDetail"><%=Email%></span></h4>
		    	<h4>PHONE: <span id="phoneDetail"><%=phone%></span></h4>
		    	<h4>DATE OF BIRTH: <span id="birthDetail"><%=birthday%></span></h4>
		    	<h4>POINTS: <%=points%></h4>
	    	</div>
	    	<div id="submitButton"><button class="button" id="EditProfile_button" type="button" onclick="module.editProfile();">Edit profile</button></div>
			<button class="button" id="FollowUser_button" type="button" onclick="add_following();">Follow</button>
			<button class="button" id="UnfollowUser_button" type="button" onclick="Unfollowing();" style="display: none;">Unfollow</button>
		
		</form>
	</div>
	
	<div id="chat">
	<button class="button" onclick="chat()">chat</button>
	</div>
	
	<h1 style="text-align: center;">Recent events for <%=curr_username%></h1>
	<div class="profile_activity">
		<div class="scroll-events" >
		<%if(all_Events != null){
			for(int i = 0; i < all_Events.size(); i++ ){%> 
				
				<a href="EventProfile.jsp?EventID=<%=all_Events.get(i).getEventID()%>">
				<img src="<%=all_Events.get(i).getPictures() %>" 
				alt="<%=all_Events.get(i).getEventName()%>'s profile image" height="180" width="220">
				</a>
				<%-- <h4><%=all_Events.get(i).getEventName()%></h4>	 --%>
	    <%}}%> 
	    </div>
	</div>
	
	<h1 style="text-align: center;"><%=curr_username%>'s Posts</h1>
	<div class="profile_posts">
		<div class="vertical_scroll" >
		<%if(all_Posts != null){
			for(int i = 0; i < all_Posts.size(); i++ ){%> 
				<a href="EventProfile.jsp?EventID=<%=all_Events.get(i).getEventID()%>">
				<img src="<%=all_Posts.get(i).getPictures() %>" 
				alt="<%=all_Events.get(i).getEventName()%>'s profile image" height="180" width="220">
				</a>
	    <%}}%> 
	    </div>
	</div>
	
	</div>
	
	<div class="footer">
	
	</div>
	<script>
		function chat(){
			var un = "<%= myname.toLowerCase() %>";
			var ou = "<%= curr_username.toLowerCase()%>";
			document.getElementById('chat').innerHTML = "<iframe src=\"http://localhost:3000/?username="
					+un+"&otherUser="+ou+"\"></iframe>"+"<br><button class=\"button\" onclick=\"closeChat()\">close chat</button>";
		}
		function closeChat(){
			document.getElementById('chat').innerHTML = "<button class=\"button\" onclick=\"chat()\">chat</button>";
		}
	</script>
</body>
	<script>
		var module = (function(){
			var inputGender = document.getElementById('genderDetail').innerHTML;
			var inputEmail = document.getElementById('emailDetail').innerHTML;
			var inputPhone = document.getElementById('phoneDetail').innerHTML;
			var inputBirth = document.getElementById('birthDetail').innerHTML;
			
			function editProfile() {	
				document.getElementById("genderDetail").innerHTML = "";
				var genderSearch = document.createElement("INPUT");
				genderSearch.setAttribute("type", "search");
				genderSearch.value = inputGender;
				genderSearch.setAttribute("id", "genderSearch");
				genderSearch.setAttribute("name", "genderSearch");
				document.getElementById("genderDetail").appendChild(genderSearch);
				
				document.getElementById("emailDetail").innerHTML = "";
				var emailSearch = document.createElement("INPUT");
				emailSearch.setAttribute("type", "search");
				emailSearch.value = inputEmail;
				emailSearch.setAttribute("id", "emailSearch");
				emailSearch.setAttribute("name", "emailSearch");
				document.getElementById("emailDetail").appendChild(emailSearch);
				
				document.getElementById("phoneDetail").innerHTML = "";
				var phoneSearch = document.createElement("INPUT");
				phoneSearch.setAttribute("type", "search");
				phoneSearch.value = inputPhone;
				phoneSearch.setAttribute("id", "phoneSearch");
				phoneSearch.setAttribute("name", "phoneSearch");
				document.getElementById("phoneDetail").appendChild(phoneSearch);
				
				document.getElementById("birthDetail").innerHTML = "";
				var birthSearch = document.createElement("INPUT");
				birthSearch.setAttribute("type", "date");
				birthSearch.value = inputBirth;
				birthSearch.setAttribute("id", "birthSearch");
				birthSearch.setAttribute("name", "birthSearch");
				document.getElementById("birthDetail").appendChild(birthSearch);
				
				var submit = document.createElement("INPUT");
				submit.setAttribute("type", "submit");
				submit.setAttribute("class", "submitButtonElement")
				submit.value = "Submit"
				document.getElementById("submitButton").innerHTML = "";
				document.getElementById("submitButton").appendChild(submit);
			}
							
			return {
			    editProfile: editProfile,
			};
		})();
		
	</script>
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