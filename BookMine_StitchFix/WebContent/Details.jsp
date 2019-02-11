<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<title>Book Details</title>
<style>
i {
		font-size: 36px; !important;
		color:yellow;
	}
</style>
<link rel="stylesheet" type="text/css" href="details.css">

	<script>
		function validate()
		{
			var xhttp = new XMLHttpRequest();
			xhttp.open("GET", "favoriteServlet?bookToAdd=" + titleText, false);
			xhttp.send();
			if(xhttp.responseText.trim().length > 0)
			{
				document.getElementById("formerror").innerHTML = xhttp.responseText;
				return false;
			}
			return true;
		}
	
	</script>
		
</head>
<body>
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
	</div>
	<table id="table">
		<tr id="results">
			<td id="photo">
			
			</td>
			
			<td id="info">
				<div id="bookTitle">
					
				</div>
				<div>
					<h1 id="publisher"><span>Publisher: </span></h1>
				</div>
				<div id="description">
					<h1><span>Description:</span></h1>
				</div>
				<div id="rating">
					<h1><span>Rating:</span></h1>
				</div>
				 <!-- <form name = "addToFav" method = "GET" action = "favoriteServlet" onsubmit = "return validate()">
					<input type = "submit" value ="Add to Fav" name = "Add to Fav" id = "followButton" class = "button">
				</form> -->
				<a href="" id="favoriteLink">Add to Favorites</a> 
				<a href="" id="readLink">Add to Read</a> 
			</td>
		</tr>
	</table>
</body>
<script>
var bookId = "<%= request.getParameter("id")%>"
document.getElementById("search").value = query; //Setting the searchbar to the query
//document.getElementById(radioField).setAttribute("checked", "checked");

var query = "https://www.googleapis.com/books/v1/volumes/" + bookId;
console.log(query);
xhttp = new XMLHttpRequest();

xhttp.onreadystatechange = function() {
	if(this.readyState == 4 && this.status == 200) {
		var jsonResponse = JSON.parse(xhttp.responseText.trim());
		
		document.getElementById("search").value = jsonResponse.volumeInfo.title; 

		var container = document.getElementById("container");
		var photoCell = document.getElementById("photo");
		var titleAuthorDiv = document.getElementById("bookTitle");
		var publisherHeader = document.getElementById("publisher");
		var descriptionDiv = document.getElementById("description");
		var ratingDiv = document.getElementById("rating");
		
		//Getting the image source
		var img = document.createElement("img");
		if( jsonResponse.volumeInfo.hasOwnProperty('imageLinks')) {
			if(jsonResponse.volumeInfo.imageLinks.hasOwnProperty('extraLarge')) {
				img.src = jsonResponse.volumeInfo.imageLinks.extraLarge;
			} else if(jsonResponse.volumeInfo.imageLinks.hasOwnProperty('large')) {
				img.src = jsonResponse.volumeInfo.imageLinks.large;
			} else if(jsonResponse.volumeInfo.imageLinks.hasOwnProperty('medium')) {
				img.src = jsonResponse.volumeInfo.imageLinks.medium;
			} else if(jsonResponse.volumeInfo.imageLinks.hasOwnProperty('small')) {
				img.src = jsonResponse.volumeInfo.imageLinks.small;
			} else if(jsonResponse.volumeInfo.imageLinks.hasOwnProperty('smallThumbnail')) {
				img.src = jsonResponse.volumeInfo.imageLinks.smallThumbnail;
			} else {
				console.log("imageLinks exists but not the ones we know");
				img.src = "https://upload.wikimedia.org/wikipedia/commons/thumb/a/ac/No_image_available.svg/600px-No_image_available.svg.png";
			}
		} else {
			console.log("No image property");
			img.src = "https://upload.wikimedia.org/wikipedia/commons/thumb/a/ac/No_image_available.svg/600px-No_image_available.svg.png";
		}
		//Adding the img to the photo
		photoCell.appendChild(img);
		
		//Getting the other information
		
		//Title
		var title = document.createElement("H1");
		var titleText = document.createTextNode(jsonResponse.volumeInfo.title);
		title.id = "title";
		title.style = "font-size: 2.5em;"
		title.appendChild(titleText);
		titleAuthorDiv.appendChild(title);
		
		//Authors
		var author = document.createElement("H1");
		title.id = "author";
		if(jsonResponse.volumeInfo.hasOwnProperty("authors")) {
			var authorText = "";
			for(var i = 0; i < jsonResponse.volumeInfo.authors.length; i++) {
				authorText += jsonResponse.volumeInfo.authors[i];
				if(i != jsonResponse.volumeInfo.authors.length - 1) {
					authorText += ", ";
				}
			}
			var authorTextNode = document.createTextNode("by " + authorText);
			author.appendChild(authorTextNode);
			titleAuthorDiv.appendChild(author);
		}
		
		//Publisher
		var publisherText = document.createTextNode(jsonResponse.volumeInfo.publisher);
		publisherHeader.appendChild(publisherText);
		
		//Description
		var description = document.createElement("p");
		if(jsonResponse.volumeInfo.hasOwnProperty("description")) {
			var descriptionText = document.createTextNode(jsonResponse.volumeInfo.description);
			description.appendChild(descriptionText);
			descriptionDiv.appendChild(description);
		} else {
			var noDescriptionNode = document.createTextNode("No description avaialble");
			description.appendChild(noDescriptionNode);
			descriptionDiv.appendChild(description);
		}
		
		//Rating
		 if(jsonResponse.volumeInfo.hasOwnProperty("averageRating")) {
			var rating = jsonResponse.volumeInfo.averageRating;
			var counter = 0;
			for(var i = 1; i <= rating; i++) {
				counter++;
				var star = document.createElement("i");
				star.classList.add("fa");
				star.classList.add("fa-star");
				ratingDiv.appendChild(star);
			}
		
			console.log(rating);
			//We need to add a half star if this is true
			if(rating > counter) {
				var star = document.createElement("i");
				star.classList.add("fa");
				star.classList.add("fa-star-half-full");
				ratingDiv.appendChild(star);
				counter++;
			}
			//Fill in empty stars if need be
			for(var i = 0; i < 5 - counter; i++) {
				var star = document.createElement("i");
				star.classList.add("fa");
				star.classList.add("fa-star-o");
				ratingDiv.appendChild(star);
			}
			
			
		} else {
			var rating = document.createElement("H1");
			var ratingElement = document.createTextNode("No rating available");
			rating.appendChild(ratingElement);
			ratingDiv.appendChild(rating);
		} 
		
			document.getElementById("favoriteLink").href = "favoriteServlet?bookToAdd=" + jsonResponse.volumeInfo.title;
			document.getElementById("readLink").href = "readServlet?bookToAdd=" + jsonResponse.volumeInfo.title
	}
};
console.log(query);
xhttp.open("GET", query, false); //Sending the books api call
xhttp.send();
	
	
</script>
</html>