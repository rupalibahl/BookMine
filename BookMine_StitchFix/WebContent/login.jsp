<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css" href="signup.css">
<link href="https://fonts.googleapis.com/css?family=Roboto:900" rel="stylesheet">


<script>
		function validate()
		{
			var xhttp = new XMLHttpRequest();
			xhttp.open("GET", "LoginServlet?username=" + document.myform.username.value + "&password=" + document.myform.password.value, false);
			xhttp.send();
			if(xhttp.responseText.trim().length > 0)
			{
				document.getElementById("formerror").innerHTML = xhttp.responseText;
				return false;
			}
			return true;
		}
	
	</script>

<title>Login</title>
</head>
<body>
	<div id="top">
		<h1><a href="index.html">BookMine</a></h1>
	</div>
	
	<div id = "middle">
		<div id="formerror"></div>
		<form name="myform" method="GET" action="Results.jsp" onsubmit = "return validate();" >
			<h1>Login</h1>
			<div id = "menu">
				<h2>Username</h2>
				<input type = "text" name = "username" id = "username">
				<h2>Password</h2>
				<input type = "text" name = "password" id = "password">
			</div>
			
 			<input type ="submit" value = "LOGIN" id = "signupButton">
		
		</form>
	
	</div>
	
	<div id = "bottom"></div>
	
</body>
</html>