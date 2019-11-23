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
			
			EventTime:<br/> 
					    <div>
					      <span>
					        Day:<select id="day" name="day">
								<%for(int i = 1; i <=31; i++){%> 
								<option value="<%=i%>"><%=i%></option>
	            				<%}%>
	            				</select>
					      </span>
					      <span>
					        Month:<select id="month" name="month">
								<option value="01">January</option>	
								<option value="02">February</option>
								<option value="03">March</option>
								<option value="04">April</option>
								<option value="05">May</option>
								<option value="06">June</option>
								<option value="07">July</option>
								<option value="08">August</option>
								<option value="09">September</option>
								<option value="10">October</option>
								<option value="11">November</option>
								<option value="12">December</option>
							</select>
					      </span>
					      <span>
					        Year:<select id="year" name="year">
								<%for(int i = 2019; i <=2021; i++){%> 
								<option value="<%=i%>"><%=i%></option>
	            				<%}%>
	            			</select>
					      </span>
					    </div>
					    <div>
					      <span>
					        Hour:<select id="hour" name="hour">
								<%for(int i = 0; i <=23; i++){%> 
								<option value="<%=i%>"><%=i%></option>
	            				<%}%>
	            			</select>
					      </span>
					      <span>
							Minute: <select id="minute" name="minute">
								<%for(int i = 0; i <=59; i++){%> 
								<option value="<%=i%>"><%=i%></option>
	            				<%}%>
	            			</select>
					      </span>
					    </div>
					
					
			Location:<br/> 
				Street:<br/> <input class="bar" id="location" type="text" name="EventLocation_street"/><br/><br/> 
				Room(optional):<br/> <input class="bar" id="location" type="text" name="EventLocation_Room"/><br/><br/> 
				City:<br/> <input class="bar"  id="location" type="text" name="EventLocation_city"/><br/><br/> 
				State:<br/> <select class="bar" id="location" name="EventLocation_state"/>
						<!-- <option value="AL">Alabama</option>
						<option value="AK">Alaska</option>
						<option value="AZ">Arizona</option>
						<option value="AR">Arkansas</option> -->
						<option value="CA">California</option>
						<!-- <option value="CO">Colorado</option>
						<option value="CT">Connecticut</option>
						<option value="DE">Delaware</option>
						<option value="DC">District Of Columbia</option>
						<option value="FL">Florida</option>
						<option value="GA">Georgia</option>
						<option value="HI">Hawaii</option>
						<option value="ID">Idaho</option>
						<option value="IL">Illinois</option>
						<option value="IN">Indiana</option>
						<option value="IA">Iowa</option>
						<option value="KS">Kansas</option>
						<option value="KY">Kentucky</option>
						<option value="LA">Louisiana</option>
						<option value="ME">Maine</option>
						<option value="MD">Maryland</option>
						<option value="MA">Massachusetts</option>
						<option value="MI">Michigan</option>
						<option value="MN">Minnesota</option>
						<option value="MS">Mississippi</option>
						<option value="MO">Missouri</option>
						<option value="MT">Montana</option>
						<option value="NE">Nebraska</option>
						<option value="NV">Nevada</option>
						<option value="NH">New Hampshire</option>
						<option value="NJ">New Jersey</option>
						<option value="NM">New Mexico</option>
						<option value="NY">New York</option>
						<option value="NC">North Carolina</option>
						<option value="ND">North Dakota</option>
						<option value="OH">Ohio</option>
						<option value="OK">Oklahoma</option>
						<option value="OR">Oregon</option>
						<option value="PA">Pennsylvania</option>
						<option value="RI">Rhode Island</option>
						<option value="SC">South Carolina</option>
						<option value="SD">South Dakota</option>
						<option value="TN">Tennessee</option>
						<option value="TX">Texas</option>
						<option value="UT">Utah</option>
						<option value="VT">Vermont</option>
						<option value="VA">Virginia</option>
						<option value="WA">Washington</option>
						<option value="WV">West Virginia</option>
						<option value="WI">Wisconsin</option>
						<option value="WY">Wyoming</option> -->
				</select><br/><br/>
				
				Country:<br/><select class="bar"  id="location" name="EventLocation_country" >
	                <!-- <option value="Austria">Austria</option>
	                <option value="Azerbaijan">Azerbaijan</option>
	                <option value="Brazil">Brazil</option>
	                <option value="Bahrain">Bahrain</option>
	                <option value="Canade">Canade</option>
	                <option value="China">China</option>
	                <option value="France">France</option> -->
	                <option value="USA">United States of America</option>
                </select></br></br>
                
				Zipcode (optional):<br/> <input class="bar" id="location" type="text" name="EventLocation_zipcode"/><br/><br/> 
				
			Type:<br/> <select class="bar"  name="EventType">
					<option value="all">ALL</option>
					<option value="academic">Academic</option>
					<option value="leisure">Leisure</option>
					<option value="music">Music</option>
					<option value="party">Party</option>
					<option value="sports">Sports</option>
					<option value="stu_org">Student Organization</option>
					<option value="other">Other</option>
				</select> <br/><br/> 
			
			capacity:<br/> <input class="bar" type="number" name="EventCapacity"/><br/><br/>  
			
			price:<br/> <input class="bar" type="number" name="EventPrice"/><br/><br/>  
			
			Description:<br/> <input class="bar" type="text" name="EventDescription" placeholder="Describe the event" style="width:300px; height:60px;"/><br/><br/>  
			
			Privacy type:<br/> <select class="bar"  name="privacy">
					<option value="0">Public</option>
					<option value="1">private</option>
					<option value="2">exclusive</option>
				</select> <br/><br/> 
				
			Pictures:<br/> <input class="bar" type="text" name="EventImages"/><br/><br/>
			
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
