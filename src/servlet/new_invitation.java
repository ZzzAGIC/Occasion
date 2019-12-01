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
 * Servlet implementation class new_invitation
 */
@WebServlet("/new_invitation")
public class new_invitation extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public new_invitation() {
        super();
        // TODO Auto-generated constructor stub
    }

    protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String members [] = request.getParameterValues("members");
		String EventID = request.getParameter("EventID").toString();

		String next = "/EventProfile.jsp";
		String error = "";
		HttpSession session = request.getSession();
		String username = (String) session.getAttribute("myname");
		
//		if(members.length == 1) {
//			error += "Only one member & ";
//			next = "/EventProfile.jsp";
//		}
		
		
		try {
			AddAttendance(members,EventID);
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
	
	
	public static void AddAttendance(String[] MembersID, String EventID) throws SQLException, ClassNotFoundException {
		for(int i = 0; i < MembersID.length; i++) {
			String toinsert = "INSERT INTO Attendance (EventID,UserID,RSVPStatus) "
					+ "VALUES (?, ?, ?)";			
			Database.UpdateQuery(toinsert, EventID ,MembersID[i], "1");
		}
			
		


	}


}
