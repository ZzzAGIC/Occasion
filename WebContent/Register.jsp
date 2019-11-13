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
	
	<div align="center">
		<form class="form" action="register_validate" method="post">
		<div id="formerror" style="color: red;">  
		<%= request.getAttribute("error") != null ? request.getAttribute("error") : "" %>
		</div>
		<br/>
		Username:<br/> <input class="bar" type="text" name="new_username"/><br/><br/>  
		phone number:<br/> <input class="bar" type="text" name="phone_number"/><br/><br/>  
		Email:<br/> <input class="bar" type="email" name="email"/><br/><br/>  
		Password:<br/> <input class="bar" type="password" name="new_userpass1"/><br/><br/>  
		Confirm password:<br/> <input class="bar" type="password" name="new_userpass2"/><br/><br/>  
		<input class="button" type="submit" name="status" />  
		</form>  
	</div>

</body>
</html>