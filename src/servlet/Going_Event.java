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
		String type = request.getParameter("Type");
		int Event_ID = Integer.parseInt(E_ID);
		User cur_User = new User(Username);
		Event join_Event =  new Event(Event_ID);
		int UserID = cur_User.getUserID();
		

		try{
			if(type.compareTo("Add") == 0) {
				add_event(UserID,join_Event.getEventID());
			}
			else if(type.compareTo("Delete") == 0) {
				delete_event(UserID,join_Event.getEventID());
			}
			response.sendRedirect("/EventPage.jsp");
			
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
		
		//first search from table (get invited or not)
		
		String tosearch = "SELECT * FROM Attendance WHERE EventID = ? AND UserID = ?";
		List<List<String>> output = Database.SelectQuery(tosearch, E_ID, U_ID);
		
		
		//if not invited, insert into Attendance
		if(output.isEmpty()) {
			System.out.println("insert");
			String toinsert = "INSERT INTO Attendance (EventID,UserID,RSVPStatus) VALUES (?, ?, ?)";
			//RSVPStatus: 0: nothing/1: invited/2: invitation accepted & the user will attend/
			Database.UpdateQuery(toinsert, E_ID, U_ID, "2");
		}
		
		
		//if get invited, just update the RSVPStatus
		else {
			System.out.println("update");
			String update_RSVP = "UPDATE Attendance SET RSVPStatus = 2 WHERE EventID = ? AND UserID = ?";
			Database.UpdateQuery(update_RSVP, E_ID, U_ID);
		}
	
		String update_size = "UPDATE Event SET size = size + 1 WHERE EventID = ?";
		Database.UpdateQuery(update_size, E_ID);
	}
	
	public static void delete_event(int UserID, int EventID) throws SQLException, ClassNotFoundException {
		String U_ID = Integer.toString(UserID);
		String E_ID = Integer.toString(EventID);
		
		
		System.out.println("delete");
		String todelete = "DELETE FROM Attendance WHERE EventID = ? AND UserID = ?";
		//RSVPStatus: 0: nothing/1: invited/2: invitation accepted & the user will attend/
		Database.UpdateQuery(todelete, E_ID, U_ID);
		
		
		
		
	}
}