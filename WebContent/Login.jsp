<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="Login.css">
<title>Login</title>
</head>
<body>
	
	
	
	<div align="center">
		<form class="form" action="myservlet" method="post" onsubmit="return validate();"> 
		<div id="formerror" style="color: red;"> 
		<%= request.getAttribute("error") != null ? request.getAttribute("error") : "" %>
		</div>
		<br/>
		Username:<br/> <input class="bar" type="text" name="username"/><br/><br/>  
		Password:<br/> <input class="bar" type="password" name="userpass"/><br/><br/>  
		<input class="button" type="submit" name="status" value="Sign in"/>  
		</form>  
	</div>

</body>

</body>
</html>