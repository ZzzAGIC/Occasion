package servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import occasion.account.User;
import occasion.db.Database;
import occasion.event.Event;

/**
 * Servlet implementation class Event_search_validate
 */
@WebServlet("/Event_search_validate")
public class Event_search_validate extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Event_search_validate() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#service(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String selection = request.getParameter("selection");
		String content = null;
		
		String next = "/EventPage.jsp";
		String error = "";
		
		if(selection =="") {
			error += "Search content cannot be empty & ";
			next = "/EventPage.jsp";
		}
		else if(selection.compareTo("EventName") == 0) {
			content = request.getParameter("Event_name");
		}
		else if(selection.compareTo("Type") == 0) {
			content = request.getParameter("EventType");
		}
		
		try {
			List<List<String>> output= SearchEvent(content,selection);
			ArrayList<Event> event = new ArrayList<Event>();
			
			for(List<String> curr_Event : output) {
				event.add(new Event(curr_Event));
			}
			
			if (output.size() > 0) {
				System.out.println("set attributes");
				request.setAttribute("from_search", true);
				request.setAttribute("content", event);
			}
			else if(output.size() == 0){
				error += "Event does not exist! & ";
				next = "/EventPage.jsp";
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
	
	public static List<List<String>> SearchEvent(String content, String type) throws SQLException, ClassNotFoundException {
		
		String tosearch = "SELECT * FROM Event WHERE " + type + " LIKE ?;";
		System.out.println(tosearch);
		content = "%" + content + "%";
		List<List<String>> output = Database.SelectQuery(tosearch, content);
		return output;		
	}
	
}
