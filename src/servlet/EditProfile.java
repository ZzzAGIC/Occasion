package servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import occasion.db.Database;

/**
 * Servlet implementation class EditProfile
 */
@WebServlet("/EditProfile")
public class EditProfile extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public EditProfile() {
        super();
        // TODO Auto-generated constructor stub
    }

	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String next = "ProfilePage.jsp";
		
		HttpSession session = request.getSession(false);
				
		String gender = request.getParameter("genderSearch");
		String email = request.getParameter("emailSearch");
		String phone = request.getParameter("phoneSearch");
		String birth = request.getParameter("birthSearch");
		
		String name = (String)session.getAttribute("myname");
		
		String query = "UPDATE User SET Gender = ?,  Email = ?, Phone = ?, Birthday = ? WHERE Username = ?;";
		Database.UpdateQuery(query, gender, email, phone, birth, name);
        
		response.sendRedirect(next);
	}


}
