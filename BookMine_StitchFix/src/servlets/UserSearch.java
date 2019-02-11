package servlets;

import java.util.ArrayList;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonParseException;
import java.io.*;
import java.util.*;
//import bookmine.UserList;
//import bookmine.Users;
import bookmine.*;

/**
 * Servlet implementation class UserSearch
 */
@WebServlet("/UserSearch")
public class UserSearch extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	public UserSearch() {
        super();
        // TODO Auto-generated constructor stub
    }
       
protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	String searchedUser = (String) request.getParameter("search");
	UserList userList = (UserList)request.getSession().getAttribute("list");
	
	PrintWriter out = response.getWriter();
		
	if(searchedUser.equals(""))
	{
		out.flush();
		out.print("<font color = \"red\">User can not be empty<br></font>");
		System.out.println("empty user");
		out.flush();
	}
	
	Boolean userFound = false;
	
	for(Users u : userList.getUsers())
	{
		if(u.getUsername().equals(searchedUser))
		{
			//currUser = u;
			System.out.println("user found");
			request.getSession().setAttribute("searchedUser", u);
			userFound = true;
			request.getRequestDispatcher("/DisplayUsers.jsp").forward(request, response);
		}
	}
	
	if(!userFound)
	{
		System.out.println("user not found");
		out.print("<font color = \"red\">User not found<br></font>");
		out.flush();
	}
	
//		ServletContext sc = getServletContext();
//		sc.getRequestDispatcher(forwardPage).forward(request, response);
	}

protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	// TODO Auto-generated method stub
	doGet(request, response);
}
}
