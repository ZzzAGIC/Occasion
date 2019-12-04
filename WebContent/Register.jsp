<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="css/Login.css">
<title>Register</title>
</head>
<body>
	
	<div class="register-container">
		<div class="banner">
				<p class="banner-text">Login</p>
		</div>
		<form class="form" action="register_validate" method="post">
		<div id="formerror" style="color: red;">  
		<%= request.getAttribute("error") != null ? request.getAttribute("error") : "" %>
		</div>
		<br/>
		Username:<br/> <input class="bar" type="text" name="new_username"/><br/><br/>  
		
		Gender:<br/>
			  <input type="radio" name="gender" value="male"> Male
			  <input type="radio" name="gender" value="female"> Female
			  <input type="radio" name="gender" value="other"> Other<br/><br/>
		Birthday:<br/>
						
					        Day:<select id="day" name="day">
								<%for(int i = 1; i <=31; i++){%> 
								<option value="<%=i%>"><%=i%></option>
	            				<%}%>
	            				</select>
					      
					      
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
					      
					      
					        Year:<select id="year" name="year">
								<%for(int i = 1990; i <=2019; i++){%> 
								<option value="<%=i%>"><%=i%></option>
	            				<%}%>
	            			</select>
					      
					<br/><br/>
			   
		phone number:<br/> <input class="bar" type="text" name="phone_number"/><br/><br/>  
		Email:<br/> <input class="bar" type="email" name="email"/><br/><br/>  
		Password:<br/> <input class="bar" type="password" name="new_userpass1"/><br/><br/>  
		Confirm password:<br/> <input class="bar" type="password" name="new_userpass2"/><br/><br/>  
		
		profile image:<br/> <input class="bar" type="text" name="profile_image"/><br/><br/>  
		<input class="button" type="submit" name="status" />  
		</form>  
	</div>

</body>
</html>