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

import com.google.gson.Gson;

import bookmine.UserList;
import bookmine.Users;

/**
 * Servlet implementation class SignupServlet
 */
@WebServlet("/SignupServlet")
public class SignupServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SignupServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//HttpSession session = request.getSession();
		//session.setAttribute("Sample.json", gson);
		
		HttpSession session = request.getSession();
		UserList u = (UserList)request.getSession().getAttribute("list");
		Users curr = new Users();
		 
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		String imgUrl = request.getParameter("imgUrl");
		
		Boolean usernameValid = true;
		Boolean passwordValid = true;
		Boolean imgValid = true;
		
		if(username != null && password != null && imgUrl != null)
		{
			System.out.println("users size: " + u.getUsers().size());
			
			for(Users u1 : u.getUsers())
			{
				if(u1.getUsername().equals(username))
				{
					usernameValid = false;
				}
				
			}
			
			PrintWriter out = response.getWriter();
			
			if(username.equals(""))
			{
				out.flush();
				out.print("<font color = \"red\">Username can not be empty<br></font>");
				out.flush();
				//usernameValid = false;
			}
			if(password.equals(""))
			{
				out.print("<font color = \"red\">Password can not be empty<br></font>");
				out.flush();
				passwordValid = false;
			}
			if(imgUrl.isEmpty())
			{
				out.print("<font color = \"red\">Image URL can not be empty <br> </font>");
				out.flush();
				imgValid = false;
			}

			if(usernameValid && passwordValid && imgValid)
			{
				curr.setUsername(username);
				curr.setPassword(password);
				curr.setImageURL(imgUrl);
				
				u.getUsers().add(curr);
				session.setAttribute("loggedIn", username);
				session.setAttribute("userslist", u);
				out.flush();
				request.getRequestDispatcher("/Results.jsp").forward(request, response);
			}
			else
			{
				if(!usernameValid)
				{
					out.flush();
					out.println("<font color = \"red\">Username Taken</font>");
					out.flush(); 
				}
				
			}
		}
		else
		{
			PrintWriter out = response.getWriter();
			System.out.println("EMPTY 1");
			
			if(username == null)
			{
				System.out.println("EMPTY 2");
				out.flush();
				out.print("<font color = \"red\">Entry can not be empty</font>");
				out.flush();
			}
			if(password == null)
			{
				out.print("<font color = \"red\">Entry can not be empty</font>");
				out.flush();
			}
			if(imgUrl == null)
			{
				out.print("<font color = \"red\">Entry can not be empty</font>");
				out.flush();
			}
		}
	
	}
		
	
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

	
}
