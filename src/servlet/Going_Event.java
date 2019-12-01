package servlet;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import occasion.account.User;
import occasion.event.Event;
import occasion.db.Database;

/**
 * Servlet implementation class Going_Event
 */
@WebServlet("/Going_Event")
public class Going_Event extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Going_Event() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#service(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String Username = request.getParameter("Username");
		String E_ID = request.getParameter("EventID");
		int Event_ID = Integer.parseInt(E_ID);
		User cur_User = new User(Username);
		Event join_Event =  new Event(Event_ID);
		int UserID = cur_User.getUserID();
		
		
		try{
			add_event(UserID,join_Event.getEventID());
			System.out.println("follow user");
		}
		catch (SQLException e){
			e.printStackTrace();
		}
		catch (ClassNotFoundException e){
			e.printStackTrace();
		}
	}
	
	public static void add_event(int UserID, int EventID) throws SQLException, ClassNotFoundException {
		
		String U_ID = Integer.toString(UserID);
		String E_ID = Integer.toString(EventID);
		
		String toinsert = "INSERT INTO Attendance (EventID,UserID,RSVPStatus) VALUES (?, ?, ?)";
		//RSVPStatus: 0: nothing/1: invited/2: invitation accepted & the user will attend/
		Database.UpdateQuery(toinsert, E_ID, U_ID, "2");
		
		toinsert = "UPDATE Event SET size = size + 1 WHERE EventID = ?";
		Database.UpdateQuery(toinsert, E_ID);
	}
}
