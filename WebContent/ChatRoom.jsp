<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="occasion.account.User" %>
<%@ page import="occasion.chat.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="css/homepage.css">
<title>CHATROOM</title>
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
				<button class="subbutton" id="Chat_button" type="button" onclick="window.location='ChatRoom.jsp''">Chats</button>
  				
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
	
	<div class="header">
		
	</div>
	
	<form>
		<input id="textMessage" type="text">
		<input onclick="sendMessage();" value="Send Message" type="button">	
	</form>
	<br> <textarea id="messagesTextArea" rows="10" cols="50"></textarea> <br>
	<script type="text/javascript">
	</script>
	
	
	<button class="button" id="chatButton" type="button" onclick="initiateChatroom()">Create chat</button>
	<button class="button" id="chatButton" type="button" onclick="initiateChatroom()">Join chat</button>
	
	
	<div class="footer">
	
	</div>

</body>
	<script>
			var login  = <%=session.getAttribute("login")%>
			var webSocket;
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
			
			function initiateChatroom() {
				webSocket = new WebSocket("ws://localhost:8080/Occasion/serverendpointdemo");
				var messagesTextArea = document.getElementById("messagesTextArea");
				webSocket.onopen = function(message) {processOpen(message);};
				webSocket.onclose = function(message) {processClose(message);};
				webSocket.onerror = function(message) {processError(message);};
				webSocket.onmessage = function(message) {processMessage(message);};

			}
			function processOpen(message) {
				messagesTextArea.value += "Server connect ...\n";
			}
			function sendMessage() {
				if(textMessage.value !="close") {
					webSocket.send(textMessage.value);
					messagesTextArea.value += "Send to Server ==> " + textMessage.value + "\n";
					textMessage.value="";	
				} else webSocket.close();
			}
			function processMessage(message) {
				messagesTextArea.value += "Receive from server ==> " + message.data + "\n";
			}
			function processClose(message) {
				webSocket.send("Client disconnected...");
				messagesTextArea.value += "Server Disconnecting...\n";
			}
			function processError(message) {
				messagesTextArea.value += "error...\n";
			}
			
			
		</script>
</html>