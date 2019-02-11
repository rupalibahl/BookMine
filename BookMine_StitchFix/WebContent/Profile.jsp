<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.google.gson.Gson" %>
<%@ page import="com.google.gson.GsonBuilder" %>
<%@ page import="com.google.gson.JsonParseException" %>
<%@ page import="java.io.*" %>
<%@ page import="java.util.*" %>
<%@ page import="bookmine.UserList" %>
<%@  page import ="bookmine.UserList" %>
<%@  page import = "bookmine.Users" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css" href="profile.css">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<title>Profile Page</title>
</head>
<body>

	<% 
	
		HttpSession sessionn = request.getSession();
		//UserList u = (UserList)request.getSession().getAttribute("list");
		Users u = (Users)request.getSession().getAttribute("currUser");
		if(u == null)
		{
			System.out.println("USER IS EMPTY OMG");
		}
		/* int in = (int)session.getAttribute("index"); */
	%>
	<div id="top">
		<h1><a href="index.html">BookMine</a></h1>
		<form name="myform" method="GET" action="Results.jsp" >
			<input type="text" name="search" id="search">
			<div id="search-icon-container">
				<img id="search-icon" src="https://cdn4.iconfinder.com/data/icons/ionicons/512/icon-ios7-search-strong-128.png" />
			</div>
				<div id="group1">
					<input id="intitle" type="radio" name="radio" value="intitle" class="radio">
					<label for="title">Title</label>
					<input id="isbn" type="radio" name="radio" value="isbn" class="radio">
					<label for="isbn">ISBN</label>
				</div>
				<div id="group2">
					<input id="inauthor" type="radio" name="radio" value="inauthor" class="radio">
					<label for="author">Author</label>
					<input id="subject" type="radio" name="radio" value="subject" class="radio">
					<label for="subject">Genre</label>
				</div>
		</form>
		<form name = "Search Users" method = "GET" action = "UserSearch.jsp">
			<input type = "submit" value = "Search Users" class = "searchUser" style="color:white; background-color: #424243; height: 30px;
			width: 150px;align: center; font-size: 15px;text-align: center; margin-left: 20px; margin-top: -6px">
		</form>
		
		<img src= <%=u.getImageURL() %> id="minicircle" onclick = "location.href = 'Profile.jsp'">
	</div>
	
	<div id = "leftbar">
		<img src= <%=u.getImageURL() %> id="circle">
		
		<p id = "name">@<%=u.getUsername() %>   </p>

		<div class="tab">
		  <button class="tablinks" onclick="followFunc(event, 'Following')">Following</button>
		  <button class="tablinks" onclick="followFunc(event, 'Followers')">Followers</button>
		</div>
		
		<div id="Following" class="tabcontent">
		
		  <%for(int i = 0; i < u.getFollowing().size(); i++){ %> 
			<%out.println(u.getFollowing().get(i)); %>
			  <br />
		  <%}%>
		</div>
		
		<div id="Followers" class="tabcontent">
		  <%for(int i = 0; i < u.getFollowers().size(); i++){ %> 
			<%out.println(u.getFollowers().get(i));%>
			  <br />
		  <%}%>
		</div>
		
		<script>
			function followFunc(evt, follow) {
		    var i, tabcontent, tablinks;
		    tabcontent = document.getElementsByClassName("tabcontent");
		    for (i = 0; i < tabcontent.length; i++) {
		        tabcontent[i].style.display = "none";
		    }
		    tablinks = document.getElementsByClassName("tablinks");
		    for (i = 0; i < tablinks.length; i++) {
		        tablinks[i].className = tablinks[i].className.replace(" active", "");
		    }
		    document.getElementById(follow).style.display = "block";
		    evt.currentTarget.className += " active";
		}
		</script>
	</div>
	
	<div id = "mainTable">
		<div id = myUser>Your Library</div>
		<div class="tab">
		  <button class="tablinks" onclick="followFunc(event, 'Read')">Read</button>
		  <button class="tablinks" onclick="followFunc(event, 'Favorites')">Favorites</button>
		</div>
		
		<div id="Read" class="tabcontent2">
		  <%for(int i = 0; i < u.getLibrary().getRead().size(); i++){ %> 
			<%out.println(u.getLibrary().getRead().get(i)); %>
			  <br>
		  <%}%>
		</div>
		
		<div id="Favorites" class="tabcontent2">
			<% System.out.println("FAV SIZE: " + u.getLibrary().getFavorite().size()); %>
		  <%for(int i = 0; i < u.getLibrary().getFavorite().size(); i++){ %> 
			<%out.println(u.getLibrary().getFavorite().get(i)); %>
			  <br>
		  <%}%>
		</div>
		
		<script>
			function followFunc(evt, follow) {
		    var i, tabcontent, tablinks;
		    tabcontent = document.getElementsByClassName("tabcontent2");
		    for (i = 0; i < tabcontent.length; i++) {
		        tabcontent[i].style.display = "none";
		    }
		    tablinks = document.getElementsByClassName("tablinks");
		    for (i = 0; i < tablinks.length; i++) {
		        tablinks[i].className = tablinks[i].className.replace(" active", "");
		    }
		    document.getElementById(follow).style.display = "block";
		    evt.currentTarget.className += " active";
		}
		</script>
	
	</div>
	
	<!-- <div id=followButton> Logout </div> -->
	
	<form name = "login" method = "GET" action = "index.html">
			<input type = "submit" value ="Logout" name = "Logout" id = "followButton" class = "button">
		</form>
	
</body>
</html>