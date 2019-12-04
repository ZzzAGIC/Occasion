<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="css/Login.css">
<title>Login</title>
</head>
<body>
	
	<div class="container" align="center">
		<form class="form" action="Login_validate" method="post"> 
			<div id="formerror" style="color: red;"> 
				<%= request.getAttribute("error") != null ? request.getAttribute("error") : "" %>
			</div>
			<div class="banner">
				<p class="banner-text">Login</p>
			</div>
			<br/> <input class="bar" type="text" name="username" placeholder="Username"/><br/><br/>  
			<br/> <input class="bar" type="password" name="userpass" placeholder="Password"/><br/><br/>  
			<input class="button" type="submit" name="status" value="Sign in"/> <a href="Register.jsp">Register</a> 
		</form>  
	</div>

</body>

</body>
</html>