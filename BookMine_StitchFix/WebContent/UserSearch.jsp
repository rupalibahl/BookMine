<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="com.google.gson.Gson" %>
<%@ page import="com.google.gson.GsonBuilder" %>
<%@ page import="com.google.gson.JsonParseException" %>
<%@ page import="java.io.*" %>
<%@ page import="java.util.*" %>
<%@ page import="bookmine.UserList" %>
<%@ page import="bookmine.Users" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css" href="results.css">

<script>
		function validate()
		{
			//window.alert("IN VALIDATE");
			//console.log("IN VALIDATE")
			var xhttp = new XMLHttpRequest();
			xhttp.open("GET", "UserSearch?search=" + document.myform.search.value, false);
			xhttp.send();
			if(xhttp.responseText.trim().length > 0)
			{
				document.getElementById("formerror").innerHTML = xhttp.responseText;
				return false;
			}
			return true;
		}
	
	</script>

<title>Search User</title>
</head>
<body>
<% 
	
		FileReader fr; 
		UserList user = null;
		Gson gson = new Gson();
		try
		{
			fr = new FileReader(getServletContext().getRealPath("Sample.json"));
			user = gson.fromJson(fr, UserList.class);
			
			System.out.println(user.getUsers().get(1).getUsername());
		}
		catch (FileNotFoundException e) 
		{
			System.out.println("That file could not be found");
		 }
		 catch(com.google.gson.JsonSyntaxException e)
		 {
			 System.out.println("That file is not a well-formed JSON file.");
		 }
		 catch(JsonParseException e)
		 {
			e.printStackTrace();
		 }
		
		String currentUser = (String)session.getAttribute("loggedIn");
		
		UserList userList = (UserList)request.getSession().getAttribute("list");
		Users currUser = new Users();
		for(Users u : userList.getUsers())
		{
			if(u.getUsername().equals(currentUser))
			{
				currUser = u;
			}
			
		}
	%>

<div id="top">
		<h1><a href="index.html">BookMine</a></h1>
		<form name="myform" method="GET" action="DisplayUsers.jsp" onsubmit = "return validate();" >
			<input type="text" name="search" id="search">
			<div id="search-icon-container">
 				<img id="search-icon" src="http://simpleicon.com/wp-content/uploads/user1.png" /> 							
			</div>
		</form>
		<form name = "Search Books" method = "GET" action = "Results.jsp">
			<input type = "submit" value = "Search Books" id = "searchUser" style="color:white; background-color: #424243; height: 30px;
			width: 150px;align: center; font-size: 15px;text-align: center; margin-left: 20px; margin-top: -6px">
		</form>
		
		<img src= <%=currUser.getImageURL() %> id="circle" onclick = "location.href = 'Profile.jsp'">
	</div>
	<table id="table">
	</table>
	
	<div id="formerror"></div>

</body>
</html>