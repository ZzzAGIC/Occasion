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
import occasion.event.Event;

/**
 * Servlet implementation class add_post
 */
@WebServlet("/add_post")
public class add_post extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public add_post() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#service(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String text = request.getParameter("post_text");
		String picture = request.getParameter("post_image");
		String event_id = request.getParameter("event");
		
		String next = "/ProfilePage.jsp";
		String error = "";
		HttpSession session = request.getSession();
		String username = (String) session.getAttribute("myname");
		
		if(text =="") {
			error += "Text is empty & ";
			next = "/AddPost.jsp";
		}
		if(picture =="") {
			error += "Picture is empty & ";
			next = "/AddPost.jsp";
		}
		if(event_id =="") {
			error += "event is empty & ";
			next = "/AddPost.jsp";
		}
		

		
		try {
			AddPost(text,picture,event_id,username);
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
	
	
	public static void AddPost(String text, String picture, String eventID, String username) throws SQLException, ClassNotFoundException {
		//get userID
				String searchUser = "SELECT UserID FROM User WHERE Username = ?";
				List<List<String>> curr_ID = Database.SelectQuery(searchUser, username);
				String U_ID = curr_ID.get(0).get(0);
			
		//insert post
		String toinsert = "INSERT INTO Post (Description,Image,EventID,UserID,LikeNum) "
				+ "VALUES (?,?,?,?,?)";
		
		Database.UpdateQuery(toinsert, text,picture,eventID,U_ID,"0");


	}

}
