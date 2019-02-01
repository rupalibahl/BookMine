package servlets;

import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.catalina.User;

import com.fasterxml.jackson.core.JsonParseException;
import com.google.gson.Gson;

import bookmine.UserList;
import bookmine.Users;



/**
 * Servlet implementation class LoginServlet
 */
@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub

		HttpSession session = request.getSession();
		UserList u = (UserList)request.getSession().getAttribute("list");
				
		String username = (String)request.getParameter("username");
		String password = (String)request.getParameter("password");
		
		Boolean usernameValid = false;
		Boolean passwordValid = false;
		
		Users curr = new Users();
		if(username != null && password != null)
		{
			for(Users u1 : u.getUsers())
			{
				if(u1.getUsername().equals(username))
				{
					usernameValid = true;
					
					if(u1.getPassword().equals(password))
					{
						passwordValid = true;
						
						curr.setUsername(u1.getUsername());
						curr.setPassword(u1.getPassword());
					}
				}
				
			}
			
			
			PrintWriter out = response.getWriter();

			if(usernameValid && passwordValid)
			{
				session.setAttribute("currUser", curr);
				
				System.out.print("reached valid");
				out.flush();
				
				
				//request.getRequestDispatcher("/Results.jsp").forward(request, response);
				//out.println("<font color = \"red\">First Name needs a value</font>");
				
				
			}
			else
			{
				out.println("<font color = \"red\">Login Failed </font>");
				out.flush(); 
				
				//session.setAttribute("currUser", null);
				
			}
		}
		else
		{
			if(username == null)
			{
				
			}
			if(password == null)
			{
				
			}
		}
		//getServletContext().getRequestDispatcher("/Results.jsp").forward(request,response);
		request.getRequestDispatcher("/Results.jsp").forward(request, response);
	}
}
