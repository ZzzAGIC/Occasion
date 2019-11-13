package servlet;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.jasper.tagplugins.jstl.core.Out;

import occasion.db.Database;

/**
 * Servlet implementation class login_validate
 */
@WebServlet("/Login_validate")
public class Login_validate extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Login_validate() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#service(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String login_name= request.getParameter("username");
		String login_pass= request.getParameter("userpass");
			
		String next = "/HomePage.jsp";
		String error = "";
		HttpSession session = request.getSession();
		session.setAttribute("login", false);
			

		if(login_name =="") {
			error += "Username cannot be empty & ";
			next = "/Login.jsp";
		}
		if(login_pass =="") {
			error += "password cannot be empty & ";
			next = "/Login.jsp";
		}
		try {
			//login success
			if (validateCredentials(login_name, login_pass)) {
				session.setAttribute("login", true);
				session.setAttribute("myname", login_name);
			}
			//login failed
			else {
				error += "invalid username or wrong password  & ";
				next = "/Login.jsp";
			}
		} catch (SQLException e){
			e.printStackTrace();
		} catch (ClassNotFoundException e){
			e.printStackTrace();
		}
			
				
		request.setAttribute("error", error);
		RequestDispatcher dispatch = getServletContext().getRequestDispatcher(next);
			
		try {
			dispatch.forward(request,response);
		}
		catch (IOException e){
			e.printStackTrace();
		}
		catch (ServletException e){
			e.printStackTrace();
		}
	}
	/**
	 * Function Validates that a user exists with the existing credentials   
	 * @param username - inputed username
	 * @param password - inputed password
	 * @return
	 * @throws SQLException
	 * @throws ClassNotFoundException
	 */
	public static boolean validateCredentials(String username, String password) throws SQLException, ClassNotFoundException {
		String query = "SELECT * FROM User WHERE Username = ? AND Password = ?";
		List<List<String>> output = Database.SelectQuery(query, username, password);
			
		if(output.size() > 0) return true;
			
		return false;
	}
			

}
