<%@ 
page language="java" contentType="text/html; charset=ISO-8859-1"
pageEncoding="ISO-8859-1"   
%>
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
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" type="text/css" href="results.css">
<title>Result Page</title>
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

<script>
	var bookImg = "https://png.icons8.com/metro/1600/book.png";
	var userImg = "http://simpleicon.com/wp-content/uploads/user1.png";
	
	function toggleImages(src)
	{
		
	}
	
	function changeIcon()
	{
		var currIcon = document.getElementById("search-icon").className;
		if(currIcon == "book") 
		{
				document.getElementById("search-icon").className ="user";
				//document.getElementById("optionsTablet").style = "opacity:0.0";
				document.getElementById("searchIdentifier").value= "1"; 
		}
		else if(currIcon == "user")
		{
			document.getElementById("search-icon").className ="book";
			// document.getElementById("optionsTablet").style = "opacity:1.0";
			document.getElementById("searchIdentifier").value= "0"; 
		}
	}

</script>

	<div id="top">
		<h1><a href="index.html">BookMine</a></h1>
		<form name="myform" method="GET" action="Results.jsp" >
			<input type="text" name="search" id="search">
			<div id="search-icon-container">
 				<img id="search-icon" src="https://png.icons8.com/metro/1600/book.png" /> 				
					
					<!-- <img id="search-icon" src="https://png.icons8.com/metro/1600/book.png" 
					onclick = "this.src = this.src == userImg ? bookImg : userImg;toggleImages(this.src);" /> -->
					<!-- <button class="btn"><i id="search-icon" class="book" onclick="changeIcon()"></i></button> -->
					<!-- <img id="search-icon" class = "book" src="https://png.icons8.com/metro/1600/book.png" 
					onclick = "changeIcon()" /> -->
					<input type="hidden" value="0" id="searchIdentifier" name="searchIdentifier">
			
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
		
		<img src= <%=currUser.getImageURL() %> id="circle" onclick = "location.href = 'Profile.jsp'">
	</div>
	<table id="table">
	</table>
</body>




<script>
	var urlParams = new URLSearchParams(window.location.search);
	var query = urlParams.get("search");
	var radioField = urlParams.get("radio");
	// sets the value of search and radiobutton to previous entry
	document.getElementById("search").value = query; 
	document.getElementById(radioField).setAttribute("checked", "checked");
	
 	xhttp = new XMLHttpRequest();
	xhttp.onreadystatechange = function() {
		if(this.readyState == 4 && this.status == 200) {
			var jsonResponse = JSON.parse(xhttp.responseText.trim());
			// begin populating table with books
			var table = document.getElementById("table");
			var row = document.createElement("tr"); 
			table.appendChild(row);
			
			for(var i = 0; i < jsonResponse.items.length; i++) {
				var td = document.createElement("td");
				
				//Getting the image
				var img = document.createElement("img");
				//If imageLinks exists.
				if( jsonResponse.items[i].volumeInfo.hasOwnProperty('imageLinks')) {
					if(jsonResponse.items[i].volumeInfo.imageLinks.extraLarge) {
						img.src = jsonResponse.items[i].volumeInfo.imageLinks.extraLarge;
					} else if(jsonResponse.items[i].volumeInfo.imageLinks.large) {
						img.src = jsonResponse.items[i].volumeInfo.imageLinks.large;
					} else if(jsonResponse.items[i].volumeInfo.imageLinks.medium) {
						img.src = jsonResponse.items[i].volumeInfo.imageLinks.medium;
					} else if(jsonResponse.items[i].volumeInfo.imageLinks.small) {
						img.src = jsonResponse.items[i].volumeInfo.imageLinks.small;
					} else if(jsonResponse.items[i].volumeInfo.imageLinks.thumbnail) {
						img.src = jsonResponse.items[i].volumeInfo.imageLinks.smallThumbnail;
					} else {
						img.src = "";
					}
				} 
				
				//Getting the Title
				var h1 = document.createElement("h2");
				var t = document.createTextNode(jsonResponse.items[i].volumeInfo.title);
				
				//Getting the link to go to the Book.jsp
				var anchor = document.createElement("A");
				anchor.href = "Details.jsp?id=" + jsonResponse.items[i].id;
				
				//Getting the author (sometimes there are no authors)
				
				var author = document.createElement("h3");
				console.log(jsonResponse.items[i].volumeInfo.hasOwnProperty("authors"))
				if(jsonResponse.items[i].volumeInfo.hasOwnProperty("authors")) {
					var authorText = "by ";
					for (var index = 0; index < jsonResponse.items[i].volumeInfo.authors.length; index++) {
						authorText += jsonResponse.items[i].volumeInfo.authors[index];
						console.log(jsonResponse.items[i].volumeInfo.authors[index]);
						if(index != jsonResponse.items[i].volumeInfo.authors.length - 1) {
							authorText += ", ";
						}
					}
					var authorNode = document.createTextNode(authorText);
					author.appendChild(authorNode);
				}
				
				
				//Putting it all together
				h1.appendChild(t);
				anchor.appendChild(h1);
				author.appendChild(authorNode);
				anchor.appendChild(author);
				
				//Adding to the cell
				td.appendChild(img);
				td.appendChild(anchor);
	
				//Adding to the row			
				if(i % 4 === 0 && i != 0) {
					row = document.createElement("tr"); //Creating a new row.
					row.appendChild(td);
					table.appendChild(row);
				} else {
					row.appendChild(td);
				}
			}
		}
	};
	

	var url = "https://www.googleapis.com/books/v1/volumes?q=";
	var query = document.getElementById("search").value;
	query = query.replace(" ", "+"); 
	var finalUrl = url + radioField + ":" + query + "&maxResults=12";	
	
	xhttp.open("GET", finalUrl, false); 
	xhttp.send();
	
</script>
</html>