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

import occasion.db.Database;

/**
 * Servlet implementation class register_validate
 */
@WebServlet("/register_validate")
public class register_validate extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public register_validate() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#service(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
					String Username = request.getParameter("new_username");
					String phone_number = request.getParameter("phone_number");
					String Email = request.getParameter("email");
					String Password1 = request.getParameter("new_userpass1");
					String password2 = request.getParameter("new_userpass2");
					
					String next = "/HomePage.jsp";
					String error = "";
					HttpSession session = request.getSession();
					session.setAttribute("login", false);
					

					if(Username =="") {
						error += "Username cannot be empty & ";
						next = "/Register.jsp";
					}
					if(phone_number =="") {
						error += "phone number cannot be empty & ";
						next = "/Register.jsp";
					}
					if(Email =="") {
						error += "Email cannot be empty & ";
						next = "/Register.jsp";
					}
					if(Password1 =="" || password2 == "") {
						error += "password cannot be empty & ";
						next = "/Register.jsp";
					}
					if(Password1.compareTo(password2)!=0) {
						error += "password does not match ";
						next = "/Register.jsp";
					}
					try {
						if (Register(Username, phone_number, Email, Password1)) {	
							session.setAttribute("login", true);
							session.setAttribute("myname", Username);
						}
						else {
							error += "Username already exist! & ";
							next = "/Register.jsp";
						}
					}
					catch (SQLException e){
						e.printStackTrace();
					}
					catch (ClassNotFoundException e){
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
			    
	public static boolean Register(String Username, String phone_number, String Email, String Password) throws SQLException, ClassNotFoundException {
		
		String tosearch = "SELECT * FROM User WHERE Username = ?";
		List<List<String>> output = Database.SelectQuery(tosearch, Username);
		if(output.size() > 0) return false;
		
		
		String toinsert = "INSERT INTO User (Username,Password,Email, Phone) "
				+ "VALUES (?, ?, ?, ?)";
//		Username,Password, Salt, Premium, Email, Gender, Phone, ProfileImage, Birthday, Points, Status
		
		Database.UpdateQuery(toinsert, Username, Password, Email, phone_number);
		return true;
		
	}
					
    
}
