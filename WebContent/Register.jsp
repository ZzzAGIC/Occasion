<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	
	<div align="center">
		<form action="myservlet" method="post">
		<div id="formerror" style="color: red;">  
		<%= request.getAttribute("error") != null ? request.getAttribute("error") : "" %>
		</div>
		<br/>
		Username:<br/> <input class="bar" type="text" name="new_username"/><br/><br/>  
		Password:<br/> <input class="bar" type="password" name="new_userpass1"/><br/><br/>  
		Confirm password:<br/> <input class="bar" type="password" name="new_userpass2"/><br/><br/>  
		<input class="button" type="submit" name="status" value="Register"/>  
		</form>  
	</div>

</body>
</html>