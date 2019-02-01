package servlets;

import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.gson.Gson;

import bookmine.UserList;

/**
 * Servlet implementation class readData
 */
@WebServlet("/readData")
public class readData extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public readData() {
        super();
        // TODO Auto-generated constructor stub
    }

	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
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
		
		HttpSession session = request.getSession();
		//System.out.println(user.getUsers().get(1).getFollowing().size());
		session.setAttribute("list", user);
		
		RequestDispatcher rd = getServletContext().getRequestDispatcher("/index.html");
		rd.forward(request, response);
	}

}
